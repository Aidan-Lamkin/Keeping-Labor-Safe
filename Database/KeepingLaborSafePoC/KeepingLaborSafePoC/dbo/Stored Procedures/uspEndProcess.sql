CREATE PROCEDURE dbo.uspEndProcess 
AS
BEGIN
	UPDATE dbo.tKlsCase
	SET m_IsEnabled = 0
	  , m_ExecutionDt = GETUTCDATE()
	WHERE m_IsEnabled = 1
END