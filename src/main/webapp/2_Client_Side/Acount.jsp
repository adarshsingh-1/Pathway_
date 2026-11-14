<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Registration</title>
        <link rel="stylesheet" href="account.css">
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
                    <a href="StudentLogin.jsp">← Back</a>
                </div>
                <div class="right-Section-form">
                    <div class="img"><img  src="image/pathway logo.png" alt="Pathway Logo" height="50px"></div>
                    <h2>Create your account</h2>
                    <p>Join pathway and start preparing for your next step</p>
                    <form class="form"
                          action="${pageContext.request.contextPath}/student-register"
                          method="post">
                        <span>Name:</span><br>
                        <input class="input"
                               type="text"
                               id="name"
                               name="fullName"
                               placeholder="Enter your name"
                               >

                        <br>
                        <span>Email address</span><br>
                        <input class="input"
                               id="email"
                               type="email"
                               name="email"
                               placeholder="Enter your email address"
                               >

                        <br>
                        <span>Password</span><br>
                        <input class="input"
                               type="password"
                               id="password"
                               name="password"
                               placeholder="Enter your password"
                               >

                        <br>
                        <span>Conform Password</span><br>
                        <input class="input"
                               type="password"
                               id="confirmPassword"
                               
                               placeholder="Enter same password"
                               >

                        <br>

                        <button type="submit" class="login">
                            Continue
                        </button>
                        <div class="or"><span class="span1">or</span></div>
                        <button type="button" class="google-btn">
                            Continue with Google
                        </button>

                    </form>
                    <div class="form_buttom">
                        <p class="p">Already have an account?</p><a href="StudentLogin.jsp">Sign in</a>
                    </div>

                </div>

            </div>
        </div>
    </body>
    <script>

        document.querySelector(".form").addEventListener("submit", function (event) {

            let name = document.getElementById("name").value.trim();
            let email = document.getElementById("email").value.trim();
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;

            // 1. Name Validation
            if (!/^[a-zA-Z]+(?: [a-zA-Z]+)*$/.test(name) || name.length < 3 || name.length > 50) {
                alert("Please enter a valid name (3-50 characters, alphabets only)");
                event.preventDefault();
                return;
            }

            // 2. Email Validation
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (email === "" || !emailPattern.test(email)) {
                alert("Please enter a valid email address");
                event.preventDefault();
                return;
            }

            // 3. Password Required
            if (password === "") {
                alert("Please enter your password");
                event.preventDefault();
                return;
            }

            // 4. Password Length
            if (password.length < 8 || password.length > 20) {
                alert("Password must contain 8 to 20 characters");
                event.preventDefault();
                return;
            }

            // 5. Password Strength
            if (!/(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9\s])/.test(password) || /\s/.test(password)) {
                alert("Password must contain uppercase, lowercase, number and special character without spaces");
                event.preventDefault();
                return;
            }

            // 6. Confirm Password Required
            if (confirmPassword === "") {
                alert("Please confirm your password");
                event.preventDefault();
                return;
            }

            // 7. Password Matching
            if (password !== confirmPassword) {
                alert("Password and confirm password do not match");
                event.preventDefault();
                return;
            }

            // All validations passed
            // Form will move to the next page.

        });

    </script>

</html>