DECLARE  
  cursor data_emp
  is
  select 
    empl_name,email_address
  from
    fifapps.fs_mst_employees
  where
    rownum <= 10 and email_address
    is not null;
  --l_ccs t_ccs;  
BEGIN  
  --ccs:=t_ccs('thendri.lianto@csf.co.id', 'thendri.lianto@csf.co.id');--if necessary add CCs  
  for emp in data_emp
  loop      
  /*send_mail ( 
       mailFrom         => 'thendri.lianto@csf.co.id',  
       rcptTo           => emp.empl_name,
       --bcc            => 'maula.ridwan@csf.co.id',  
       ccTo             => emp.empl_name,
       bccTo            => emp.empl_name,  
       messageSubject   => 'Test Subject Untuk Bapak : '||emp.empl_name,  
       messageBody      => 'Ini pesan Untuk Bapak : '||emp.empl_name);*/
  DBMS_OUTPUT.PUT_LINE('Sending kepada email: '||emp.email_address);      
  emp.empl_name := '';
  emp.email_address := '';
  DBMS_OUTPUT.PUT_LINE('Sending kepada: '||emp.empl_name);     
  end loop;
             
EXCEPTION WHEN OTHERS THEN  
       DBMS_OUTPUT.PUT_LINE('Sending failed: '||SQLERRM);  
END; 
