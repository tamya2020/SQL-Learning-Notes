-- 创建数据库
-- create database school;
-- use school;
-- 建表
-- 学生表：学生编号,学生姓名, 出生年月,学生性别
CREATE TABLE `Student`(
	`s_id` VARCHAR(20),
	`s_name` VARCHAR(20) NOT NULL DEFAULT '',
	`s_birth` VARCHAR(20) NOT NULL DEFAULT '',
	`s_sex` VARCHAR(10) NOT NULL DEFAULT '',
	PRIMARY KEY(`s_id`)
);

-- 教师表：教师编号,教师姓名
CREATE TABLE `Teacher`(
	`t_id` VARCHAR(20),
	`t_name` VARCHAR(20) NOT NULL DEFAULT '',
	PRIMARY KEY(`t_id`)
);

-- 课程表：课程编号, 课程名称, 教师编号
CREATE TABLE `Course`(
	`c_id`  VARCHAR(20),
	`c_name` VARCHAR(20) NOT NULL DEFAULT '',
	`t_id` VARCHAR(20) NOT NULL,
	PRIMARY KEY(`c_id`),
	FOREIGN KEY(`t_id`) REFERENCES Teacher(`t_id`)
);

-- 成绩表：学生编号,课程编号,分数
CREATE TABLE `Score`(
	`s_id` VARCHAR(20),
	`c_id`  VARCHAR(20),
	`s_score` INT(3),
	PRIMARY KEY(`s_id`,`c_id`),
	FOREIGN KEY(`s_id`) REFERENCES Student(`s_id`),
    FOREIGN KEY(`c_id`) REFERENCES Course(`c_id`)
);

-- 插入学生表测试数据
insert into Student values('01' , '赵雷' , '1990-01-01' , '男');
insert into Student values('02' , '钱电' , '1990-12-21' , '男');
insert into Student values('03' , '孙风' , '1990-05-20' , '男');
insert into Student values('04' , '李云' , '1990-08-06' , '男');
insert into Student values('05' , '周梅' , '1991-12-01' , '女');
insert into Student values('06' , '吴兰' , '1992-03-01' , '女');
insert into Student values('07' , '郑竹' , '1989-07-01' , '女');
insert into Student values('08' , '王菊' , '1990-01-20' , '女');
-- 教师表测试数据
insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');
-- 教师姓名是空字符串
insert into Teacher values('04' , '');
-- 课程表测试数据
insert into Course values('01' , '语文' , '02');
insert into Course values('02' , '数学' , '01');
insert into Course values('03' , '英语' , '03');
-- 一个老师多门课
insert into Course values('04' , '生物' , '03');
insert into Course values('05' , '化学' , '04');
-- 成绩表测试数据
insert into Score values('01' , '01' , 80);
insert into Score values('01' , '02' , 90);
insert into Score values('01' , '03' , 99);
insert into Score values('01' , '04' , 88);

insert into Score values('02' , '01' , 70);
insert into Score values('02' , '02' , 60);
insert into Score values('02' , '03' , 80);

insert into Score values('03' , '01' , 80);
insert into Score values('03' , '02' , 80);
insert into Score values('03' , '03' , 80);

insert into Score values('04' , '01' , 50);
insert into Score values('04' , '02' , 30);
insert into Score values('04' , '03' , 20);
insert into Score values('04' , '04' , 77);

insert into Score values('05' , '01' , 76);
insert into Score values('05' , '02' , 87);

insert into Score values('06' , '01' , 31);
insert into Score values('06' , '03' , 34);
insert into Score values('06' , '04' , 33);

insert into Score values('07' , '02' , 89);
insert into Score values('07' , '03' , 98);
insert into Score values('07' , '05' , 100);
