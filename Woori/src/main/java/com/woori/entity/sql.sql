select * from TB_LOGIN;

INSERT INTO tb_login
		(login_email, login_nick, login_src, joined_ad, id_key) 
		VALUES ('123', 'nick', 'kakao', SYSDATE, 3662315958);

delete TB_LOGIN where id_key = 3662315958;