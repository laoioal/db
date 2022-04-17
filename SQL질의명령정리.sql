/*
    데이터 조회 명령
    
        SELECT
            컬럼이름들... 콤마로 구분해서 나열한다.
        FROM
            테이블이름들... 콤마로 구분해서 나열
        [WHERE
                    ]
        [GROUP BY
        
        [HAVING
                    ]]
        [ORDER BY
                    ]
--------------------------------------------------------------------------------                    

        ORDER BY
            필드이름 [ASC || DESC], 필드이름 [ASC || DESC], ....

        
    참고 ]
        ASC : 오름차순 정렬
        DESC : 내림차순 정렬

--------------------------------------------------------------------------------

    GROUP BY
    ==> 그룹 함수에 적용되는 그룹을 지정하는 것.
        조회를 할때 대상을 그룹핑을 해서 조회하는 방법
        
        예 ]
            부서별로 급여의 합계를 구하고 싶다.
            직급별로 급여의 평균을 조회하고 싶다.
        
        형식 ]
            SELECT
                그룹함수, 그룹기준필드
            FROM
                테이블이름
            [WHERE
                조건식]            
            GROUP BY
                필드이름
            [HAVING
                조건]
            ORDER BY
                필드이름..
                
        참고 ]
            GROUP BY를 사용하는 경우에는
            GROUP BY에 적용된 필드는 같이 조회할 수 있다.
--------------------------------------------------------------------------------

    HAVING
    ==> 그룹화 한 경우 계산된 그룹중에서 출력에 적용될 그룹을 지정하는 조건식을 기술하는 절
    
        ***
        참고 ]
            WHERE 조건절은 계산에 포함된 데이터를 선택하는 조건절
            HAVING 조건은 그룹화해서 계산한 후 출력할지 말지를 결정하는 조건절
            
        *****
        참고 ]
            WHERE절 안에서는 그룹함수를 사용할 수 없다.
            하지만 HAVING절 안에서는 그룹함수를 사용할 수 있다.
--------------------------------------------------------------------------------
    ANSI JOIN
    ==> 질의명령은 데이터베이스(DBMS)에 따라서 약간씩 그 문법이 달라진다.
    
        ANSI 형식이란
        미국 국립 표준 협회(ANSI)에서 공통의 질의명령을 만들고자 해서 통일된 방식의
        명령을 만들어 놓은 것
        따라서 DBMS를 가리지 않고 실행이 된다.
        
    -------------------------------------------------------------------------
    1. Cross Join
        ==> 오라클의 Cartesion Product를 생성하는 조인
        
        형식 ]
            SELECT
                필드이름, ...
            FROM
                테이블1 CROSS JOIN 데이블2
            ;
    2. Inner Join
        ==> Equi Join, Non Equi Join, Self Join
        
        형식 ]
            SELECT
                 필드이름, ...
            FROM
                테이블1 [INNER] JOIN 테이블2
            ON
                조인조건
            ;
            
        참고 ]
            조인조건은 ON절에서 기술하고
            일반조건은 WHERE 절에서 기술한다.
            
        참고 ]
            INEER JOIN이 가장 일반적인 조인이기 때문에 INNER라는 단어를 생략하면
            INNER JOIN으로 해석해서 실행하게 된다.
            
    3. Outer Join
        ==> Cartesion Product 에 없는 결과를 조회하는 조인 명령
        형식 ]
            SELECT
                필드이름, ...
            FROM
                테이블1 LEFT 또는 RIGHT 또는 FULL OUT JOIN 테이블2
                ==> 이때 방향은 데이터가 있는 테이블 방향을 기술하면 된다.
            ON
                조인조건
            ;
            
        참고 ]
            조인이 2개이상 되는 경우에는
            형식 ]
                
                SELECT
                
                FROM
                    테이블이름
                JOIN
                    테이블2
                ON
                    조인조건
                JOIN
                    테이블3
                ON  
                    조인조건2

--------------------------------------------------------------------------------
    NATURAL JOIN
    ==> 자동 조인
        반드시 조인 조건식에 사용하는 필드의 이름이 동일하고
        반드시 동일한 필드가 한개일때 사용 할 수 있는 조인
        자동으로 중복되는 필드를 사용해서 조인을 하기 때문에
        조인조건을 기술하지 않는다.
        
        형식 ]
            SELECT
                필드이름, ...
            FROM
                테이블1
            NATURAL JOIN
                테이블2
            ;
            
    USING JOIN
    ==> 반드시 조인 조건식에 사용하는 필드의 이름이 동일한 경우
        그리고 같은 이름의 필드가 여러개 존재해도 무방하다.
        
        형식 ]
            SELECT
                필드이름, ...
            FROM
                테이블1
            JOIN
                테이블2
            USING
                (조인에 사용할 필드 이름)
--------------------------------------------------------------------------------
    부질의(SUB QUERY, 서브질의)
    ==> 질의명령 안에 다시 질의명령을 포함하는 경우
        포함되는 그 질의명령을 서브질의 또는 서브쿼리라고 부른다.
        
        예 ]
            이름이 SMITH인 사원과 같은 부서에 있는 사원들의 정보를 조회하세요
            ==> 이 경우 SMITH의 부서번호를 알아내기 위해서 먼저 질의명령이 실행되어야 한다.
            
            ==> 꺼내온 부서번호를 이용해서 정보를 조회
            
            이때 위의 질의명령을 아래 메인질의명령에서 조회해서 사용해야 한다.
           
    참고 ]
        이때 서브질의를 감싸는 질의명령을 메인 질의 명령이라 부른다.
        
    서브질의의 위치에 따른 결과
        1. SELECT 절
        ==> 이 부분에 사용되는 질의명령은 결과가 반드시 한행, 한필드가 나와야 한다.
        
        2. FROM 절
        ==> FROM 절에는 테이블이 나열되어야 한다.
            그런데 조회질의 명령의 결과는 마치 테이블과 같다.
            그러면 이 조회 질의명령의 결과를 테이블처럼 사용할 수 있는 방법
            
            이때 FROM절 안에 들어가는 서브질의를 
            특별히 마치 테이블과 같다 해서
                INLINE TABLE
            이라고 부른다.
                
            이때 사용은 질의명령을 보낼때 사용한 별칭을
            사용해서 데이터를 꺼내야 한다.
        
        3. WHERE 절
            1. 단일행 단일필드로 결과가 발생하는 경우
            ==> 결과를 비교에 사용하면 된다.
            2. 다중행 단일필드로 결과가 발생하는 경우
                참고 ]
                    서브질의의 결과가 다중행 단일필드로 결과가 발생하는 경우
                    이때 사용하는 연산자
                    
                    IN  : 여러개의 데이터중 하나만 맞으면 되는 경우
                        ==> 묵시적으로 여러값중 하나와 동등비교처리를 한다.
                    ANY : 여러개의 데이터 중 하나만 맞으면 되는 경우
                        ==> 대소비교 연산자도 사용가능
                    ALL : 여러개의 데이가 모두 맞으면 되는 경우
                        ==> 동등비교는 사용할 수 없고
                            대소비교할 때 사용한다.
                  
                    
            3. 다중행 다중필드로 결과가 발생하는 방법    
            
                    EXISTS  : 질의명령의 결과가 있으면 참, 없으면 거짓
                    

--------------------------------------------------------------------------------
-- 계층형 질의 


    댓글형 게시판의 경우
    목록을 꺼내올때 상위글 바로 다음에
    그 글의 댓글이 조회가 되어야 한다.
    
    오라클의 경우는
    계층형 결과를 볼수 있는 문법을 만들어서 제공해주고 있다.
    
    형식 ]
        SELECT
        
        FROM
        
        START WITH
            계층 추적 시작 값
        CONNECT BY
            계층 추적 조건
        ORDER SIBLINGS BY
            계층간 정렬
        
        참고 ]
            PRIOR : "이전" 이란 의미로
                    이전 계층을 의미 

-- 사원들을 조회하는데 사장부터 계층으로 조회하세요
SELECT
    empno, ename, job, mgr, LEVEL
FROM
    emp
START WITH
    mgr IS NULL
CONNECT BY
    MGR = PRIOR empno
ORDER SIBLINGS BY  
    hiredate DESC
;

--------------------------------------------------------------------------------
    1. INSERT
        ==> 이미 만들어진 테이블에 데이터를 추가하는 명령
    
            형식 ]
                INSERT INTO 
                    테이블이름[(필드이름1, 필드이름2, ...)]
                VALUES(
                    테이블이 가지는 모든 필드의 데이터
                    만약 필드이름을 지정해 놓으면
                    위에서 지정한 순선대로 필드에 해당하는 데이터를 입력해야한다.
                );
                
            주의 ]
                입력을 할때는 필드의 순서에 맞게
                반드시 데이터의 갯수와 순서를 일치시켜서 입력해야 한다.
                
        참고 ]
            만약 데이터가 준비되지 않아서 데이터가 부족할 경우에는
                1.  NULL로 그 부분을 대신 채우면 된다.
                
                2. 필드이름을 지정할 때 생략하면 된다.
                
        필드에 설정된 디폴트 값으로 입력되게 하려면
        필드를 나열할때 생략하면 된다.

INSERT INTO
    emp1
VALUES(
    1001, '제니', '사장', null, sysdate, 300, 116, 99
);


-- emp 테이블에 둘리 사원을 입력하는데 사원의 입사일은 현재시간으로 하고
-- 부서는 50번 부서를 입력하세요.
INSERT INTO
    emp(empno, ename, hiredate, deptno)
VALUES(
    (
        SELECT
            MVL(MAX(empno) + 1, 1001)
        FROM
            emp
        
    ),
    '둘리', sysdate, 50
);
--------------------------------------------------------------------------------
    2. UPDATE
        ==> 기존 데이터의 내용을 수정하는 명령
        
        형식 ]
            UPDATE
                테이블이름
            SET
                필드이름 = 데이터,
                필드이름 = 데이터,
                ...
            [WHERE
                조건식
            ]
            
        ***
        참고 ]
            WHERE 조건절이 없는 경우는 
            모든 데이터가 같은 내용으로 수정된다.
            
UPDATE
    emp2
SET
    job = '메니저'
;

--------------------------------------------------------------------------------
-- 서브질의를 사용해서 데이터를 수정할 수 있다.
-- 이때 여러개의 필드를 동시에 질의명령의 결과로 대체하고자 한다면
    
    형식 ]
        UPDATE
        
        SET
            (필드1, 필드2) = (
                                SELECT
                                    꺼낼필드1, 꺼낼필드2
                                FROM
                                    테이블이름
                                WHERE
                                    조건식
                                )
            
        WHERE
            조건식
            
    참고 ]
        만약 수정을 원하지 않은 데이터를 반드시 써야한다면
        현재 데이터를 그대로 사용해도 된다.

-- 로제의 직급과 급여를 emp 테이블의 SMITH사원의 데이터를 복사해서 수정하세요
UPDATE
    emp2
SET
    (job, sal) = (
                    SELECT
                        job, sal + 300
                    FROM
                        emp
                    WHERE
                        ename = 'SMITH'
                    )
WHERE
    ename = '로제'
;


UPDATE -- 수정을 꼭 해야하나 값이 바뀌면 안되는 경우 아래처럼 동일한 값을 넣어주면 된다.
    emp2
SET
    sal = sal,
    job = job
WHERE
    ename = '로제'
;
--------------------------------------------------------------------------------
    DELETE
    ==> 현재 데이터중에서 필요하지 않는 데이터를 삭제하는 명령
        한 행을 통채로지운다는 의미
        
        형식 ]
            DELETE 
            FROM
                테이블이름
            [WHERE
                조건식
            ]
            
        ***
        참고 ]
            조건식을 제시하지 않으면 모든 데이터가 삭제된다.
        
        참고 ]
            이 명령은 되도록이면 사용하지 않을 것을 권하는 명령이다.
            
            현업에서는 
            isShow CHAR(1)라는 필드를 준비해두고
            기본값은 'Y'
            그리고 삭제가 필요한 경우는 'N'으로 데이터를 수정한다.
            그리고 조회질의 명령에서는
            반드시
            WHERE
                isshow = 'Y'
            를 추가해서 조회한다.
--------------------------------------------------------------------------------

     참고 ]
        테이블 설계
            오라클은 정규화된 데이터를 기억하도록 하는 데이터베이스의 일종이다.
            ( ==> 정형 데이터베이스 )
            정규화 데이터란?
            규칙이 정해진 데이터를 말한다.
            즉, 오라클은 어떤 데이터를 기억할지를 미리 정해놓고
            그 데이터에 한해서만 기억하도록 하는 데이터베이스이다.
            
            따라서 테이블을 만들때는 
            여러가지 규칙을 정해놓고(정규화 규칙)
            테이블에 들어갈 데이터를 결정해야 한다.
            
            데이터베이스 설계 과정
                
                1. 개념적 설계
                    추상적인 개념 설계
                    
                    개념적 설계의 결과로 개념적 데이터 모델이 만들어진다.
                    
                2. 논리적 설계
                    ==> 개념적 설계의 결과를
                        물리적 저장장치에 저장할 수 있도록
                        특정 데이터베이스가 지원하는 논리적인 자료구조로 변환시키는 과정
                        
                        데이터 타입과
                        데이터들간의 관계 표현
                    
                        ER-D, 테이블 명세서
                    
                3. 물리적 설계
                    ==> 논리적 설계의 결과를
                        물리적으로 구현하는 단계
                        질의명령을 작성하는 것을 의미
                        DDL 명령을 작성
                        
                        결과물은 SQL 문
                        
        정규화 과정
            
            1. 제1정규화
                ==> 개체가 갖는 속성은 원자값을 가져야한다.
                
                ==> 결과물로 제1정규형이 만들어진다.
                
            2. 제2정규화
                ==> 기본키에 대해서 모든 키는 완전함수 종속이어야 한다.
                
                ==> 결과물로 제2정규형
                
            3. 제3정규화
                ==> 이행적 함수종속에서 벗어나야한다.
            
            4. BCNF 정규화
            
            5. 제4정규화
            ...

--------------------------------------------------------------------------------
    제약조건
    ==> 데이터가 입력될때 이상이 있는 데이터를 막는 기능의
        오라클 개체
        
    목적 ]
        데이터베이스의 이상현상을 제거할 목적으로 사용
        
    종류 ]
        기본키(PRIMART KEY) 제약조건
            - 속성값으로 데이터를 구분 할 수 있어야 한다.
              기본키 제약조건은 필수는 아니지만
              되도록이면 기본키 제약조건은 추가하는 것이 좋다.
              
              기본키는 유일키 + NOT NULL 제약조건
              
        유일키(UNIQUE) 제약조건
            ==> 속성값이 다른 데이터와 구분이 되어야 한다.
                NULL 데이터는 입력할 수 있다.
                
        참조키(외래키, FOREIGN KEY) 제약조건
            ==> 참조하는 테이블의 키값을 반드시 사용해야하 하는 제약조건
                입력되지 않은 키값은 입력하지 못하도록 막는 제약조건
                만약 테이블을 삭제하려고 하면
                먼저 참조하고 있는 테이블을 삭제하고 해당 테이블을 삭제해야 한다.
                
        NOT NULL 제약조건
            ==> 속성값으로 NULL 데이터가 입력 안되도록 막는 제약조건
            
        CHECK 제약조건
            ==> 입력되어야 할 속성값이 정해져 있는 경우(예 ] 성별, 노출여부)
                입력될 속성값 이외의 값이 입력되는 것을 방지하는 제약조건

--------------------------------------------------------------------------------

 1. 테이블 만들기
 
    형식 ]
        CREATE TABLE 테이블이름 (
            필드이름        데이터타입(길이),
            필드이름        테이터타입(길이),
            ....
            );
        
    테이블이 만들어져있는지 확인하는 방법
    
        SELECT tname FROM tab;
        
    테이블 구조를 간단하게 확인하는 방법
    
        DESCRIBE 테이블이름;
        DESC    테이블이름;


-- jennie 계정 생성 (system 계정에서 실행)

CREATE USER jennie IDENTIFIED BY 12345 ACCOUNT UNLOCK;
GRANT resource, connect To jennie;
ALTER USER jennie DEFAULT TABLESPACE USERs;

-- jennie 계정에서 실행
-- Member 테이블 생성
CREATE TABLE memb(
    mno NUMBER(4), name VARCHAR2(20 CHAR),
    id VARCHAR2(15 CHAR),
    pw VARCHAR2(15 CHAR),
    mail VARCHAR2(50 CHAR),
    tel VARCHAR2(13 CHAR),
    addr VARCHAR2(100 CHAR),
    gen CHAR(1),
    joindate DATE DEFAULT sysdate,
    isShow CHAR(1) DEFAULT 'Y'
);
--------------------------------------------------------------------------------
    제약조건 부여하는 방법
        참고 ]
            제약조건의 이름을 부여하는 규칙
                
                테이블이름_필드이름_제약조건
                의 형태로 부여하면 된다.
                예 ]
                    memb 테이블의 기본키제약조건
                    ==> MEMB_NO_PK
                
    
        1. 테이블 생성할 때 추가하는 방법
            *****
            1-1. 필드를 정의할 때 추가하는 방법
                형식 ]
                    필드이름    데이터타입(길이)
                        CONSTRANINT  제약조건이름     제약조건1
                        CONSTRANINT  제약조건이름     제약조건2
                        
                참고 ]
                    참조키 제약조건
                        CONSTRAINT 제약조건이름   REFFERENCES  테이블이름(참조할필드)
                    체크 제약조건
                        CONSTRAINT  제약조건이름  CHECK (필드이름 IN (데이터1, 데이터2, ...))
            1-2. 필드를 미리 정의하고 나중에 제약조건을 추가하는 방법
            
            1-3. 무명 제약조건으로 등록하는 방법
            
-- 필드를 선언하면서 제약조건을 추가하는 방법
CREATE TABLE memb(
    mno NUMBER(4) 
        CONSTRAINT MEMB_NO_PK PRIMARY KEY, 
    name VARCHAR2(20 CHAR)
        CONSTRAINT MEMB_NAME_NN NOT NULL,
    id VARCHAR2(15 CHAR)
        CONSTRAINT MEMB_ID_UK UNIQUE
        CONSTRAINT MEMB_ID_NN NOT NULL,
    pw VARCHAR2(15 CHAR)
        CONSTRAINT MEMB_PW_NN NOT NULL,
    mail VARCHAR2(50 CHAR)
        CONSTRAINT MEMB_MAIL_UK UNIQUE
        CONSTRAINT MEMB_MAIL_NN NOT NULL,
    tel VARCHAR2(13 CHAR)
        CONSTRAINT MEMB_TEL_UK UNIQUE
        CONSTRAINT MEMB_TEL_NN NOT NULL,
    addr VARCHAR2(100 CHAR)
        CONSTRAINT MEMB_ADDR_NN NOT NULL,
    gen CHAR(1)
        CONSTRAINT MEMB_GEN_CK CHECK(gen IN('F', 'M'))
        CONSTRAINT MEMB_GEN_NN NOT NULL,
    joindate DATE DEFAULT sysdate
        CONSTRAINT MEMB_JOIN_NN NOT NULL,
    isShow CHAR(1) DEFAULT 'Y'
        CONSTRAINT MEMB_SHOW_NN NOT NULL
        CONSTRAINT MEMB_SHOW_CK CHECK(isshow IN('Y', 'N'))
);
--------------------------------------------------------------------------------
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
            
-- 아바타 테이블
CREATE TABLE avatar(
    ano NUMBER(2),
    aname VARCHAR2(15 CHAR),
    oriname VARCHAR2(50 CHAR),
    savename VARCHAR2(50 CHAR),
    dir VARCHAR2(100 CHAR),
    len NUMBER,
    gen CHAR(1)
        CONSTRAINT AVT_GEN_CK CHECK (gen IN('F', 'M', 'N'))
        CONSTRAINT AVT_GEN_NN NOT NULL,
    adate DATE DEFAULT sysdate,
    isshow CHAR(1) DEFAULT 'Y',
    CONSTRAINT AVT_NO_PK PRIMARY KEY(ano),
    CONSTRAINT AVT_SNAME_UK UNIQUE(savename),
    CONSTRAINT AVT_SHOW_CK CHECK(isshow IN('Y', 'N'))

);
drop table avatar cascade CONSTRAINTS;


-- NOT NULL 제약조건 수정
ALTER TABLE avatar
MODIFY aname
    CONSTRAINT AVT_NAME_NN NOT NULL
;










--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
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



-- 테이블 이름 변경 명령
ALTER TABLE member
RENAME TO MEMB;



테이블복사
CREATE TABLE emp1
AS
    SELECT
        *
    FROM
        emp
    WHERE
        1 = 2
;

--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------

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

