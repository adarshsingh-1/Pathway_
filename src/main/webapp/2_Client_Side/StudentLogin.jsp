<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Login</title>
        <link rel="stylesheet" href="studentLogin.css">
    </head>

    <body>
        <div class="page">

            <!-- left section -->
            <div class="left-section">

                <div class="logo">
                    <img src="image/pathway logo.png" width="150px" height="75px" alt="logo">
                </div>
                <div class="left-content">

                    <div class="small-heading">
                        YOUR ACCESS POINT
                    </div>

                    <h1>
                        Make the next<br>
                        move feel clear.
                    </h1>

                    <p>
                        A focused workspace for the people starting out — and the
                        people helping them get there.
                    </p>

                </div>

                <!-- Bottom Navigation -->
                <div class="steps">
                    <span>01 / Explore</span>
                    <span>02 / Prepare</span>
                    <span>03 / Launch</span>
                </div>

            </div>

            <!-- Right Section -->
            <div class="right-Section">
                <div class="right-Section-Header">
                    <a href="${pageContext.request.contextPath}/1_Home_Page/signin.jsp">
                       ← Back
                    </a>
                </div>
                <div class="right-Section-form">
                    <div class="img"><img src="image/pathway logo.png" alt="Pathway Logo" height="50px"></div>
                    <h2>Welcome Back</h2>
                    <p>Sign in to continue your placement journey</p>
                    <form class="form"
                          action="${pageContext.request.contextPath}/student-login"
                          method="post">
                        <span class="span">Email address:</span><br>
                        <input class="input"
                               id="email"
                               type="email"
                               name="email"
                               placeholder="Enter your email address"
                        >

                        <br>
                        <span class="span">Password:</span><br>
                        <input class="input"
                               id="password"
                               type="password"
                               name="password"
                               placeholder="Enter your password"
                        >

                        <br>

                        <button type="submit" class="login">
                            Continue
                        </button>
                        <div class="or"><span>or</span></div>
                        <button type="button" class="google-btn">
                            <img src="https://www.google.com/favicon.ico" alt="Google">
                            Continue with Google
                        </button>
                    </form>
                    <div class="form_buttom">
                        <p class="p">Don't have an account?</p><a href="Acount.jsp">Sign up</a>
                    </div>

                </div>

            </div>
        </div>
    </body>
    <script>

        // Email Validation
        function validateEmail() {

            let email = document.getElementById("email").value;

            // 1. Email required
            if (email == "") {
                alert("Please enter email");
                return false;
            }

            // 2. Email format
            let emailPattern =
                    /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!emailPattern.test(email)) {
                alert("Please enter valid email");
                return false;
            }

            return true;
        }


        // Password Validation
        function validatePassword() {

            let password = document.getElementById("password").value;

            // 3. Password required
            if (password == "") {
                alert("Please enter password");
                return false;
            }

            // 4. Password minimum 8 characters
            if (password.length < 8) {
                alert("Password must contain at least 8 characters");
                return false;
            }

            // 5. Password strength
            if (!/(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])/.test(password)) {
                alert("Password must contain uppercase, lowercase and number");
                return false;
            }

            return true;
        }


        // Login Validation
        document.querySelector(".form").addEventListener("submit", function (event) {

            if (!validateEmail() || !validatePassword()) {

                event.preventDefault();

            }

        });

    </script>

</html>