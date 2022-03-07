--6、查询所有课程成绩大于60分的学生的学号、姓名
SELECT
	t.s_id,
	t.s_name 
FROM
	( SELECT s_id, count( c_id ) AS cnt FROM Score WHERE s_score > 60 GROUP BY s_id ) AS a
	INNER JOIN ( SELECT s_id, count( c_id ) AS cnt FROM Score GROUP BY s_id ) AS b ON a.s_id = b.s_id
	INNER JOIN Student AS t ON a.s_id = t.s_id 
WHERE
	a.cnt = b.cnt


--7、查询没有学全所有课的学生的学号、姓名
SELECT
	st.* 
FROM
	Student AS st
	LEFT JOIN Score AS sc ON st.s_id = sc.s_id 
GROUP BY
	st.s_id 
HAVING
	COUNT( DISTINCT sc.c_id ) < ( SELECT COUNT( c_id ) FROM Course )


--8、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
SELECT
	s.s_id,
	s.s_name,
	t.avg_score 
FROM
	Student AS s
	INNER JOIN (
	SELECT
		sc.s_id,
		count( sc.c_id ),
		avg( sc.s_score ) AS avg_score 
	FROM
		Score AS sc 
	WHERE
	s_score < 60 GROUP BY sc.s_id HAVING count( sc.c_id ) >= 2 
	) AS t ON s.s_id = t.s_id;


--9、查询至少有一门课与学号为“01”的学生所学课程相同的学生的学号和姓名
SELECT
	st.s_id,
	st.s_name 
FROM
	( SELECT DISTINCT s_id FROM Score WHERE c_id IN ( SELECT c_id FROM Score WHERE s_id = '01' ) AND s_id != '01' ) AS sc
	INNER JOIN Student AS st ON sc.s_id = st.s_id

--10、按平均成绩从高到低显示所有学生的平均成绩、各科成绩
SELECT
	s_id '学号',
	max( CASE WHEN c_id = '01' THEN s_score ELSE NULL END ) '课程1成绩',
	max( CASE WHEN c_id = '02' THEN s_score ELSE NULL END ) '课程2成绩',
	max( CASE WHEN c_id = '03' THEN s_score ELSE NULL END ) '课程3成绩',
	max( CASE WHEN c_id = '04' THEN s_score ELSE NULL END ) '课程4成绩',
	max( CASE WHEN c_id = '05' THEN s_score ELSE NULL END ) '课程5成绩',
	avg( s_score ) '平均成绩' 
FROM
	Score 
GROUP BY
	s_id 
ORDER BY
	avg( s_score ) DESC

