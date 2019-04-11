CREATE DATABASE students
go

USE students
go

CREATE TABLE Students (
	StudentID int primary key identity,
	StudentName nvarchar(100) not null,
	Age int not null,
	Email nvarchar(100) null,
)

CREATE TABLE Classes (
	ClassID int primary key identity,
	ClassName char(10) not null,
)

CREATE TABLE ClassStudent (
	ClassID int foreign key references Classes(ClassID),
	StudentID int foreign key references Students(StudentID)
)

CREATE TABLE Subjects (
	SubjectID int primary key identity,
	SubjectName nvarchar(100) not null,
)

CREATE TABLE Marks (
	SubjectID int foreign key references Subjects(SubjectID),
	StudentID int foreign key references  Students(StudentID),
	Mark int not null
)