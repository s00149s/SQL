-- Table 생성
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR(100) NOT NULL,
    author_desc VARCHAR(500),
    PRIMARY KEY (author_id)
    );

-- 시퀀스 생성
CREATE SEQUENCE seq_author_id
    START WITH 10   --   PK max 확인 후 넣어주는 것이 가장 적합
    INCREMENT BY 1
    MAXVALUE 100000000000
    NOCACHE;
    
-- TEST INSERT
INSERT INTO author(author_id, author_name)
VALUES(seq_author_id.NEXTVAL, '황순원');
COMMIT;

SELECT * FROM author;

-- TEST INSERT
INSERT INTO author (author_id, author_name)
VALUES(seq_author_id.NEXTVAL, '홍길동');
INSERT INTO author (author_id, author_name)
VALUES(seq_author_id.NEXTVAL, '고길동');

COMMIT;