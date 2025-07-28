CREATE PROCEDURE dbo.usp_upsert_Student
AS
BEGIN
 MERGE dbo.Student AS t
 USING (SELECT
studentId,studentName,stream,marks,createDate,updateDate FROM
dbo.stgStudent)
 AS s (studentId,studentName,stream,marks,createDate,updateDate)
 ON (t.studentId = s.studentId)
 WHEN MATCHED THEN
 UPDATE SET studentName = s.studentName,
stream = s.stream,
marks = s.marks,
createDate = s.createDate,
updateDate = s.updateDate
 WHEN NOT MATCHED THEN
 INSERT (studentId,studentName,stream,marks,createDate,updateDate)
 VALUES
(s.studentId,s.studentName,s.stream,s.marks,s.createDate,s.updateDate);
END

GO

