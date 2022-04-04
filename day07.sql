-- day07


/*
    제약조건 추가하기
    
        형식 1 ]
            
            컬럼이름 데이터타입(길이)
                CONSTRAINT  제약조건이름  PRIMARY KEY
                CONSTRAINT  제약조건이름  REFERENCES 테이블이름(컬럼이름) 
                CONSTRAINT  제약조건이름  UNIQUE
                CONSTRAINT  제약조건이름  NOT NULL
                CONSTRAINT  제약조건이름  CHECK(컬럼이름 IN(데이터1, 데이터2, ...))
                
        형식 2 ]
            
            컬럼이름    데이터타입(길이),
            컬럼이름    데이터타입(길이),
            ..
            CONSTRAINT  제약조건이름  PRIMARY KEY(컬럼이름),
            CONSTRAINT  제약조건이름  UNIQUE(컬럼이름),
            CONSTRAINT  제약조건이름  FOREIGN KEY(컬럼이름)   REFERENCES  테이블이름(컬럼이름),
            CONSTRAINT  제약조건이름  CHECK(컬럼이름 IN(데이터1, 데이터2, ...))  
            
            주의 ]
                컬럼이 만들어진 이후에는 NOT NULL 제약조건은 추가하지 못한다.
                <== 제약조건을 추가하지 않고 테이블을 만들게 되면
                    컬럼들은 NULL 데이터를 허용하는 컬럼으로 만들어진다.
                    따라서 NOT NULL 제약조건은 이런 컬럼의 속성을 수정해야한다.
                    
        형식 3 ]
            제약조건 없이 테이블을 만드는 경우 테이블 수정 명령으로
            제약조건을 추가하는 방법
            
            ALTER TABLE 테이블이름
            AS CONSTRAINT 제약조건이름 제약조건(컬럼이름)
            
*/

CREATE TABLE TMP(
    no NUMBER(2),
    name VARCHAR2(10 CHAR)

);
drop table tmp;
desc tmp;

-- 테이블 이름 변경 명령
ALTER TABLE member
RENAME TO MEMB;

/*
    여러 테이블을 생성할 때
    생성하는 순서는 참조해주는 테이블 부터 생성해야 한다.
    
*/

-- 아바타 테이블
CREATE TABLE avatar(
    ano NUMBER(2),
    aname VARCHAR2(15 CHAR),
    oriname VARCHAR2(50 CHAR),
    savename VARCHAR2(50 CHAR),
    dir VARCHAR2(100 CHAR),
    len NUMBER,
    adate DATE DEFAULT sysdate,
    isshow CHAR(1) DEFAULT 'Y',
    CONSTRAINT AVT_NO_PK PRIMARY KEY(ano),
    CONSTRAINT AVT_SNAME_UK UNIQUE(savename),
    CONSTRAINT AVT_SHOW_CK CHECK(isshow IN('Y', 'N'))

);


-- NOT NULL 제약조건 수정
ALTER TABLE avatar
MODIFY aname
    CONSTRAINT AVT_NAME_NN NOT NULL
;

ALTER TABLE AVATAR
drop CONSTRAINT AVT_NAME_NN;

ALTER TABLE avatar
MODIFY oriname
    CONSTRAINT AVT_ONAME_NN NOT NULL
;

ALTER TABLE avatar
MODIFY savename
    CONSTRAINT AVT_SNAME_NN NOT NULL
;

ALTER TABLE avatar
MODIFY dir
    CONSTRAINT AVT_DIR_NN NOT NULL
;

ALTER TABLE avatar
MODIFY len
    CONSTRAINT AVT_len_NN NOT NULL

;
ALTER TABLE avatar
MODIFY adate
    CONSTRAINT AVT_DATE_NN NOT NULL

;
ALTER TABLE avatar
MODIFY isshow
    CONSTRAINT AVT_SHOW_NN NOT NULL
;

-- 회원테이블 추가
CREATE TABLE MEMBER(
    mno NUMBER(4)
        CONSTRAINT MB_NO_PK PRIMARY KEY,
    name VARCHAR2(20 CHAR)
        CONSTRAINT MB_NAME_NN NOT NULL,
    id VARCHAR2(15 CHAR)
        CONSTRAINT MB_ID_UK UNIQUE
        CONSTRAINT MB_ID_NN NOT NULL,
    pw VARCHAR2(15 CHAR)
        CONSTRAINT MB_PW_NN NOT NULL,
    mail VARCHAR2(50 CHAR)
        CONSTRAINT MB_MAIL_UK UNIQUE
        CONSTRAINT MB_MAIL_NN NOT NULL,
    tel VARCHAR2(13 CHAR)
        CONSTRAINT MB_TEL_UK UNIQUE
        CONSTRAINT MB_TEL_NN NOT NULL,
    avt NUMBER(2) DEFAULT 10
        CONSTRAINT MB_AVT_NN NOT NULL
        CONSTRAINT MB_AVT_FK REFERENCES avatar(ano),
    gen CHAR(1)
        CONSTRAINT MB_GEN_NN NOT NULL
        CONSTRAINT MB_GEN_CK CHECK(gen IN('F', 'M')),
    joindate DATE DEFAULT sysdate
        CONSTRAINT MB_DATE_NN NOT NULL,
    isShow CHAR(1) DEFAULT 'Y'
        CONSTRAINT MB_SHOW_NN NOT NULL
        CONSTRAINT MB_SHOW_CK CHECK(isShow IN('Y', 'N'))
    
);

/*
    등록된 제약조건 확인하는 방법
    ==> 등록된 제약조건은 오라클이 테이블을 이용해서 관리한다.
        이 테이블 이름이 USER_CONSTRAINTS 이다.
        
        따라서 이 테이블에 내용을 확인하면 등록된 제약조건을
        확인할 수 있다.
        
        참고 ]
            CONSTRAINT_TYPE
            
                P   -   PRIMARY KEY
                R   -   FOREIGN KEY
                U   -   UNIQUE
                C   -   NOT NULL, CHECK
                
---------------------------------------------------------------
    제약조건 삭제하기
    
    형식 ]
        
        ALTER TABLE 테이블이름
        DROP CONSTRAINT 제약조건 이름;
        
    참고 ]
        기본키(PRIMARY KEY)의 경우는 제약조건 이름을 몰라도 삭제할 수 있다.
        기본키는 테이블에 오직 한개만 만들어지기 때문이다.
        
        형식 ]
        ALTER TABLE 테이블
        DROP PRIMARY KEY;

*/

DESC USER_CONSTRAINTS;

-- 아바타 테이블의 제약조건 조회
SELECT
    constraint_name 제약조건이름, constraint_type 제약조건, table_name 테이블이름
FROM
    user_CONSTRAINTS
WHERE
    table_name IN('AVATAR', 'MEMBER')
;

-- 회원테이블 기본키 제약조건 삭제
ALTER TABLE member
DROP PRIMARY KEY;

-- 기본키 추가
ALTER TABLE MEMBER
ADD CONSTRAINT MB_NO_PK PRIMARY KEY(mno);

-- tmp테이블 생성
CREATE TABLE TMP(
    no NUMBER(4)
);

/*
    테이블 수정하기
        1) 필드 추가하기
        
            형식 ]
                ALTER TABLE 테이블이름
                ADD (
                    필드이름    데이터타입(길이)
                        CONSTRAINT 제약조건이름 제약조건
                );
        2) 필드 이름 변경하기
        
            형식 ]
                ALTER TABLE 테이블이름
                RENAME COLUMN 필드이름 TO 바뀔이름;
                
-----------------------------------------------------------------------
        3) 필드 길이 변경하기
            
            형식 ]
                ALTER TABLE 테이블이름
                MODIFY 필드이름 데이터타입(길이);
                
            참고 ]
                DEFAULT 값 추가
                ALTER TABLE 테이블이름
                MODIFY 필드이름 DEFAULT 데이터;
            
            *****    
            참고 ]
                길이변경은 현재 길이보다 늘이는 것은 가능하지만
                줄이는것은 불가능하다.
                <== 이미 입력되어 있는 데이터가 수정된 길이를 넘어설 수 있기 때문에
        
        4) 필드 삭제하기
            형식 ]
                ALTER TABLE 테이블이름
                DROP COLUMN 필드이름;
                
--------------------------------------------------------------------------------
    
    테이블 이름 변경하기
        
        형식 ]
            
            ALTER TABLE 테이블이름
            RENAME TO 변경될 테이블 이름;
            
-------------------------------------------------------------------------------

    테이블 삭제하기
        참고 ]
            테이블 내의 모든 데이터도 같이 삭제된다.
            
        형식 1 ]
            DROP TABLE 테이블이름;
            
        형식 2 ]
            DROP TABLE 테이블이름 purge;
            ==> 휴지통에 넣지 말고 완전 삭제하세요.
            
        참고 ]
            DML 명령은 복구가 가능하지만
            DDL 명령은 복구가 원칙적으로 불가능하다.
            
        참고 ]
            10g 부터 휴지통 개념을 추가해서
            삭제된 데이터를 휴지통에 보관하도록 하고 있다.
            
        휴지통 관리 ]
            
            1. 휴지통에 있는 모든 데이터를 완전 지우기
                
                purge recyclebin;
                
            2. 휴지통에 있는 특정 테이블만 완전 삭제
            
                purge table 테이블이름;
                
            3. 휴지통 확인하기
                
                show recyclebin;
                
            4. 휴지통의 테이블 복구하기
            
                flashback table 테이블이름 to before drop;
            
                
*/

-- TMP 테이블에 NAME 필드 추가
ALTER TABLE TMP 
ADD(
    NAME VARCHAR2(10 CHAR)
        CONSTRAINT TMP_NAME_NN NOT NULL
);

-- TMP 테이블의 no 필드에 기본키 제약조건 추가
ALTER TABLE TMP
ADD CONSTRAINT TMP_NO_PK PRIMARY KEY(no);

-- no를 tno로 변경하자
ALTER TABLE TMP
RENAME COLUMN no TO tno;

-- 휴지통 확인
show recyclebin;

-------------------------------------------------------------------------------
/*
    TRUNCATE
    ==> DML 명령 중 DELETE 명령과 같이
        테이블 안에 있는 모든 데이터를 삭제하는 명령
        
    형식 ]
        TRUNCATE TABLE 테이블이름;
        
    참고 ]
        DELETE 명령은 DML 소속이고
        ==> 복구가 가능하다.
        TRUNCATE 명령은 DDL 소속 명령
        ==> 복구가 불가능하다.
*/

/*
    무결성 체크
    ==> 데이터베이스는 프로그램등 전산에서 작업할 때 필요한 데이터를
        제공해주는 보조 프로그램이다.
        따라서 데이터베이스가 가진 데이터는 항상 완벽한 데이터여야 한다.
        그런데 데이터를 입력하는 것은 사람의 몫이고
        따라서 완벽한 데이터를 보장할 수 없게 되었다.
        
        각각의 테이블에 들어가서는 안될 데이터나
        빠지면 안되는 데이터등을 미리 결정해놓고
        데이터를 입력하는 사람이 잘못 입력하면
        그 데이터는 아예 입력되지 못하도록 방지하는 역할을 하는 기능이다.
        
        한마디로 정리하자면
            이상데이터가 입력되는 것을 방지하는 기능이다.
            
        따라서 이 기능은 반드시 필요한 기능은 아니다.
        ( ==> 입력하는 사람이 정신 바짝차리고 입력하면 될 일이기 때문에)
        실수를 미연에 방지할 수 있도록 하는 기능이다.
        
*/

/*
    참고 ]
        테이블을 생성하는 명령으로
        서브질의를 결과를 이용해서 테이블을 만드는 방법도 있다.
        
        CREATE TABLE 테이블이름
        AS 
            서브질의
        ;
    
    참고 ]
        이렇게 복사하게 되면 모든 데이터와 테이블의 구조를 복사할 수 있지만
        NOT NULL 제약조건을 제외한 모든 제약 조건은
        복사해오지 않는다.
    
    참고 ]
        이때 복사할 테이블의 구조만 복사하고 싶은 경우
        CREATE TABLE 테이블이름
        AS
            SELECT * FROM 테이블이름 WHERE 1 = 2;
*/

-- member 테이블의 모든 내용을 복사해서 memb02 테이블을 만들어보자
CREATE TABLE memb02
AS
    SELECT * FROM member
    ;

ALTER TABLE memb02
ADD CONSTRAINT MB02_NO_PK PRIMARY KEY(mno);


-- SCOTT.EMP
SELECT
    ename, job, hiredate, deptno
FROM
    emp
WHERE
    ename = 'SMITH'
;

SELECT
    ename, job, hiredate, deptno
FROM
    emp
WHERE
    1 = 2
;

-- INSERT 명령에 서브질의를 사용할 수 있다.
/*
    형식 ]
        INSERT INTO 테이블이름
            서브질의
        ;
*/

-- emp테이블에 사원중 부서번호가 10번인 사원들의 데이터만 복사하세요
INSERT INTO emp2
    SELECT  * FROM emp WHERE deptno = 10 ;
    
    
------------------------------------------------------------------------------

/*
    DCL(Data Control Language)
    
        트랜젝션 처리
        ==> 교과서적인 의미로
            오라클이 처리(실행)하는 명령 단위를 의미한다.
            
            우리가 테이블을 만들때 create 명령을 치고 엔터키를 누르면
            그 명령을 실행하게 되는데
            이것을 "트랜젝션이 실행되었다." 라고 표현한다.
            
            위와같이 대부분의 명령은 엔터키를 누르는 순간
            명령이 실행되고 그것은 곧 트랜젝션이 실행된 것이므로
            결국 오라크클은 명령 한줄이 곧 하나의 트랜젝션이 된다.
            
            그런데 DML 명령만큼은 트랜젝션의 단위가 달라진다.
                참고 ]
                    DML 명령 : INSERT, UPDATE, DELETE
            ==> DML 명령은 곧장 실행되는 것이 아니고
                버퍼 장소(임시 기억장소)에 그 명령을 모아만 놓는다.
                ==> 결국 트랜젝션이 실행되지 않는다.
                
            따라서 DML 명령은 강제로 트랜젝션 실행 명령을 내려야 한다.
            이 때 트랜젝션 한번만 일어나게 된다.
            
            왜?
                <==
                DML 명령은 데이터를 변경하는 명령이다.
                데이터베이스에서 가장 중요한 개념은 무결성인데
                이런곳에서 DML 명령이 한순간 트랜젝션 처리가 된다면
                데이터의 무결성이 깨질 수 있다.
                이런 문제점을 해결하기 위한 목적으로
                트랜젝션 방식을 변경해 놓았다.
                
            그런데
            버퍼에 모아놓은 명령을 트랜젝션 처리하는 방법
                
                자동 트랜젝션 처리
                    1. sqlplus를 정상적으로 종료하는 순간 트랜젝션 처리가 일어난다.
                        ==> exit 명령으로 세션을 정상적으로 닫는 순간 트랜젝션 처리가 일어난다.
                        
                    2. DDL명령이나 DCL명령이 내려지는 순간 
                                       
                수동 트랜젝션 처리
                    3. commit 이라고 강제로 명령을 내리는 순간
                    
                참고 ]
                    버퍼에 모아놓은 명령이 실행되지 않는 순간
                    ==> 트랜젝션 처리가 되지 못하고 버려지는 경우
                    
                    자동
                        1. 정전등에 의해서 시스템이 셧다운 되는 순간
                        2. sqlplus를 비정상 종료하는 순간
                    
                    수동
                        3. rollback 이라고 명령을 내리는 순간
        
    *****    
    결론적으로
    DML 명령을 내린 후 다시 검토해서 완벽한 명령이라고 판단되면
    COMMIT이라고 명령해서 트랜젝션을 발생시키고
    만약 검토과정 중 오류가 발견되면 
    ROLLBACK 이라는 명령으로 잘못된 명령을 취소하도록 한다.
    
    책갈피 만들기
        SAVEPOINT 적당한이름;
        
    이것을 사용해서 ROLLBACk 하는 방법
    
        ROLLBACK TO SAVAPOINT이름;
        
    예 ]
        SAVEPOINT a;
            DML (1)
            DML (2)
            DML (3)
        SAVEPOINT b;
            DML (4)
            DML (5)
            DML (6)
        SAVEPOINT c;
            DML (7)
            DML (8)
            DML (9)
            
        ROLLBACK TO c;  7, 8, 9만 취소
        ROLLBACK TO b;  4, 5, 6, 7, 8, 9가 취소
        ROLLBACK TO a;  1, 2, 3, 4, 5, 6, 7, 8, 9가 취소
        
    참고 ] 
        트랜젝션이 처리되면 SAVEPOINT는 자동 파괴된다.
        
        
        
*/
ALTER TABLE EMP2
ADD CONSTRAINT EMP2_NO_PK PRIMARY KEY(empno);


--------------------------------------------------------------------------------
/*
    뷰(VIEW)
    ==>
        교과서적인 의미로
        질의 명령의 결과를 하나의 창문으로 바라볼 수 있는 창문을 의미
        
        예 ]
            SELECT * FROM emp;
            ==> 이렇게 질의명령을 실행하면 결과가 발생하는데
                그 결과중에서 일부분만 볼 수 있는 창문을 만들어서 사용하는 것.
                
        테이블과 유사하지만 테이블과 다른 점은 물리적으로 데이터베이스에
        필드들이 만들어져 있지 않다는 것이다.
        
    ==> 자주 사용하는 복잡한 질의명령을 따로 저장해 놓고
        이 질의명령의 결과를 손쉽게 처리할 수 있도록 하는 것.
        
    뷰의 종류
        1. 단순뷰
            ==> 하나의 테이블만 이용해서 만들어진 뷰
                DML 명령(INSERT, UPDATE, DELETE)이 원칙적으로 가능하다.
                
        2. 복합뷰
            ==> 두개 이상의 테이블을 이용(조인)해서 만들어진 뷰
                DML 명령의 사용이 불가능하다.
                ==> 그냥 보기만 하세요(SELECT 명령만 사용 가능)
                
-------------------------------------------------------------------------------                
    참고 ]
        원칙적으로 사용자 계정은 관리자가 허락한 일만 할 수 있다.
        그런데 뷰를 만드는 권한은 아직 부여되어있지 않다.
        따라서 권한을 부여하고 뷰를 만들어야 한다.
        
        권한 부여하는 방법 - 관리자 계정에서(SYSTEM) 부여
        
            GRANT 권한이름, 권한이름, ... TO 계정이름;
-------------------------------------------------------------------------------

    뷰를 만드는 방법
        
        형식 1 ]
            CREATE[ OR REPLACE] VIEW 뷰이름
            AS
                서브질의;
                
        참고 ]
            뷰를 확인하는 방법
            오라클에서는 뷰를 관리하는 테이블이 존재하고 그 테이블에서 관리한다.
            그 테이블 이름이 USER_VIEWS 이다.
            
        형식 2 ]
            ==> DML 명령으로 데이터를 변경할 때
                변경된 데이터는 기본 테이블만 변경되므로
                뷰 입장에서 보면 그 데이터를 실제로 사용할 수 없을 수 있다.
                
                CREATE [OR REPLACE] VIEW 뷰이름
                AS
                    질의명령
                WITH CHECK OPTION;(where 절에 걸리는 내용만 수정을 못하도록)
                
        형식 3 ]
            ==> 뷰를 이용해서 데이터를 변경하면
                뷰를 사용하는 데이터만 변경 가능하다.
                이것은 원본 테이블의 입장에서는 문제가 발생할 수 있다.
                뷰를 통해서 데이터를 수정하지 못하도록 방지하는 형식
                
                CREATE OR REPLACE VIEW 뷰이름
                AS
                    질의명령
                WITH READ ONLY;

--------------------------------------------------------------------------------
    참고 ]
        원래 뷰는 기본 테이블이 있고 그것을 바라보는 창문을 만드는 개념이다.
        그런데 기본테이블이 없어도 뷰를 만들수 있다.
        
        형식 ]
            CREATE OR REPLACE FORCE VIEW 뷰이름
            AS
                질의명령
            ...
            ;
            
        참고 ]
            진짜로 테이블이 없이 뷰가 작동되는 것은 아니다.
            테이블은 필요한데
            이 명령을 내리는 순간만 없는 경우에 급할 때 사용하는 방법
            나중에 테이블이 만들어지면 그때 데이터를 불러오게 된다.

-------------------------------------------------------------------------------

    VIEW 삭제
        
        형식 ]
            
            DROP VIEW 뷰이름;
*/
-- 관리자 계정(SYSTEM)에서 작업
    GRANT CREATE VIEW TO scott;

    GRANT CREATE VIEW TO jennie;

CREATE VIEW dnosal
AS 
    SELECT
        deptno dno, max(sal) max, min(sal) min, sum(sal) sum, avg(sal) avg, count(*) cnt
    FROM
        emp
    GROUP BY
        deptno
;

-- 사원들의 사원이름, 부서번호, 부서최대급여, 부서원수를 조회하세요.
SELECT
    ename 사원이름, deptno 부서번호, max 부서최대급여, cnt 부서원수
FROM
    emp, dnosal
WHERE
    deptno = dno
;

-- USER_VIEWS 구조확인
DESC USER_VIEWS;

SELECT * FROM USER_VIEWS WHERE VIEW_NAME = 'DNOSAL';

-- emp테이블의 사원들의 사원번호, 사원이름, 부서번호, 부서이름, 부서위치를 조회하는 뷰(EMP_DNO)를 만드세요
CREATE VIEW EMP_DNO
AS
    SELECT
        empno , ename , e.deptno , dname , loc 
    FROM
        emp e, dept d
    WHERE
        e.deptno = d.deptno
;
-- 데이터 추가(두 테이블을 조인해서 만든 복합뷰이므로 DML 명령을 사용 할 수 없다.)
INSERT INTO
    emp_dno
VALUES(
    8000, 'JENNIE', 40, OPERATIONS, BOSTON
);

SELECT
    *
FROM
    EMP_DNO

;

SELECT
    *
FROM
    USER_VIEWS
WHERE
    VIEW_NAME = 'EMP_DNO'
;

/*
    문제 2 ]
        10번 부서 사원들의 사원번호, 사원이름, 급여, 커미션을 조회하는 뷰(DNO10)을 만드세요.
        
*/
CREATE OR REPLACE VIEW DNO10
AS
    SELECT
        empno , ename , sal , comm 
    FROM
        emp
    WHERE
        deptno = 10
;

-- 제니 사원이 입사했습니다.
INSERT INTO
    dno10
VALUES(
    8000, 'JENNIE', 7000, 10000
);



SELECT
    *
FROM
    DNO10
;

rollback;

-- emp 테이블을 복사해서 EMPLOYEE 테이블을 만드세요
-- 기본키 제약조건과 참조키 제약조건을 추가하세요
CREATE TABLE EMPLOYEE
AS
    SELECT
        *
    FROM
        emp
        ;
        
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMPLOYEE_NO_PK PRIMARY KEY(empno);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMPLOYEE_DEPTNO_FK FOREIGN KEY (deptno) REFERENCES dept(deptno); 
/*
    문제 3 ]
       EMPLOYEE 테이블의 10번 부서 사원들의 사원번호, 사원이름, 급여, 커미션, 부서번호를 조회하는 뷰(DNO10)을 만드세요.
       뷰를 만드는 조건으로 사용되는 컬럼의 데이터는 수정하지 못하도록 하세요
       
        
*/
CREATE OR REPLACE VIEW DNO10
AS SELECT
    empno, ename, sal, comm, deptno
    FROM
        EMPLOYEE
    WHERE
        deptno = 10
    WITH CHECK OPTION
    ;

-- DNO10 조회

SELECT
    *
FROM
    dno10;
    
-- CLARK의 커미션을 500으로 인상하세요
UPDATE
    dno10
SET
    comm = NVL(comm + 500, 500)
WHERE
    ename = 'CLARK'
;

-- KING 사원의 부서번호를 40번으로 수정하세요(에러가 발생)
UPDATE
    dno10
SET
    deptno = 40
WHERE
    ename = 'KING'
;

UPDATE
    employee
SET
    deptno = 40
WHERE
    ename = 'KING'
;
rollback;

-- 게시판 테이블(BOARD)의 글번호, 작성자번호, 글제목, 작성일, 클릭수를 조회하는 뷰를 작성하세요
CREATE OR REPLACE FORCE VIEW brdlist
AS
    SELECT
        bno, bmno, title, wdate, click
    FROM
        board
    
;

-- brdlist 삭제
DROP VIEW brdlist;