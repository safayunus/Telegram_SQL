sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Ole Automation Procedures', 1;  
GO  
RECONFIGURE;  
GO  




EXEC Telegram_Mesaj_Gonder @Mesaj='https://www.linkedin.com/in/safayunus/'