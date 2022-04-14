-- jemp 테이블에 마지막으로 입사한 사원의 정보 조회

-- jemp 테이블에 hiredate에 default를 sysdate로 변경하세요
ALTER TABLE jemp
MODIFY hiredate DEFAULT sysdate; 

;
INSERT INTO
    jemp(empno, ename, job, deptno)
VALUES(
    1002, 'LISA', 'ANALYST', 20
)
;
SELECT
    empno, ename, job, hiredate, deptno
FROM
    jemp
WHERE
    hiredate = (
                SELECT
                    MAX(hiredate)
                FROM
                    jemp
                 )
;
commit;

-- emp 테이블에 30번 부서 사원들의 정보를 jemp 테이블에 복사하세요
INSERT INTO
    jemp

SELECT
    *
FROM
    emp
WHERE
    deptno = 30
            

;

-- JEMP테이블과 같은 구조를 가지는 JBACKUP 테이블을 FDATE 컬럼을 추가해서 생성하세요
CREATE TABLE JBACKUP
AS
    SELECT
        e.*, sysdate fdate
    FROM
        jemp e
    WHERE
        1 = 2
    
;

-- 퇴직일을 입력되는 현재시간으로 기본값을 부여하세요
ALTER TABLE JBACKUP
MODIFY FDATE DEFAULT sysdate;

-- 기본키 제약조건 추가
ALTER TABLE JBACKUP
ADD CONSTRAINT JB_NO_PK PRIMARY KEY(EMPNO);


-- 백업전용 질의명령

INSERT INTO jbackup

SELECT
    e.*, sysdate
FROM
    jemp e
WHERE
    deptno = 30
;

DELETE
FROM
    jemp
WHERE
    deptno = 30
;
