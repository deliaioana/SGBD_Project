package group.sgbd_java_apis;

import classes.Database;
import org.springframework.web.bind.annotation.*;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

@RestController
@RequestMapping("/api")
public class RegisterController {

    @PostMapping("/register")
    public String newPerson(@RequestParam(value = "email", defaultValue = "email_string") String email,
                            @RequestParam(value = "username", defaultValue = "username_string") String username,
                            @RequestParam(value = "password", defaultValue = "pass_string") String password
    ) {

        Connection connection = Database.getConnection();

        try{
            CallableStatement stmt = connection.prepareCall("{call register_user(?,?,?)}");
            stmt.setString(1, email);
            stmt.setString(2, username);
            stmt.setString(3, password);

            stmt.executeUpdate();

            System.out.println("email: " + email + ", username: " + username + ", password: " + password);

            stmt.close();
            connection.close();
        }
        catch (SQLException e) {
            return "failed";
        }
        return "success";
    }
}