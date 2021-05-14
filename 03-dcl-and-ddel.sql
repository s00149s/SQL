-----------------
-- 사용자 관련
-----------------
-- SYSTEM 계정으로 수행--
-- CREATE(생성), ALTER(수정), DROP(삭제) 키워드

-- 사용자 생성
CREATE USER C##JEONGHWA IDENTIFIED BY 1234;
-- 비밀번호 변경
ALTER USER C#JEONGHWA IDENTIFIED BY test;
-- 사용자 삭제
DROP USER C##JEONGHWA;
-- 경우에 따라 내부에 테이블 등 데이터베이스 객체가 생성된 사용자
DROP USER C##JEONGHWA CASCADE;  -- 폭포수

-- 다시 사용자 만들기
CREATE USER C##JEONGHWA IDENTIFIED BY 1234;
-- SQLPLUS로 접속 시도

-- 사용자 생성, 권한 부여되지 않으면 아무일도 할 수 없다

-- 사용자 정보의 확인
-- USER_USERS : 현재 사용자 관련 정보
-- DBA_USERS : 모든 사용자의 상세 정보(DBA 전용)

DESC USER_USERS;
SELECT * FROM USER_USERS;

DESC ALL_USERS;
SELECT * FROM ALL_USERS;

DESC DBA_USERS;
SELECT * FROM DBA_USERS;

-- 사용자 계정에게 접속 권한 부여
GRANT create session TO C##JEONGHWA;
-- 일반적으로 데이터베이스 접속, 테이블 만들어 
-- CONNECT, RESOURCE 틀을 부여
GRANT connect, resource TO C##JEONGHWA;
-- Oracle 12 이상에서는 사용자 테이블 스페이스에 공간 부여 필요
ALTER USER C##JEONGHWA DEFAULT TABLESPACE USERS QUOTA unlimited ON USERS;

-- 시스템 권한의 부여
-- GRANT 권한(역할)명 TO 사용자;
-- 시스템 권한의 박탈
-- REVOKE 권한(역할)명 FROM 사용자;

-- 스키마 객체에 대한 권한의 부여
-- GRANT 권한 ON 객체 TO 사용자;
-- 스키마 객체 권한의 박탈
-- REVOKE 권한 ON 객체 FROM 사용자;
GRANT select ON hr.employees TO C##JEONGHWA;
GRANT select ON hr.departments TO C##JEONGHWA;

-- 이하, 사용자 계정으로 수행
SELECT * FROM hr.employees;
SELECT * FROM hr.departments;

-- System 계정으로 hr.deparments의 select 권한 회수
REVOKE select ON hr.departments FROM C##JEONGHWA;

-- 다시 사용자 계정으로 
SELECT * FROM hr.departments;

------------------------------------
-- DDL
------------------------------------
CREATE TABLE book(  -- 컬럼의 정의
    book_id NUMBER(5),  -- 5자리 정수 타입 -> PK로 변경할 예정
    title VARCHAR2(50), -- 50자리 가변 문자열
    author VARCHAR2(10),    -- 10자리 가변 문자열
    pub_date DATE DEFAULT sysdate   -- 날짜 타입(기본값 - 현재 날짜와 시간)
);
DESC book;

-- 서브 쿼리를 이용한 새 테이블 생성
-- hr.employees 테이블에서 일부 데이터를 추출, 새 테이블 만들어 봅시다
SELECT * FROM hr.employees WHERE job_id LIKE 'IT_%';    -- 서브쿼리의 결과로 새 테이블 생성

CREATE TABLE it_emp AS (
    SELECT * FROM hr.employees
    WHERE job_id LIKE 'IT_%'
);
DESC it_emp;
SELECT * FROM it_emp;

-- 내가 가진 테이블의 목록
SELECT * FROM tab;

-- 테이블 삭제
DROP TABLE it_emp;
SELECT * FROM tab;

-- 휴지통 비우기
PURGE RECYCLEBIN;
SELECT * FROM tab;
