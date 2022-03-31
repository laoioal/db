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


-------------------------------------------------------------------------------













-- 사원들의 사원이름, 부서번호, 부서이름, 부서위치
SELECT
    e.ename 사원이름, e.deptno 부서번호, 
    (SELECT
            dname
        FROM
            dept
        WHERE
            e.deptno = deptno
        ) 부서이름,
            (SELECT
                loc
            FROM
                dept
            WHERE
            e.deptno = deptno            
            ) 부서위치
FROM
    emp e
;



-- 조건절에 단일행 단일필드의 결과
-- SMITH 사원과 동일한 부서의 사원들의 정보를 조회하세요
SELECT
    *
FROM
    emp e
WHERE
    e.deptno = (SELECT
                    deptno
                FROM
                    emp
                WHERE
                    ename = 'SMITH'
                )

;   

-- 10번부서 사원들의 직급 평균을 조회하세요
SELECT
    job 직급, AVG(sal) 직급급여평균
FROM
    emp
WHERE
    job in (SELECT
        job
    FROM
        emp
    WHERE
        deptno = 10
    )
GROUP BY
    job
;



----------------------------------------------------------------------------

-- IN
-- 직급이 MANAGER인 사원과 같은 부서에 속한 사원들의
-- 사원이름, 직급, 부서번호를 조회하세요
SELECT
    ename 사원이름, job 직급, deptno 부서번호
FROM
    emp
WHERE
   deptno in (SELECT
        deptno
    FROM
        emp
    WHERE
        job = 'MANAGER'
        )
;
-- ANY
-- 각 부서의 평균 급여보다 한 부서라도 급여가 높은 사원들의
-- 사원이름, 사원급여, 부서번호 를 조회하세요
SELECT
    ename 사원이름, sal 사원급여, deptno 부서번호
FROM

WHERE



;

-- 모든 각 부서의 급여 평균보다 높은 급여를 받는 사원들의
-- 사원이름, 사원급여, 부서번호 를 조회하세요
SELECT
    ename 사원이름, sal 사원급여, deptno 부서번호


;

-- 사원중 40번 부서 사원이 존재하면 모든 사원들의
-- 사원이름, 부서번호를 조회하세요
SELECT
    ename 사원이름, deptno 부서번호

;
-----------------------------------------------------------------------------
-- 사원들의 사원이름, 부서번호, 부서원수, 부서평균급여, 부서급여합계를 조회하세요
SELECT
    ename 사원이름, deptno 부서번호, cnt 부서원수, avg 부서평균급여, sum 부서급여합계
FROM

;

-------------------------------------------------------------
-- 회사 평균급여보다 적게 받는 사원들의
-- 사원이름, 직급, 입사일, 급여를 조회하세요
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여
FROM

;











-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
/*
    문제 1 ]
        이름이 SMITH인 사원과 동일한 직급을 가진 사원의 정보를 출력하라
*/

SELECT
    *
FROM
    emp
WHERE
   job = (SELECT
                job
            FROM
                emp
            WHERE
            ename = 'SMITH'
            )
;


/*
    문제 2 ]
        회사 평균보다 급여를 적게받는 사원들의
            사원이름, 직급, 급여[, 회사평균급여]를 조회하세요
*/
SELECT
    ename 사원이름, job 직급, sal 급여, avg
FROM
    emp, (SELECT
                AVG(sal) avg
            FROM
                emp
            )
    
WHERE
   sal < avg
;
/*
    문제 3 ]
        사원들중 급여가 가장 높은 사원의
            사원이름, 직급, 급여[, 최고급여]를 조회하세요
*/
SELECT
    ename 사원이름, job 직급, sal 급여, max 최고급여
FROM
    emp, (SELECT
                MAX(sal) max
            FROM
                emp
            )
WHERE
    sal = max
;

/*
    문제 4 ]
        KING 사원보다 이후에 입사한 사원들의
        사원이름, 직급, 입사일[, KING사원 입사일]을 조회하세요
*/
SELECT
    ename 사원이름, job 직급, hiredate 입사일, hire "KING사원 입사일"
FROM
    emp, (SELECT
            hiredate hire
        FROM
            emp
        WHERE
        ename = 'KING'
        )
WHERE
    hiredate > hire
;

/*
    문제 5 ]
        각 사원의 급여와 회사평균급여의 차를 출력하세요
        조회형식은
            사원이름, 급여, 급여의 차, 회사평균급여
        로 조회하세요
*/
SELECT
    ename 사원이름, sal 급여, sal - avg 급여의차, avg 회사평균급여
FROM
    emp, (SELECT
            AVG(sal) avg
        FROM
            emp
        )
;

/*
    문제 6 ]
        부서별 급여의 합이 가장 높은 부서 사원들의
            사원이름, 직급, 부서번호, 부서이름, 부서급여합계, 부서원수를 조회하세요        
*/


SELECT
    ename, job, dno, dname, sum, cnt
FROM
    emp e, dept d,
    (SELECT
        deptno dno, COUNT(*) cnt, SUM(sal) sum
    FROM
        emp
    GROUP BY
        deptno
        
    )
WHERE
    e.deptno = dno
    AND e.deptno = d.deptno
    AND e.deptno = (SELECT
                        deptno
                    FROM
                        emp
                    GROUP BY
                        deptno
                    HAVING (
                        SUM(sal) = (SELECT
                                        MAX(SUM(sal))
                                    FROM
                                        emp
                                    GROUP BY
                                        deptno)
                            )
                        )
                        
;



SELECT
    ename 사원이름, job 직급, dno 부서번호, dname 부서이름, sum 부서급여합계, cnt 부서원수
FROM
    emp e, dept d,
        (
        SELECT
            deptno dno, SUM(sal) sum, COUNT(*) cnt
        FROM
            emp
        GROUP BY
            deptno
     )
    
WHERE
    e.deptno = dno
    AND e.deptno = d.deptno
    AND e.deptno = (SELECT
                        deptno
                    FROM
                        emp
                    GROUP BY
                        deptno
                    HAVING
                        SUM(sal) = (
                                     SELECT
                                        MAX(SUM(sal))
                                    FROM
                                        emp
                                    GROUP BY
                                        deptno
                                                 )
            )

;

/*
    문제 7 ]
        커미션을 받는 사원이 한명이라도 있는 부서의 사원들의
            사원이름, 직급, 부서번호, 커미션을 조회하세요
*/
SELECT
    ename 사원이름, job 직급, deptno 부서번호, comm 커미션
FROM
    emp d
WHERE
         d.deptno IN (SELECT
                e.deptno
            FROM
                emp e
            WHERE
                comm >= 0
            )
;
/*
    문제 8 ]
        회사평균 급여보다 높고
        이름이 4, 5글자인 사원들의
        사원이름, 급여, 이름글자길이[, 회사평균급여]를 조회하세요
*/


SELECT
    ename 사원이름, sal 급여, LENGTH(ename) 이름글자길이, avg 회사평균급여
FROM
    emp, (SELECT
                AVG(sal) avg
            FROM
                emp
                )
WHERE
    LENGTH(ename) = 4
    AND sal > avg
    OR LENGTH(ename) = 5
    AND sal > avg
  
;
/*
    문제 9 ]
        사원이름의 글자수가 4글자인 사원과 같은 직급을 가진 사원들의
            사원이름, 직급, 급여를 조회하세요
*/
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    job IN  (SELECT
                job
            FROM
                emp
            WHERE
                LENGTH(ename) = 4
            )
;
/*
    문제 10 ]
        입사년도가 81년이 아닌 사원과 같은 부서에 있는 사원들의
            사원이름, 직급, 급여, 입사일, 부서번호를 조회하세요
*/
SELECT
    ename 사원이름, job 직급, sal 급여, hiredate 입사일, deptno 부서번호
FROM
    emp
WHERE
    deptno IN (SELECT
                    deptno
                FROM
                    emp
                WHERE
                    TO_CHAR(hiredate, 'YY') != 81
                )
;
/*
    문제 11 ]
        직급별 평균급여보다 한 직급이라도 급여가 많이 받는사원의
            사원이름, 직급, 급여, 입사일을 조회하세요
*/


SELECT
    ename 사원이름, job 직급, sal 급여, hiredate 입사일
FROM
    emp
WHERE
     sal > ANY (SELECT
                 AVG(sal)
            FROM
                emp 
            GROUP BY
                job
            
        )
;
/*
    문제 12 ]
        모든 년도별 입사자의 평균 급여보다 많이 받는 사원들의
            사원이름, 직급, 급여, 입사년도를 조회하세요
*/
SELECT
    ename 사원이름, job 직급, sal 급여, hiredate 입사일
FROM
    emp
WHERE
    sal > all(SELECT
                   AVG(sal)
                FROM
                    emp
                GROUP BY
                TO_CHAR(hiredate, 'YY')
                )
    
;   
/*
    문제 13 ]
        최고 급여자의 이름 글자수와 같은 글자수의 직원이 존재하면
            모든 사원의 사원이름, 이름글자수, 직급, 급여를 조회하고
            존재하지 않으면 출력하지 마세요
*/

SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
  EXISTS ( 
            SELECT
                LENGTH(ename)
            FROM
                emp
            WHERE
                sal = (SELECT
                           MAX(sal)
                         FROM
                           emp
                             )
        )   
        
;