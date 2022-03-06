-- 1、查询“01”课程比“02”课程成绩高的所有学生的学号
-- 子查询
SELECT
	a.s_id "id",
	c.s_name "name",
	a.s_score "01",
	b.s_score "02" 
FROM
	( SELECT s_id, c_id, s_score FROM Score WHERE c_id = '01' ) AS a
	INNER JOIN ( SELECT s_id, c_id, s_score FROM Score WHERE c_id = '02' ) AS b ON a.s_id = b.s_id
	INNER JOIN Student AS c ON c.s_id = a.s_id 
WHERE
	a.s_score > b.s_score


-- 2、查询平均成绩大于60分的同学的学号,姓名和平均成绩
-- 聚合，Having子句
SELECT
	s_id,
	AVG( s_score ) 
FROM
	Score 
GROUP BY
	s_id 
HAVING
	AVG( s_score ) > 60


-- 3、查询所有同学的学号、姓名、选课数、总成绩
-- 聚合函数sum，聚合
SELECT
	a.s_id,
	a.s_name,
	count( b.c_id ) as c_num,
 	sum( CASE WHEN b.s_score IS NULL THEN 0 ELSE b.s_score END ) as score
FROM
	Student AS a
	LEFT JOIN Score AS b ON a.s_id = b.s_id 
GROUP BY
	s_id,
	a.s_name


-- 4、查询没学过「王五」老师授课的同学的姓名、学号
-- 子查询作为in参数
SELECT
	s_id,
	s_name 
FROM
	Student 
WHERE
	s_id NOT IN (
	SELECT
		s_id 
	FROM
		Score AS s
		INNER JOIN Course AS c ON s.c_id = c.c_id
		INNER JOIN Teacher AS t ON c.t_id = t.t_id 
	WHERE
	t_name = "王五" 
	)


-- 5、查询学过编号为"1"并且也学过编号为"2"的课程的同学的信息
SELECT
	s_id,
	s_name 
FROM
	Student 
WHERE
	s_id IN (
	SELECT
		a.s_id 
	FROM
		( SELECT s_id, c_id FROM Score WHERE c_id = "01" ) AS a
	INNER JOIN ( SELECT s_id, c_id FROM Score WHERE c_id = "02" ) AS b ON a.s_id = b.s_id 
	)

