select * from TB_LOGIN;

select * from Tb_pet;

select * from TB_care;

INSERT INTO tb_login
		(login_email, login_nick, login_src, joined_ad, id_key) 
		VALUES ('123', 'nick', 'kakao', SYSDATE, 3662315958);

delete TB_LOGIN;

delete TB_pet;

drop table TB_care;

INSERT INTO tb_pet (pet_name, pet_birthdate, pet_weight, pet_gender, adopted_at, pet_img1, pet_img2, pet_img3, login_email) VALUES ('pet_name 6', '2024-08-13', 5, 'N', sysdate, 'pet_img1 5', 'pet_img2 5', 'pet_img3 5', 'jjw980103@gmail.com');
commit;

CREATE TABLE tb_care
(
    pet_idx        NUMBER(18, 0)    NOT NULL, 
    pet_alergy     VARCHAR2(50)     NULL, 
    pet_food       VARCHAR2(50)     NULL, 
    pet_disease    VARCHAR2(50)     NULL, 
    pet_etc        CLOB             NULL   
);

-- 테이블 Comment 설정 SQL - tb_care
COMMENT ON TABLE tb_care IS '돌봄(애완동물 알러지, 질병, 산책, 식사량)';

-- 컬럼 Comment 설정 SQL - tb_care.pet_idx
COMMENT ON COLUMN tb_care.pet_idx IS '펫 식별자';

-- 컬럼 Comment 설정 SQL - tb_care.pet_alergy
COMMENT ON COLUMN tb_care.pet_alergy IS '알러지';

-- 컬럼 Comment 설정 SQL - tb_care.pet_food
COMMENT ON COLUMN tb_care.pet_food IS '식사량';

-- 컬럼 Comment 설정 SQL - tb_care.pet_disease
COMMENT ON COLUMN tb_care.pet_disease IS '질병';

-- 컬럼 Comment 설정 SQL - tb_care.pet_etc
COMMENT ON COLUMN tb_care.pet_etc IS '특이사항';

-- Foreign Key 설정 SQL - tb_care(pet_idx) -> tb_pet(pet_idx)
ALTER TABLE tb_care
    ADD CONSTRAINT FK_tb_care_pet_idx_tb_pet_pet_ FOREIGN KEY (pet_idx)
        REFERENCES tb_pet (pet_idx) ;
        
