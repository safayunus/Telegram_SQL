
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Telegram_Mesaj_Gonder] @Mesaj nvarchar(120)
AS
BEGIN
	SET NOCOUNT ON;


DECLARE @responseText NVARCHAR(2000);
DECLARE @responseXML NVARCHAR(2000);
DECLARE @ret INT;
DECLARE @status NVARCHAR(32);
DECLARE @statusText NVARCHAR(32);
DECLARE @token INT;
DECLARE @url NVARCHAR(256);
DECLARE @TelegramToken NVARCHAR(256);
DECLARE @TelegramChatId NVARCHAR(32)
DECLARE @TelegramMesaj  NVARCHAR(256)

SET @TelegramToken = /*********/
SET @TelegramChatId = /*********/

SET @url = 'https://api.telegram.org/bot' + @TelegramToken +'/sendMessage?chat_id='+@TelegramChatId+'&parse_mode=Markdown&text='+@Mesaj;


EXEC @ret = sp_OACreate 'MSXML2.ServerXMLHTTP', @token OUT;
IF @ret <> 0 RAISERROR('Unable to open HTTP connection.', 10, 1);


EXEC @ret = sp_OAMethod @token, 'open', NULL, 'POST', @url, 'false';
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Authentication', null;
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Content-type', null;
EXEC @ret = sp_OAMethod @token, 'send', NULL, null;


EXEC @ret = sp_OAGetProperty @token, 'status', @status OUT;
EXEC @ret = sp_OAGetProperty @token, 'statusText', @statusText OUT;
EXEC @ret = sp_OAGetProperty @token, 'responseText', @responseText OUT;



PRINT 'Status: ' + @status + ' (' + @statusText + ')';
PRINT 'Response text: ' + @responseText;


EXEC @ret = sp_OADestroy @token;
IF @ret <> 0 RAISERROR('Unable to close HTTP connection.', 10, 1);

END
