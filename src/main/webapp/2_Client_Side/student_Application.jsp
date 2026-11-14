<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">

        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">

        <title>Pathway - My Applications</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/2_Client_Side/student_Application.css">

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
                <a href="${pageContext.request.contextPath}/student-applications" class="active">📝 My applications</a>
                <a href="${pageContext.request.contextPath}/student-profile">👤 My profile</a>
            </nav>

            <a href="${pageContext.request.contextPath}/logout" class="signout">[→ Sign out</a>
        </aside>


        <!-- MAIN CONTENT -->
        <main class="main-content">

            <!-- HEADER -->
            <header class="topbar">

                <div>

                    <p>Keep your momentum visible</p>

                    <h1>Your applications</h1>

                </div>

                <span class="user" id="f_user">
                    AR
                </span>

            </header>


            <!-- APPLICATIONS CONTENT -->
            <section class="dashboard">

                <!-- FILTER BUTTONS -->
                <div class="filters">

                    <button type="button"
                            class="filter active"
                            data-filter="all"
                            aria-pressed="true">
                        All
                    </button>

                    <button type="button"
                            class="filter"
                            data-filter="applied"
                            aria-pressed="false">
                        Applied
                    </button>

                    <button type="button"
                            class="filter"
                            data-filter="shortlisted"
                            aria-pressed="false">
                        Shortlisted
                    </button>

                    <button type="button"
                            class="filter"
                            data-filter="interview"
                            aria-pressed="false">
                        Interview
                    </button>

                    <button type="button"
                            class="filter"
                            data-filter="selected"
                            aria-pressed="false">
                        Selected
                    </button>

                </div>




                <!-- APPLICATION DATA -->
                <div class="application-table">

                    <!-- TABLE HEADER -->
                    <div class="table-header">

                        <div class="role-column">ROLE</div>
                        <div class="applied-column">APPLIED</div>
                        <div class="status-column">STATUS</div>
                        <div class="package-column">PACKAGE</div>

                    </div>
                    <div>
                        <c:choose>

                            <c:when test="${not empty applications}">

                                <c:forEach var="application"
                                           items="${applications}">

                                    <div class="application-row"
                                         data-status="${application.status.toLowerCase()}">

                                        <!-- Company -->
                                        <div class="role-column role-details">

                                            <h3>
                                                ${application.jobTitle}
                                            </h3>

                                            <p>
                                                ${application.companyName}
                                            </p>

                                        </div>


                                        <!-- Status -->
                                        <div class="applied-column">



                                            ${application.applicationDate}

                                        </div>


                                        <!-- Applied Date -->
                                        <div class="status-column">

                                            ${application.status}

                                        </div>

                                        <div class="package-column salary">
                                            ${application.packageAmount}
                                        </div>

                                    </div>

                                </c:forEach>

                            </c:when>


                            <c:otherwise>

                                <p id="emptyMessage">
                                    No applications found for this status.
                                </p>

                            </c:otherwise>

                        </c:choose>
                    </div>
                </div>

                <!-- Empty message used by JavaScript -->

                <p id="emptyMessage"
                   hidden>
                    No applications found for this status.
                </p>

            </section>

        </main>


        <!-- JAVASCRIPT -->
        <script>

            document.addEventListener(
                    "DOMContentLoaded",
                    function () {

                        const studentName =
                                localStorage.getItem("studentName");

                        if (studentName &&
                                studentName.trim()) {

                            const initials =
                                    studentName.trim()
                                    .split(/\s+/)
                                    .map(
                                            word =>
                                        word.charAt(0)
                                    )
                                    .join("")
                                    .substring(0, 2)
                                    .toUpperCase();

                            document.getElementById("f_user")
                                    .textContent = initials;
                        }


                        const filterButtons =
                                document.querySelectorAll(".filter");

                        const applicationRows =
                                document.querySelectorAll(
                                        ".application-row"
                                        );

                        const applicationCount =
                                document.getElementById(
                                        "applicationCount"
                                        );

                        const emptyMessage =
                                document.getElementById(
                                        "emptyMessage"
                                        );


                        function filterApplications(
                                filterValue
                                ) {

                            let visibleCount = 0;

                            applicationRows.forEach(
                                    function (row) {

                                        const rowStatus =
                                                row.dataset.status;

                                        const showRow =
                                                filterValue === "all"
                                                || rowStatus === filterValue;

                                        row.style.display =
                                                showRow
                                                ? ""
                                                : "none";

                                        if (showRow) {
                                            visibleCount++;
                                        }

                                    }
                            );


                            filterButtons.forEach(
                                    function (button) {

                                        const isActive =
                                                button.dataset.filter
                                                === filterValue;

                                        button.classList.toggle(
                                                "active",
                                                isActive
                                                );

                                        button.setAttribute(
                                                "aria-pressed",
                                                isActive
                                                ? "true"
                                                : "false"
                                                );

                                    }
                            );


                            applicationCount.textContent =
                                    visibleCount
                                    + (
                                            visibleCount === 1
                                            ? " application"
                                            : " applications"
                                            );


                            if (emptyMessage) {

                                emptyMessage.hidden =
                                        visibleCount !== 0;

                            }

                        }


                        filterButtons.forEach(
                                function (button) {

                                    button.addEventListener(
                                            "click",
                                            function () {

                                                filterApplications(
                                                        button.dataset.filter
                                                        );

                                            }
                                    );

                                }
                        );


                        filterApplications("all");

                    }
            );

        </script>

    </body>
</html>