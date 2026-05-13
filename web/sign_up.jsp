<%-- 
    Document   : sign_up
    Updated on : 13 May 2026
    Author     : VUKONA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Join the Wall | Sign Up</title>
        <link rel="stylesheet" type="text/css" href="css.css">
    </head>
    <body>
        <div class="dashboard-header">
            <h1>Create Your Account</h1>
            <p>Join the community of producers and plugin enthusiasts.</p>
        </div>

        <div class="profile-links" style="max-width: 600px; margin: auto;">
            <form action="UserServlet.do" method="POST">
                
                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <label>First Name *</label>
                        <input type="text" name="fname" required>
                    </div>
                    <div style="flex: 1;">
                        <label>Last Name *</label>
                        <input type="text" name="lname" required>
                    </div>
                </div>

                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <label>User Name *</label>
                        <input type="text" name="username" required>
                    </div>
                    <div style="flex: 1;">
                        <label>Id Number *</label>
                        <input type="text" name="id" required>
                    </div>
                </div>

                <label>Email *</label>
                <input type="email" name="email" required>

                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <label>Date of Birth *</label>
                        <input type="date" name="dob" required>
                    </div>
                    <div style="flex: 1;">
                        <label>Location *</label>
                        <input type="text" name="location">
                    </div>
                </div>

                <label>Roles: </label>
                <select name="type" style="width: 100%; padding: 12px; background: #1e1e1e; color: white; border: 1px solid #333; border-radius: 6px;">
                    <option value="User">Default User</option>
                    <option value="Artist">Artist</option>
                </select>

                <hr style="margin: 25px 0; border: 0; border-top: 1px solid #333;">

                <label>Password *</label>
                <input type="password" id="password" name="password" required>

                <label>Confirmation Password *</label>
                <input type="password" id="confirmPassword" name="confirmPassword" onkeyup="checkPasswordMatch();" required>
                <span id="message" style="font-size: 12px; display: block; margin-top: 5px;"></span>

                <div style="margin-top: 30px;">
                    <input type="submit" value="Sign Up" class="btn-save" style="width: 100%;">
                </div>
            </form>
            
            <p style="margin-top: 20px; text-align: center; color: #b3b3b3;">
                Already have an account? <a href="sign_in.jsp">Sign In</a>
            </p>
        </div>

        <script>
            function checkPasswordMatch() {
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var message = document.getElementById("message");
                var submitBtn = document.querySelector('input[type="submit"]');

                if (password === "" || confirmPassword === "") {
                    message.innerHTML = "";
                    return;
                }

                if (password === confirmPassword) {
                    message.style.color = "#4CAF50";
                    message.innerHTML = "✔ Passwords match";
                    submitBtn.disabled = false;
                    submitBtn.style.opacity = "1";
                } else {
                    message.style.color = "#ff4444";
                    message.innerHTML = "✖ Passwords do not match";
                    submitBtn.disabled = true;
                    submitBtn.style.opacity = "0.5";
                }
            }
        </script>
    </body>
</html>