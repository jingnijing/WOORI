select * from TB_LOGIN;

select * from Tb_pet;

INSERT INTO tb_login
		(login_email, login_nick, login_src, joined_ad, id_key) 
		VALUES ('123', 'nick', 'kakao', SYSDATE, 3662315958);

delete TB_LOGIN;

INSERT INTO tb_pet (pet_name, pet_birthdate, pet_weight, pet_gender, adopted_at, pet_img1, pet_img2, pet_img3, login_email) VALUES ('pet_name 1', sysdate, 1, 'N', sysdate, 'pet_img1 1', 'pet_img2 1', 'pet_img3 1', 'login_email 1');
INSERT INTO tb_pet (pet_name, pet_birthdate, pet_weight, pet_gender, adopted_at, pet_img1, pet_img2, pet_img3, login_email) VALUES ('pet_name 2', sysdate, 2, 'N', sysdate, 'pet_img1 2', 'pet_img2 2', 'pet_img3 2', 'login_email 2');
INSERT INTO tb_pet (pet_name, pet_birthdate, pet_weight, pet_gender, adopted_at, pet_img1, pet_img2, pet_img3, login_email) VALUES ('pet_name 3', sysdate, 3, 'N', sysdate, 'pet_img1 3', 'pet_img2 3', 'pet_img3 3', 'login_email 3');
INSERT INTO tb_pet (pet_name, pet_birthdate, pet_weight, pet_gender, adopted_at, pet_img1, pet_img2, pet_img3, login_email) VALUES ('pet_name 4', sysdate, 4, 'N', sysdate, 'pet_img1 4', 'pet_img2 4', 'pet_img3 4', 'login_email 4');
INSERT INTO tb_pet (pet_name, pet_birthdate, pet_weight, pet_gender, adopted_at, pet_img1, pet_img2, pet_img3, login_email) VALUES ('pet_name 5', sysdate, 5, 'N', sysdate, 'pet_img1 5', 'pet_img2 5', 'pet_img3 5', 'jjw980103@gmail.com');
commit;