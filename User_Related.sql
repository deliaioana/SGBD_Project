CREATE OR REPLACE PACKAGE user_package AS
    procedure register_user(p_email_user IN VARCHAR2, p_username IN VARCHAR2, 
        p_password IN VARCHAR2, return_code out number);
        
    procedure login(p_email IN VARCHAR2, p_password IN VARCHAR2, return_code out number);
    
END;


CREATE OR REPLACE PACKAGE BODY user_package AS

    procedure register_user(p_email_user IN VARCHAR2, p_username IN VARCHAR2, 
    p_password IN VARCHAR2, return_code out number) AS
    
    counter INTEGER;
    counter2 INTEGER;
    v_user_counter INTEGER;
        
    BEGIN
        select count(*) into counter2 from accounts;
        v_user_counter := counter2+1;
        
        IF (NOT p_email_user IS NULL AND NOT p_username IS NULL AND NOT p_password IS NULL) THEN
            SELECT COUNT(*) INTO counter FROM accounts WHERE email = p_email_user;
            IF (counter = 0) THEN
                INSERT INTO accounts VALUES (v_user_counter, p_email_user, p_username, p_password);
                return_code := 0; -- successfully registered 
            else
            return_code := 1; -- already registered
            END IF;
        else
            return_code := 2; -- invalid entry
        END IF;    
        
    END;

----------------------------------------------------------------------------------------------------

    procedure login(p_email in varchar2, p_password in varchar2, return_code out number) as
    counter integer;
    begin
        select count(*) into counter from accounts where email=p_email and pass=p_password;
        if counter=1 then
            return_code := 0; -- successfully logged in 
        end if;
        return_code := 1; -- not registered
    end login;
END;




