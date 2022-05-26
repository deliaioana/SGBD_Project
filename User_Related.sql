CREATE OR REPLACE PACKAGE user_package AS
    FUNCTION register_user(p_email_user IN VARCHAR2, p_username IN VARCHAR2, 
        p_password IN VARCHAR2) RETURN VARCHAR2;
        
    FUNCTION login(p_email IN VARCHAR2, p_password IN VARCHAR2) RETURN VARCHAR2;
    
END;


CREATE OR REPLACE PACKAGE BODY user_package AS

    FUNCTION register_user(p_email_user IN VARCHAR2, p_username IN VARCHAR2, 
    p_password IN VARCHAR2) RETURN VARCHAR2 AS
    counter INTEGER;
    BEGIN

        IF (NOT p_email_user IS NULL AND NOT p_username IS NULL AND NOT p_password IS NULL) THEN
            SELECT COUNT(*) INTO counter FROM accounts WHERE email = p_email_user;
            IF (counter = 0) THEN
                INSERT INTO accounts VALUES (p_email_user, p_username, p_password);
                RETURN 0; -- successfully registered 
            END IF;
            RETURN 1; -- already registered
        END IF;    
        RETURN 2; -- invalid entry
    END register_user;

----------------------------------------------------------------------------------------------------

    FUNCTION login(p_email in varchar2, p_password in varchar2) return varchar2 as
    counter integer;
    begin
        select count(*) into counter from accounts where email=p_email and pass=p_password;
        if counter=1 then
            return '0'; -- successfully logged in 
        end if;
        return '1'; -- not registered
    end login;
END;




