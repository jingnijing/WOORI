from flask import Flask, request, jsonify, send_from_directory, session, render_template, escape, redirect, url_for, current_app
from flask_sqlalchemy import SQLAlchemy
from flask_socketio import SocketIO
import tensorflow as tf
import numpy as np
from tensorflow.keras.preprocessing import image
import os
import cx_Oracle
from flask_session import Session
from datetime import timedelta 
from flask_session import Session
import redis

from flask_cors import CORS

app = Flask(__name__)
CORS(app)
CORS(app, supports_credentials=True)

print("Starting Flask application...") # debug 1

# Flask 애플리케이션 생성 및 설정
app = Flask(__name__)
print("Flask app created.") # debug 2

app.config['SECRET_KEY'] = 'your_secret_key'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(minutes=5)

print("Setting session file directory...") # debug 3 
# 세션 설정 (redis 사용)
app.config['SESSION_COOKIE_DOMAIN'] = None
app.config['SESSION_COOKIE_PATH'] = '/'
app.config['SESSION_TYPE'] = 'redis'
app.config['SESSION_PERMANENT'] = True
app.config['SESSION_USE_SIGNER'] = True  # 세션 데이터를 안전하게 보호
app.config['SESSION_REDIS'] = redis.StrictRedis(host='localhost', port=6379, db=0)

Session(app)

# SocketIO 초기화
print("Initializing SocketIO...") # debug 4
socketio = SocketIO(app)

# Oracle 데이터베이스 설정
username = 'mp_24K_bigdata24_p2_3'
password = 'smhrd3'
dsn = cx_Oracle.makedsn("project-db-campus.smhrd.com", 1523, sid="xe")
print("Oracle DSN created.") # debug 5
app.config['SQLALCHEMY_DATABASE_URI'] = f'oracle+cx_oracle://{username}:{password}@{dsn}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
print("SQLAlchemy initialized.")

# 데이터베이스 모델 정의
class TbChat(db.Model):
    __tablename__ = 'tb_chat'
    chat_idx = db.Column(db.Integer, primary_key=True)
    chat_result = db.Column(db.Text)
    chatting = db.Column(db.Text)
    chat_file = db.Column(db.String(1000))
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp())
    croom_owner = db.Column(db.String(50), nullable=False)

# 모델 로드
model_1 = tf.keras.models.load_model('C:\\Users\\smhrd6\\Desktop\\Woori\\Woori\\model_keratitis_y.h5')
model_2 = tf.keras.models.load_model('C:\\Users\\smhrd6\\Desktop\\Woori\\Woori\\model_keratitis_y1.h5')
models = [model_1, model_2]

# 라벨 정의
labels = ['궤양성 각막염', '비궤양성 각막염', '결막염', '백내장', '질환 없음']

# 이미지 업로드 경로 설정
UPLOAD_FOLDER = 'uploaded_images'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# 이메일을 세션에 저장하고 바로 채팅 페이지를 렌더링하는 엔드포인트
@app.route('/store_email', methods=['POST'])
def store_email():
    data = request.get_json()
    user_email = data.get('email')
    if user_email:
        session["user_email"] = user_email
        session.modified = True  # 세션을 수정된 것으로 표시
        session.permanent = True  # 세션을 영구적으로 유지
        print(f"Stored email in session: {session['user_email']}")
        print(f"Current session content: {dict(session)}") # 세션내용 확인
        print(f"{current_app.template_folder}") # template 안에 chat.html 파일이 있는지 확인하는 debug
        template_path = os.path.join(current_app.template_folder, 'chat.html')
        print(f"Full path to chat.html: {template_path}")

        return render_template('chat.html', user_email=user_email)  # 바로 렌더링
    else:
        return jsonify({'error': 'No email provided'}), 400


# 이미지 파일 제공 엔드포인트
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)

# 예측 결과 제공 엔드포인트
@app.route('/predict', methods=['POST'])
def predict():
    try:
        user_email = request.form.get('email')
        img_file = request.files['file']

        if not img_file or not user_email:
            return jsonify({'error': 'No file uploaded or email missing'}), 400

        # 파일 저장 및 이미지 분석
        img_path = os.path.join(UPLOAD_FOLDER, img_file.filename)
        img_file.save(img_path)
        img = image.load_img(img_path, target_size=(224, 224))
        img_array = image.img_to_array(img)
        img_array = np.expand_dims(img_array, axis=0) / 255.0
        predictions = [model.predict(img_array)[0][1] for model in models]
        max_index = np.argmax(predictions)
        max_probability = predictions[max_index]
        predicted_result = labels[max_index] if max_probability >= 0.5 else '질환 없음'

        # 데이터베이스에 결과 저장
        new_entry = TbChat(chat_file=img_file.filename, chat_result=predicted_result, croom_owner=user_email)
        db.session.add(new_entry)
        db.session.commit()

        img_url = f'/uploads/{img_file.filename}'
        return jsonify({'prediction': predicted_result, 'img_url': img_url})

    except Exception as e:
        print("Error occurred:", str(e))
        return jsonify({'error': str(e)}), 500

# 선택지 기반의 메시지를 처리하는 엔드포인트
@app.route('/send_option', methods=['POST'])
def send_option():
    try:
        print("Request Data:", request.json)
        user_email = request.json.get('email')
        user_option = request.json.get('option')

        if not user_email or not user_option:
            return jsonify({'error': 'Missing option or email'}), 400

        # 데이터베이스에 대화 내용 저장
        new_entry = TbChat(chatting=user_option, croom_owner=user_email)
        db.session.add(new_entry)
        db.session.commit()
    
        # 선택지에 따른 응답 생성
        responses = {
            '올바르게 사진 찍는 방법': "Option 1에 대한 답변입니다.",
            '비궤양성 각막염이란 ?': "Option 2에 대한 답변입니다.",
            '궤양성 각막염이란 ?': "Option 3에 대한 답변입니다.",
            '결막염이란 ?': "Option 4에 대한 답변입니다.",
            '백내장이란 ?': "Option 5에 대한 답변입니다."
        }
        bot_response = responses.get(user_option, "알 수 없는 선택지입니다.")
        return jsonify({'response': bot_response})

    except Exception as e:
        print(f"Error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

# SocketIO 메시지 핸들러
@socketio.on('message')
def handle_message(msg):
    print('Message: ' + msg)
    send(msg, broadcast=True)

# Flask 애플리케이션 실행
if __name__ == '__main__':
    socketio.run(app, debug=True)
