--11、查询各科成绩最高分、最低分和平均分
-- 以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
SELECT
	c.c_id,
	c.c_name,
	COUNT( sc.c_id ) AS "选修人数",
	MAX( sc.s_score ) AS "最高分",
	MIN( sc.s_score ) AS "最低分",
	AVG( sc.s_score ) AS "平均分",
	SUM( CASE WHEN sc.s_score >= 60 THEN 1 ELSE 0 END ) / COUNT( 1 ) AS "及格率",
	SUM( CASE WHEN sc.s_score BETWEEN 70 AND 80 THEN 1 ELSE 0 END ) / COUNT( 1 ) AS "中等率",
	SUM( CASE WHEN sc.s_score BETWEEN 80 AND 90 THEN 1 ELSE 0 END ) / COUNT( 1 ) AS "优良率",
	SUM( CASE WHEN sc.s_score >= 90 THEN 1 ELSE 0 END ) / COUNT( 1 ) AS "优秀率" 
FROM
	Course c
	JOIN Score sc ON c.c_id = sc.c_id 
GROUP BY
	c.c_id,
	c.c_name 
ORDER BY
	COUNT( sc.c_id ) DESC,
	c.c_id;

--12、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
-- <窗口函数> over (partition by <用于分组的列名>
--                order by <用于排序的列名>)
SELECT
	* 
FROM
	(
	SELECT
		sc.s_id,
		sc.c_id,
		sc.s_score,
		st.s_name,
		st.s_birth,
		ROW_NUMBER ( ) over ( PARTITION BY c_id ORDER BY s_score DESC ) as row_num
	FROM
		Score AS sc
		INNER JOIN Student AS st ON st.s_id = sc.s_id 
	) a 
WHERE
	row_num IN ( 2, 3 )

--13、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
SELECT
	sc.c_id,
	c.c_name,
	SUM( CASE WHEN s_score BETWEEN 85 AND 100 THEN 1 ELSE 0 END ) AS '[100-85]',
	SUM( CASE WHEN s_score BETWEEN 85 AND 100 THEN 1 ELSE 0 END ) / COUNT( sc.s_id ) AS '[100-85]百分比',
	SUM( CASE WHEN s_score BETWEEN 70 AND 85 THEN 1 ELSE 0 END ) AS '[85-70]',
	SUM( CASE WHEN s_score BETWEEN 70 AND 85 THEN 1 ELSE 0 END ) / COUNT( sc.s_id ) AS '[85-70]百分比',
	SUM( CASE WHEN s_score BETWEEN 60 AND 70 THEN 1 ELSE 0 END ) AS '[70-60]',
	SUM( CASE WHEN s_score BETWEEN 60 AND 70 THEN 1 ELSE 0 END ) / COUNT( sc.s_id ) AS '[70-60]百分比',
	SUM( CASE WHEN s_score BETWEEN 0 AND 60 THEN 1 ELSE 0 END ) AS '[60-0]',
	SUM( CASE WHEN s_score BETWEEN 0 AND 60 THEN 1 ELSE 0 END ) / COUNT( sc.s_id ) AS '[60-0]百分比' 
FROM
	Course c
	JOIN Score sc ON c.c_id = sc.c_id 
GROUP BY
	sc.c_id,
	c.c_name;

--14、查询学生平均成绩及其名次
SELECT
	st.s_id,
	avg( sc.s_score ),
	ROW_NUMBER ( ) over ( ORDER BY avg( sc.s_score ) DESC ) 
FROM
	Score sc
	INNER JOIN Student st ON st.s_id = sc.s_id 
GROUP BY
	st.s_id

--15、查询所有学生的课程及分数情况
SELECT
	sc.s_id,
	st.s_name,
	MAX( CASE WHEN co.c_name = "语文" THEN s_score ELSE NULL END ) as "语文",
	MAX( CASE WHEN co.c_name = "数学" THEN s_score ELSE NULL END ) as "数学",
	MAX( CASE WHEN co.c_name = "英语" THEN s_score ELSE NULL END ) as "英语",
	MAX( CASE WHEN co.c_name = "化学" THEN s_score ELSE NULL END ) as "化学",
	MAX( CASE WHEN co.c_name = "生物" THEN s_score ELSE NULL END ) as "生物" 
FROM
	Score sc
	INNER JOIN Course co ON sc.c_id = co.c_id
	INNER JOIN Student st ON sc.s_id = st.s_id 
GROUP BY
	sc.s_id,
	st.s_name