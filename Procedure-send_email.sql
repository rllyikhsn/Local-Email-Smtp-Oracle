CREATE OR REPLACE PROCEDURE send_mail (
      smtpHost        IN     VARCHAR2    DEFAULT 'xxxx',  
      smtpPort        IN PLS_INTEGER     DEFAULT 25,  
      mailFrom        IN     VARCHAR2,  
      rcptTo          IN     VARCHAR2,  
      ccTo            IN       VARCHAR2,
      bccTo           IN     VARCHAR2,  
      messageSubject  IN     VARCHAR2,  
      messageBody     IN     VARCHAR2)  
 IS  
  l_conn     UTL_SMTP.connection;  
  --l_ccs     VARCHAR2(2000); 
 BEGIN  
      --open connection  
      l_conn := UTL_SMTP.open_connection(smtpHost, smtpPort);  
      UTL_SMTP.helo(l_conn, smtpHost);  
        
      --prepare headers  
      UTL_SMTP.mail(l_conn, mailFrom);  
      UTL_SMTP.rcpt(l_conn, rcptTo);  
   
      /*if we have multiple recipients or CCs, we must call UTL_SMTP.rcpt once for each one  
      however, we shall specify that there are CCs in the mail header in order for them to appear as such*/  
      /*IF ccs IS NOT NULL THEN  
           FOR i IN ccs.FIRST..ccs.LAST LOOP  
                UTL_SMTP.rcpt(l_conn, ccs(i));--add recipient  
                l_ccs:=l_ccs||ccs(i)||',';--mark as CC  
           END LOOP;  
           --now remove the trailing comma at the end of l_ccs  
           l_ccs:=substr(l_ccs,0,length(l_ccs)-1 );  
      END IF;*/
   
      --start multi line message  
      UTL_SMTP.open_data(l_conn);  
   
      --prepare mail header  
      /*DO NOT USE MON instead of MM in the date pattern if you run the script on machines with different locales as it will be misunderstood  
      and the mail date will appear as 01/01/1970*/  
      UTL_SMTP.write_data(l_conn, 'Date: ' || TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') || UTL_TCP.crlf);  
      UTL_SMTP.write_data(l_conn, 'To: ' || rcptTo || UTL_TCP.crlf);  
      UTL_SMTP.write_data(l_conn, 'Cc: ' || ccTo || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_conn, 'Bcc: ' || bccTo || UTL_TCP.crlf);
      UTL_SMTP.write_data(l_conn, 'From: ' || mailFrom || UTL_TCP.crlf);  
      UTL_SMTP.write_data(l_conn, 'Subject: ' || messageSubject || UTL_TCP.crlf || UTL_TCP.crlf);  
        
      --include the message body  
      UTL_SMTP.write_data(l_conn, messageBody || UTL_TCP.crlf || UTL_TCP.crlf);  
        
      --send the email  
      UTL_SMTP.close_data(l_conn);  
      UTL_SMTP.quit(l_conn);  
 END;
