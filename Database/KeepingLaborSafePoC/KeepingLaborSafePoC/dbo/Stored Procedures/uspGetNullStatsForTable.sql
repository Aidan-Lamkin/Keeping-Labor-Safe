CREATE PROCEDURE dbo.uspGetNullStatsForTable @TABLE_NAME NVARCHAR(50), @TABLE_SCHEMA NVARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE 
			@sql          NVARCHAR(max),
			@col          NVARCHAR(50)
	CREATE TABLE #t
	  (
		 id      INT IDENTITY(1, 1),
		 ColName VARCHAR(50),
		 [NULL%] DECIMAL(8, 2)
	  )
	DECLARE c_cursor CURSOR FOR
	  SELECT column_Name
	  FROM   [INFORMATION_SCHEMA].[COLUMNS]
	  WHERE  TABLE_NAME = @TABLE_NAME
			 AND TABLE_SCHEMA = @TABLE_SCHEMA
			 AND IS_Nullable = 'YES'
	OPEN c_cursor;
	FETCH NEXT FROM c_cursor INTO @col;
	WHILE ( @@FETCH_STATUS = 0 )
	  BEGIN
		  SET @sql = N' INSERT INTO #t (ColName, [NULL%])
			SELECT TOP 1 ''' + @col
					 + ''' , (COUNT(*) over() *1.0- COUNT(' + @col
					 + ') OVER()*1.0)/COUNT(*) Over() *100.0 as [NULL%] FROM '
					 + Quotename(@TABLE_SCHEMA) + '.'
					 + Quotename( @TABLE_NAME)
		  print @sql
		  EXEC (@sql);
		  FETCH NEXT FROM c_cursor INTO @col;
	  END
	CLOSE c_cursor;
	DEALLOCATE c_cursor;
	   SELECT ColName,  [NULL%] FROM #t
	DROP TABLE #t
END