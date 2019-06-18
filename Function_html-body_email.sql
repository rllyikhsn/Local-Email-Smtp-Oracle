create or replace function body_message(b_message in clob)
return clob
is
message clob;
begin
message := '<!doctype html>
<html>
<head>
    <title>Test HTML message</title>
</head>
<body>
    <p>This is a : '||b_message||'<b>HTML</b> <i>version</i> of the test message.</p>
    <a href="http://joget-dev01:8090/jw/web/userview/FPHPU_Workflow/viewUser/_/detailFPHPU?id=9098_FPHPU_Workflow_approval">Href</a>
</body>
</html>';
return message;
end;
/
