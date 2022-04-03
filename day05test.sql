CREATE TABLE emp3
AS
    SELECT
        *
    FROM
        emp
    WHERE
        1 = 2
;

-- emp3에 제니 사원을 입력해보자.
INSERT INTO
    emp3
VALUES(
    1001, '제니', '사장', null, sysdate, 100, null, 10
);
commit;
ALTER TABLE emp3
MODIFY hiredate DEFAULT sysdate;

ALTER TABLE emp3
ADD CONSTRAINT EMP3_NO_PK PRIMARY KEY(empno)
;
DESC emp3;

-- emp3 테이블에 로제 사원을 입력해보자
INSERT INTO
    emp3 (empno, ename)
VALUES(
    1002, '로제'
);

-- emp3 테이블에 리사 사원을 추가하세요
INSERT INTO
    emp3 (empno, job, ename)
VALUES(
    1003, '댄서', '리사'
);

rollback;
commit;

-- emp 테이블에 있는 KING 사원의 정보를 emp3 테이블에 복사해보자
INSERT INTO
    emp3
(
    SELECT
        *
    FROM
        emp
    WHERE
        ename = 'KING'
);
commit;
rollback;


CREATE TABLE emp1-- CREATE는 DDL명령, DDL명령이 실행되면 기존 작업 자동 적용(commit)된다.
AS 
    SELECT
        *
    FROM
        emp
;

UPDATE
    emp1
SET
    job = '사장'
;


rollback;

UPDATE
    emp1
SET
    sal = 1500
WHERE
    ename = 'SMITH'
;

UPDATE
    emp1
SET
    (job, sal, comm) = (SELECT
                            job, sal, comm
                        FROM
                            emp
                        WHERE
                            ename = 'KING'
                            )
WHERE
    ename = 'SMITH'
;
drop table emp1;