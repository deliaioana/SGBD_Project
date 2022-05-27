CREATE OR REPLACE PACKAGE exceptions_package
AS
    user_not_registered EXCEPTION;
    PRAGMA EXCEPTION_INIT(user_not_registered, -20001);
    
    already_registered EXCEPTION;
    PRAGMA EXCEPTION_INIT(already_registered, -20000);
end;
/