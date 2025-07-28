CREATE PROCEDURE [dbo].[usp_write_watermark] @LastModifiedtime
datetime, @TableName varchar(100)
AS
BEGIN
 UPDATE [dbo].[WaterMark]
 SET waterMarkVal = @LastModifiedtime
WHERE tableName = @TableName
END

GO

