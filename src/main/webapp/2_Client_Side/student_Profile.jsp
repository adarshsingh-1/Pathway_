<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pathway - My Profile</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/2_Client_Side/student_Profile.css">
    </head>

    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/2_Client_Side/image/pathway logo.png" width="150px" height="75px" alt="logo">
            </div>

            <p class="menu-title">STUDENT WORKSPACE</p>

            <nav>
                <a href="${pageContext.request.contextPath}/student-dashboard">📋 Overview</a>
                <a href="${pageContext.request.contextPath}/opportunities">🔎 Find opportunities</a>
                <a href="${pageContext.request.contextPath}/student-applications">📝 My applications</a>
                <a href="${pageContext.request.contextPath}/student-profile" class="active">👤 My profile</a>
            </nav>

            <a href="${pageContext.request.contextPath}/logout" class="signout">[→ Sign out</a>
        </aside>
        <!-- MAIN CONTENT -->
        <main class="main-content">

            <header class="topbar">
                <div>
                    <p>The story behind the application</p>
                    <h1>Your profile</h1>
                </div>
                <span class="user" id="f_user">AR</span>
            </header>

            <!-- PROFILE CONTENT -->
            <section class="dashboard">

                <!-- LEFT CONTENT -->
                <div class="left-content">

                    <!-- PROFILE CARD -->
                    <div class="profile-card">

                        <!-- PROFILE IMAGE -->
                        <div class="profile-icon" id="profileInitials">
                            AR
                        </div>

                        <!-- STUDENT DETAILS -->
                        <div class="profile-details">

                            <h2 id="name">Your name</h2>

                            <p id="profileBranch">
                                CSE · Class of 2029
                            </p>

                            <p id="profileEmail"></p>
                            <p id="profilePhone"></p>
                            <p id="profileYear"></p>
                            <p id="profileCgpa"></p>
                            <p id="profileSkills"></p>

                        </div>

                        <!-- PROFILE STRENGTH -->
                        <div class="profile-strength">

                            <div class="strength-info">
                                <span>Profile strength</span>
                                <strong>82%</strong>
                            </div>

                            <!-- PROGRESS BAR -->
                            <div class="progress-bar">
                                <div class="progress"></div>
                            </div>

                        </div>

                        <!-- RESUME CARD -->
                        <div class="profile-resume">
                            <a id="profileResume" hidden target="_blank" rel="noopener noreferrer"></a>
                        </div>

                    </div>

                    <!-- RESUME CARD -->
                    <div class="resume-card">

                        <div class="resume-title">
                            <h3>Resume</h3>
                        </div>

                        <input class="p" type="url" id="resumeCardInput" placeholder="Add a link to your latest resume.">

                    </div>

                </div>

                <!-- RIGHT CONTENT -->
                <div class="right-content">

                    <!-- PROFILE FORM -->
                    <div class="profile-form">

                        <!-- FORM HEADER -->
                        <div class="form-header">

                            <div>
                                <h2>The essentials</h2>
                                <p>Keep this current ? it is your first introduction.</p>
                            </div>

                            

                        </div>

                        <!-- FORM -->
                        <form id="profileForm" action="${pageContext.request.contextPath}/update-profile" method="post">

                            <!-- FULL NAME AND EMAIL -->
                            <div class="form-row">

                                <!-- FULL NAME -->
                                <div class="form-group">
                                    <label for="uname">Full name</label>

                                    <input type="text" id="uname" name="fullName" value="${student.fullName}">
                                </div>

                                <!-- EMAIL -->
                                <div class="form-group">
                                    <label for="email">Email</label>

                                    <input type="email" id="email" name="email"  value="${student.email}" readonly>
                                </div>

                            </div>

                            <!-- PHONE AND BRANCH -->
                            <div class="form-row">

                                <!-- PHONE -->
                                <div class="form-group">
                                    <label for="phone">Phone</label>

                                    <input type="tel" id="phone" name="phone" value="${student.phone}">
                                </div>

                                <!-- BRANCH -->
                                <div class="form-group">
                                    <label for="branch">Branch / major</label>

                                    <input type="text" id="branch" name="branch" value="${student.branch}">
                                </div>

                            </div>

                            <!-- GRADUATION YEAR AND CGPA -->
                            <div class="form-row">

                                <!-- GRADUATION YEAR -->
                                <div class="form-group">
                                    <label for="year">Graduation year</label>

                                    <input type="number" id="year" name="passingYear" value="${student.passingYear}">
                                </div>

                                <!-- CGPA -->
                                <div class="form-group">
                                    <label for="cgpa">CGPA</label>

                                    <input type="number" id="cgpa" name="cgpa" step="0.01" value="${student.cgpa}">
                                </div>

                            </div>

                            <!-- SKILLS -->
                            <div class="form-group full-width">
                                <label for="skills">Skills (comma separated)</label>

                                <input type="text" id="skills" name="skills"  value="${student.skills}">
                            </div>

                            <!-- RESUME LINK -->
                            <div class="form-group full-width">
                                <label for="resume">Resume link</label>

                                <input type="url" id="resume" name="resume" value="${student.resume}">
                            </div>

                            <!-- SAVE BUTTON -->
                            <div class="form-footer">
                                <button type="submit" class="save-button">
                                    Save changes
                                    <span>✓</span>
                                </button>
                            </div>

                        </form>

                    </div>

                </div>

            </section>

        </main>

        <!-- INTERNAL JAVASCRIPT -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                // Form inputs
                const uname = document.getElementById("uname");
                const branch = document.getElementById("branch");
                const year = document.getElementById("year");
                const resume = document.getElementById("resume");
                const resumeCardInput = document.getElementById("resumeCardInput");
                const profileInitials = document.getElementById("profileInitials");



                // Profile card elements
                const name = document.getElementById("name");
                const profileBranch = document.getElementById("profileBranch");
                const progress = document.querySelector(".progress");
                const strength = document.querySelector(".strength-info strong");
                localStorage.setItem("studentName", uname.value.trim());

                function updateProfile() {

                    const studentName = uname.value.trim();

                    profileInitials.textContent = studentName
                            ? studentName.split(/\s+/)
                            .map(word => word.charAt(0))
                            .join("")
                            .substring(0, 2)
                            .toUpperCase()
                            : "AR";

                    f_user.textContent = studentName
                            ? studentName.split(/\s+/)
                            .map(word => word.charAt(0))
                            .join("")
                            .substring(0, 2)
                            .toUpperCase()
                            : "AR";
                    // Update name
                    name.textContent = uname.value.trim() || "Your name";

                    // Update branch and graduation year
                    profileBranch.textContent =
                            (branch.value.trim() || "Branch not added") +
                            " · Class of " + (year.value || "Not added");

                    // Update resume input from the form
                    resumeCardInput.value = resume.value;

                    // Check whether resume link is valid
                    let validResume = false;

                    try {
                        const url = new URL(resume.value.trim());

                        validResume =
                                (url.protocol === "https:" || url.protocol === "http:") &&
                                url.hostname.includes(".");
                    } catch {
                        validResume = false;
                    }

                    // Calculate profile strength using 8 fields
                    const fields = [
                        uname.value.trim(),
                        document.getElementById("email").value.trim(),
                        document.getElementById("phone").value.trim(),
                        branch.value.trim(),
                        year.value.trim(),
                        document.getElementById("cgpa").value.trim(),
                        document.getElementById("skills").value.trim(),
                        validResume
                    ];

                    const completed = fields.filter(Boolean).length;
                    const percentage = Math.round(
                            (completed / fields.length) * 100
                            );

                    // Update progress bar
                    progress.style.width = percentage + "%";
                    strength.textContent = percentage + "%";
                }

                // Update when the main form changes
                [
                    uname,
                    branch,
                    year,
                    resume,
                    document.getElementById("email"),
                    document.getElementById("phone"),
                    document.getElementById("cgpa"),
                    document.getElementById("skills")
                ].forEach(function (input) {
                    input.addEventListener("input", updateProfile);
                    input.addEventListener("change", updateProfile);
                });

                // Update the form's resume field when the resume card input changes
                resumeCardInput.addEventListener("input", function () {
                    resume.value = resumeCardInput.value;
                    updateProfile();
                });

                // Display initial values
                updateProfile();

            });
        </script>

    </body>

</html>