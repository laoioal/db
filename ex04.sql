/*
    문제 1 ]
        직급이 MANAGER 인 사원의
            사원이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름
FROM
	emp e, dept d
WHERE
    job = 'MANAGER'
    AND e.deptno = d.deptno
;
/*
    문제 2 ]
        사원이름이 5글자인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급
FROM
	emp, salgrade
WHERE
    LENGTH(ename) = 5 AND
    sal BETWEEN losal AND hisal
;
/*
    문제 3 ]
        입사일이 81년이고
        직급이 MANAGER인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급, dname 부서이름, loc 부서위치
FROM
	emp e, dept d, salgrade
WHERE
    TO_CHAR(hiredate, 'YY') = 81
    AND job = 'MANAGER'
    AND e.deptno = d.deptno -- 조인조건
    AND sal BETWEEN losal AND hisal -- 조인조건
;
/*
    문제 4 ]
        사원들의
            사원이름, 직급, 급여, 급여등급, 상사이름을 조회하세요.
    
        보너스 ]
            상사가 없는 사원은 상사이름을 '상사없음'으로 조회하세요
*/

SELECT
    e.ename 사원이름, e.job 직급, e.sal 급여, grade 급여등급, NVL(f.ename, '상사없음') 상사이름
FROM
	emp e, emp f, salgrade
WHERE
    e.mgr = f.empno(+)
    AND e.sal BETWEEN losal AND hisal
;
/*
    문제 5 ]
        사원들의
            사원이름, 직급, 급여, 상사이름, 부서이름, 급여등급을 조회하세요.
*/
SELECT
     e.ename 사원이름, e.job 직급, e.sal 급여, NVL(f.ename, '상사없음') 상사이름, dname 부서이름, grade 급여등급
FROM
	emp e, emp f, salgrade, dept d
WHERE
    e.mgr = f.empno(+)
    AND e.sal BETWEEN losal AND hisal
    AND e.deptno = d.deptno
;

-- 위 문제들을 ANSI JOIN을 사용한 질의명령을 작성하세요
/*
    문제 1 ]
        직급이 MANAGER 인 사원의
            사원이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름
FROM
    emp e
JOIN
    dept d
ON
    e.deptno = d.deptno
WHERE
    e.job = 'MANAGER'
;
/*
    문제 2 ]
        사원이름이 5글자인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, grade 급여등급
FROM
    emp
JOIN
    salgrade
ON
  sal BETWEEN losal AND hisal
  
WHERE
    LENGTH(ename) = 5
;
/*
    문제 3 ]
        입사일이 81년이고
        직급이 MANAGER인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/
SELECT
    ename, job, hiredate, sal, grade, dname, loc
FROM
    emp
JOIN
    salgrade
ON
    sal BETWEEN losal AND hisal
JOIN
    dept
ON
    emp.deptno = dept.deptno
WHERE
    job = 'MANAGER'
    AND TO_CHAR(hiredate, 'YY') = 81
;
/*
    문제 4 ]
        사원들의
            사원이름, 직급, 급여, 급여등급, 상사이름을 조회하세요.
    
        보너스 ]
            상사가 없는 사원은 상사이름을 '상사없음'으로 조회하세요
*/
SELECT
    e.ename 사원이름, e.job 직급, e.sal 급여, grade 급여등급, NVL(s.ename, '상사없음') 상사이름
FROM
    emp e
JOIN
    salgrade
ON
    e.sal BETWEEN losal AND hisal
LEFT OUTER JOIN   
    emp s
ON
    e.mgr = s.empno
;
/*
    문제 5 ]
        사원들의
            사원이름, 직급, 급여, 상사이름, 부서이름, 급여등급을 조회하세요.
*/
SELECT
    e.ename 사원이름, e.job 직급, e.sal 급여, s.ename 상사이름, dname 부서이름, grade 급여등급
FROM
    emp e
JOIN
    salgrade
ON
    e.sal BETWEEN losal AND hisal
JOIN
    emp s
ON
    e.mgr = s.empno
JOIN
    dept d
ON
    e.deptno = d.deptno
;
----------------------------------------------------------------------------
-- 다시풀어보기



/*
    문제 1 ]
        직급이 MANAGER 인 사원의
            사원이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여, dname 부서이름
FROM
    emp, dept
WHERE
    emp.deptno = dept.deptno
    AND job = 'MANAGER'
;


/*
    문제 2 ]
        사원이름이 5글자인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/
SELECT
    ename, job, hiredate, sal, grade
FROM
    emp, salgrade
WHERE
    sal BETWEEN losal AND hisal
    AND LENGTH(ename) = 5
;


/*
    문제 3 ]
        입사일이 81년이고
        직급이 MANAGER인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/
SELECT
    ename, job, hiredate, sal, grade, dname, loc
FROM
    emp, dept, salgrade
WHERE
    emp.deptno = dept.deptno
    AND sal BETWEEN losal AND hisal
    AND TO_CHAR(hiredate, 'YY') = 81
    AND job = 'MANAGER'
;


/*
    문제 4 ]
        사원들의
            사원이름, 직급, 급여, 급여등급, 상사이름을 조회하세요.
    
        보너스 ]
            상사가 없는 사원은 상사이름을 '상사없음'으로 조회하세요
*/
SELECT
    e.ename, e.job, e.sal, grade, NVL(s.ename, '상사없음')
FROM
    emp e, emp s, salgrade
WHERE
    e.sal BETWEEN losal AND hisal
    AND e.mgr = s.empno(+)
;


/*
    문제 5 ]
        사원들의
            사원이름, 직급, 급여, 상사이름, 부서이름, 급여등급을 조회하세요.
*/
SELECT
    e.ename, e.job, e.sal, s.ename, dname, grade
FROM
    emp e, emp s, salgrade, dept
WHERE
    e.mgr = s.empno
    AND e.deptno = dept.deptno
    AND e.sal BETWEEN losal AND hisal
;

















-- 위 문제들을 ANSI JOIN을 사용한 질의명령을 작성하세요
/*
    문제 1 ]
        직급이 MANAGER 인 사원의
            사원이름, 직급, 입사일, 급여, 부서이름을 조회하세요.
*/
SELECT
    ename, job, hiredate, sal, dname
FROM
    emp
JOIN
    dept
ON
    emp.deptno = dept.deptno
WHERE
    job = 'MANAGER'
;
/*
    문제 2 ]
        사원이름이 5글자인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급을 조회하세요.
*/
SELECT
    ename, job, hiredate, sal, grade
FROM
    emp
INNER JOIN
    salgrade
ON
    sal BETWEEN losal AND hisal
WHERE
    LENGTH(ename) = 5
;
/*
    문제 3 ]
        입사일이 81년이고
        직급이 MANAGER인 사원들의
            사원이름, 직급, 입사일, 급여, 급여등급, 부서이름, 부서위치를 조회하세요.
*/
SELECT
    ename, job, hiredate, sal, grade, dname, loc
FROM
    emp
INNER JOIN
    salgrade
ON
    sal BETWEEN losal AND hisal
JOIN
    dept
ON
    emp.deptno = dept.deptno
WHERE
TO_CHAR(hiredate, 'YY') = 81
AND job = 'MANAGER'
;
/*
    문제 4 ]
        사원들의
            사원이름, 직급, 급여, 급여등급, 상사이름을 조회하세요.
    
        보너스 ]
            상사가 없는 사원은 상사이름을 '상사없음'으로 조회하세요
*/
SELECT
    e.ename, e.job, e.sal, grade, s.ename
FROM
    emp e
JOIN
    salgrade
ON
    e.sal BETWEEN losal AND hisal
LEFT OUTER JOIN
    emp s
ON
    e.mgr = s.empno
;
/*
    문제 5 ]
        사원들의
            사원이름, 직급, 급여, 상사이름, 부서이름, 급여등급을 조회하세요.
*/
SELECT
    e.ename, e.job, e.sal, s.ename, dname, grade
FROM
    emp e
INNER JOIN
    salgrade
ON
    e.sal BETWEEN losal AND hisal
JOIN
    emp s
ON  
    e.mgr = s.empno
JOIN
    dept d
ON
    e.deptno = d.deptno
;
