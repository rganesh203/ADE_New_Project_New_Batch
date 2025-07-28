CREATE TABLE [dbo].[stgStudent] (

	[studentId] int NOT NULL, 
	[studentName] varchar(100) NULL, 
	[stream] varchar(50) NULL, 
	[marks] int NULL, 
	[createDate] datetime2(3) NULL, 
	[updateDate] datetime2(3) NULL
);