----------------------
-- DB OBJECTS
----------------------

-- SYSTEM 계정 CERATE VIEW 권한 부여
GRANT CREATE VIEW TO C##JEONGHWA;
-- 사용자 계정으로 복귀

-- SimpleView
-- 단일 테이블, 함수나 연산식을 포함하는 컬럼이 없는 단순 뷰
DROP TABLE emp123;  -- 원래 있던 테이블 삭제 
CREATE TABLE emp123
    AS SELECT * FROM hr.employees
        WHERE department_id IN (10, 20, 30);
SELECT * FROM emp123;   -- 테이블 재생성

-- emp123 테이블을 기반으로 30번 부서 사람들만 보여주는 View 생성
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id = 10;
        
DESC emp10;

-- View는 테이블처럼 SELECT 할 수 있다(실제로 데이터를 갖고 있진 않음)
-- 다만 실제 데이터는 원본 테이블 내에 있는 데이터를 출력

SELECT * FROM emp10;
SELECT first_name || ' ' || last_name, salary FROM emp10;

-- Simple View는 제약 사항에 위배되지 않는다면 내용을 갱신할 수 있다
-- 모든 사원들의 salary 를 2배로 올려보기
SELECT first_name, salary FROM emp10;
UPDATE emp123 SET salary = salary * 2;

SELECT first_name, salary FROM emp10;   -- 실제 테이블 emp123에서 데이터가 갱신됨
SELECT first_name, salary FROM emp123;  
ROLLBACK;

-- VIEW는 가급적 조회용으로만 사용하도록 하자
-- READ ONLY 옵선을 부여하여 VIEW 생성
CREATE OR REPLACE VIEW emp10
    AS SELECT employee_id, first_name, last_name, salary
        FROM emp123
        WHERE department_id=10
    WITH READ ONLY;

SELECT * FROM emp10;
UPDATE emp10 SET salary = salary* 2;    -- 읽기 전용 뷰에서는 DML작업 수행 불가

-- 복합 뷰
DESC author;
DESC book;

-- author와 book을 join  정보를 출력하는 복합 뷰
CREATE OR REPLACE VIEW book_detail
    (book_id, title, author_name, pub_date)
    AS SELECT book_id,
                title,
                author_name,
                pub_date
        FROM book b, author a 
        WHERE b.author_id = a.author_id;

DESC book_detail;

SELECT * FROM book_detail;

UPDATE book_detail SET author_name = 'Unkown';
-- 복합 뷰에서는 기본적으로 DML 수행할 수 없다