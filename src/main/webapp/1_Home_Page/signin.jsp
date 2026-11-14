
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign in</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/1_Home_Page/styleLogin1.css">
</head>

<body>

    <div class="page">

        <section class="left-section">

            <div class="logo">
                <img
                    src="${pageContext.request.contextPath}/1_Home_Page/image/pathway%20logo.png"
                    width="150px"
                    height="75px"
                    alt="logo">
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

        </section>


        <!-- RIGHT SECTION -->
        <section class="right-section">

            <div class="login-container">

                <!-- Back -->
                <div class="back">
                    
                    <a href="${pageContext.request.contextPath}/home">
                        <span class="back-arrow">←</span>Back
                    </a>
                </div>

                <!-- Heading -->
                <div class="welcome">
                    WELCOME BACK
                </div>

                <h2>Where are you headed?</h2>

                <p class="subtitle">
                    Choose your workspace to continue the journey.
                </p>


                <!-- Workspace Selection -->
                <div class="workspace-selection">

                    <!-- Hidden Radio Buttons -->
                    <input type="radio"
                           name="workspace"
                           id="student"
                           checked>

                    <input type="radio"
                           name="workspace"
                           id="coordinator">

                    <div class="workspace-container">

                        <!-- Student -->
                        <label for="student"
                               class="workspace-card student-card">

                            <div class="card-icon">🎓</div>

                            <h3>Student</h3>

                            <p>
                                Find opportunities & track your journey
                            </p>

                        </label>

                        <!-- Coordinator -->
                        <label for="coordinator"
                               class="workspace-card coordinator-card">

                            <div class="card-icon coordinator-icon">♧</div>

                            <h3>Coordinator</h3>

                            <p>
                                Run placements with a clear view
                            </p>

                        </label>

                    </div>


                    <!-- Workspace Buttons -->
                    <div class="enter-actions">

                        <!-- Student Button -->
                        <a href="${pageContext.request.contextPath}/2_Client_Side/StudentLogin.jsp"
                           class="enter-button student-enter">

                            <span>Enter student workspace</span>
                            <span class="button-arrow">→</span>

                        </a>

                        <!-- Coordinator Button -->
                        <a href="${pageContext.request.contextPath}/3_Admin_Side/admin_Login.jsp"
                           class="enter-button coordinator-enter">

                            <span>Enter coordinator workspace</span>
                            <span class="button-arrow">→</span>

                        </a>

                    </div>

                </div>

            </div>

        </section>

    </div>


    <!-- Workspace Background Change -->
    <script>

        const studentRadio = document.getElementById("student");
        const coordinatorRadio = document.getElementById("coordinator");

        const leftSection = document.querySelector(".left-section");
        const coordinatorButton = document.querySelector(".coordinator-enter");

        function changeWorkspaceColor() {

            if (coordinatorRadio.checked) {

                coordinatorButton.style.backgroundColor = "#01605c";
                leftSection.style.backgroundColor = "#01605c";

            } else {

                coordinatorButton.style.backgroundColor = "rgb(20, 20, 67)";
                leftSection.style.backgroundColor = "rgb(20, 20, 67)";

            }

        }

        studentRadio.addEventListener("change", changeWorkspaceColor);
        coordinatorRadio.addEventListener("change", changeWorkspaceColor);

        changeWorkspaceColor();

    </script>

</body>
</html>
