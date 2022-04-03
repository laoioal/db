-- DML (INSERT, UPDATE, DELETE)

CREATE TABLE emp1
AS
    SELECT
        *
    FROM
        emp
    WHERE
        1 = 2
    ;
    



/*
    문제 1 ]
        emp1 테이블에 다음 데이터를 입력하세요.
            이름 : 둘리
            직급 : 머슴
            급여 : 10
            입사일 : 현재시간
*/
INSERT INTO
    emp1(empno, ename, job, sal, hiredate)
VALUES(
    1100, '둘리', '머슴', 10, sysdate
    )
;
/*
    문제 2 ]
        emp1 테이블에 다음 데이터를 입력하세요
        이름 : 고길동
        직급 : 애완동물
        입사일 : 2022년 03월 21일
*/
ALTER TABLE emp1
MODIFY job VARCHAR2(10 CHAR);


INSERT INTO
    emp1(empno, ename, job, hiredate)
VALUES(
    1101, '고길동', '심퉁', '2022/03/21' -- TO_DATE(2022년 03월 21일, 'YYYY/MM/DD')
);

UPDATE
    emp1    
SET
    job = '애완동물'
WHERE
    ename = '고길동'
;

/*
    문제 3 ]
        emp1 테이블에 다음 데이터를 입력하세요
            이름 : 희동이
            직급 : 대장
            급여 : NULL
            입사일 : 2022년 01월 1일
*/
INSERT INTO
    emp1(empno, ename, hiredate)
VALUES( 
    1102, '희동이', '2022/01/01'
);
-- 데이터 수정

/*
    문제 4 ]
        emp1 테이블에서 다음 데이터를 수정하세요
        제니, 로제, 리사, 지수
        사원의 이름을 이름앞에 'Miss.' 붙여서
        이름이 만들어지게 수정하세요
        나머지 사원들은 이름앞에 'Mr.' 를 붙여서 수정하세요
*/
ALTER TABLE emp1
MODIFY ename VARCHAR2(14 CHAR);
commit;

UPDATE
    emp1
SET
    ename = DECODE(ename, '제니' , 'Miss.' || ename,
                           '로제', 'Miss.' || ename,
                            '리사' , 'Miss.' || ename,
                            '지수' , 'Miss.' || ename,
                    'Mr.' || ename)

;


UPDATE
    emp1
SET
    ename = CASE
                WHEN ename = 'Miss.제니' THEN 'Mrs. ' || ename
                WHEN ename = '로제' THEN 'Mrs. ' || ename
                WHEN ename = '리사' THEN 'Mrs. ' || ename
                WHEN ename = '지수' THEN 'Mrs. ' || ename
                ELSE 'MI' || ename
                end
                
;
rollback;
commit;
/*
    문제 5 ]
        emp1 테이블에서
        입사년도가 81년 인 사원만
        급여를 25%인상하는데 10단위 이하는
        버림으로 처리하세요
*/
UPDATE
    emp1
SET
    sal = TRUNC((sal * 1.25), 2)
WHERE
    TO_CHAR(hiredate, 'YY') = 81
;

commit;

-- 다른테이블의 데이터 복사

/*
    문제 6 ]
        emp 테이블의 'SMITH' 사원의 데이터를 복사해서
        emp1 테이블에 입력하세요
*/
INSERT INTO
    emp1

    (SELECT
        *
    FROM
        emp
    WHERE
    ename = 'SMITH'
    )


;

-- 데이터 삭제

/*
    문제 7 ]
        emp1 테이블에서 부서번호가 10번인 사원만 삭제하세요
*/
DELETE
FROM
    emp1
WHERE
    deptno = 10
;    
commit;

/*
    문제 8 ]
        emp1 테이블에서 이름이 'H'로 끝나는 사원만 삭제하세요.
*/
DELETE
FROM
    emp1
WHERE
    ename LIKE '%%H'
;
commit;