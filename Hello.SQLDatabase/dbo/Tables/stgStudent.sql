CREATE TABLE [dbo].[stgStudent] (
    [studentId]   INT           NOT NULL,
    [studentName] VARCHAR (100) NULL,
    [stream]      VARCHAR (50)  NULL,
    [marks]       INT           NULL,
    [createDate]  DATETIME2 (3) NULL,
    [updateDate]  DATETIME2 (3) NULL
);


GO

