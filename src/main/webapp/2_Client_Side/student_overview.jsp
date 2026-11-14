
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PATHWAY Dashboard</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/2_Client_Side/student_overview.css">
    </head>

    <body>

        <aside class="sidebar">

            <div class="logo">
                <img src="${pageContext.request.contextPath}/2_Client_Side/image/pathway logo.png"
                     width="150px"
                     height="75px"
                     alt="logo">
            </div>

            <p class="menu-title">STUDENT WORKSPACE</p>

            <nav>
                <a href="${pageContext.request.contextPath}/student-dashboard" class="active">📋 Overview</a>
                <a href="${pageContext.request.contextPath}/opportunities">🔎 Find opportunities</a>
                <a href="${pageContext.request.contextPath}/student-applications">📝 My applications</a>
                <a href="${pageContext.request.contextPath}/student-profile">👤 My profile</a>
            </nav>

            <a href="${pageContext.request.contextPath}/logout" class="signout">[→ Sign out</a>

        </aside>


        <main class="main-content">

            <header class="topbar">

                <div>

                    <% String studentName = (String) session.getAttribute("studentName"); %>

                    <p>Sunday, 18 October 2026</p>

                    <h1>
                        Welcome <%= studentName != null ? studentName : "Student" %>.
                    </h1>

                </div>

                <span class="user" id="f_user">AR</span>

            </header>


            <div class="dashboard">


                <!-- LEFT CONTENT -->

                <section class="left-content">


                    <!-- WELCOME SECTION -->

                    <div class="welcome">

                        <p class="tab">● YOU ARE ON TRACK</p>

                        <h1>Small steps add up to a<br>
                            career you can see yourself<br> in.</h1>

                        <p>Your profile is looking strong. Keep showing up for the opportunities<br>
                            that match your signal.</p>

                        <a href="${pageContext.request.contextPath}/opportunities">
                            Browse opportunities →
                        </a>

                    </div>


                    <!-- OPEN OPPORTUNITIES HEADING -->

                    <div class="section-heading">

                        <div>
                            <h3>Open opportunities</h3>
                            <p>Picked for an ambitious next step</p>
                        </div>

                        <div class="a">
                            <a href="${pageContext.request.contextPath}/opportunities">
                                View all →
                            </a>
                        </div>

                    </div>


                    <!-- DYNAMIC OPPORTUNITY CARDS -->

                    <div class="job-cards">

                        <c:choose>

                            <c:when test="${not empty topOpportunities}">

                                <c:forEach var="opportunity"
                                           items="${topOpportunities}"
                                           varStatus="loop">

                                    <a href="${pageContext.request.contextPath}/opportunities">

                                        <div class="job-card">

                                            <c:choose>

                                                <c:when test="${loop.index == 0}">
                                                    <span class="job-icon blue">
                                                        <c:out value="${opportunity.companyName.substring(0,1)}"/>
                                                    </span>
                                                </c:when>

                                                <c:when test="${loop.index == 1}">
                                                    <span class="job-icon green">
                                                        <c:out value="${opportunity.companyName.substring(0,1)}"/>
                                                    </span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="job-icon purple">
                                                        <c:out value="${opportunity.companyName.substring(0,1)}"/>
                                                    </span>
                                                </c:otherwise>

                                            </c:choose>


                                            <span class="status">Open</span>

                                            <h6>
                                                <c:out value="${opportunity.jobTitle}"/>
                                            </h6>

                                            <p>
                                                <c:out value="${opportunity.companyName}"/>
                                            </p>

                                            <div class="job-info">

                                                <b>
                                                    ₹<c:out value="${opportunity.packageAmount}"/> LPA
                                                </b>

                                                <span>
                                                    <c:out value="${opportunity.location}"/>
                                                </span>

                                            </div>

                                        </div>

                                    </a>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <p>No open opportunities available right now.</p>

                            </c:otherwise>

                        </c:choose>

                    </div>


                </section>


                <!-- RIGHT CONTENT -->

                <aside class="right-content">


                    <!-- DYNAMIC SNAPSHOT -->

                    <div class="panel">

                        <h3>Your snapshot</h3>

                        <div class="stats">

                            <div>
                                <strong>
                                    <c:out value="${totalApplications}"/>
                                </strong>
                                <small>Applications</small>
                            </div>

                            <div>
                                <strong>
                                    <c:out value="${shortlistedApplications}"/>
                                </strong>
                                <small>Shortlisted</small>
                            </div>

                            <div>
                                <strong>
                                    <c:out value="${openOpportunities}"/>
                                </strong>
                                <small>Open roles</small>
                            </div>

                            <div>
                                <strong>
                                    <c:out value="${profileCompletion}"/>%
                                </strong>
                                <small>Profile</small>
                            </div>

                        </div>

                    </div>


                    <!-- CALENDAR -->

                    <div class="panel1 calendar">

                        <h3>Next on your calendar</h3>

                        <p>Upcoming campus moments</p>

                        <div class="event">

                            <span>18 OCT</span>

                            <div>
                                <b>Mosaic Labs pre-placement talk</b>
                                <small>Main auditorium · 4:00 PM</small>
                            </div>

                        </div>

                        <div class="event">

                            <span>24 OCT</span>

                            <div>
                                <b>Northstar assessment window</b>
                                <small>Online · 10:00 AM</small>
                            </div>

                        </div>

                        <div class="event">

                            <span>02 NOV</span>

                            <div>
                                <b>Career story workshop</b>
                                <small>Design studio · 3:30 PM</small>
                            </div>

                        </div>

                    </div>


                    <!-- TIP -->

                    <div class="tip">

                        <small>ONE THING FOR TODAY</small>

                        <h3>Add one project to your profile that you would happily talk about for five minutes.</h3>

                        <a href="${pageContext.request.contextPath}/student-profile">
                            Update profile →
                        </a>

                    </div>


                </aside>


                <!-- DYNAMIC RECENT ACTIVITY -->

                <section class="activity">

                    <h3>Recent activity</h3>

                    <p>A quiet record of your momentum</p>

                    <div class="activity-list">

                        <c:choose>

                            <c:when test="${not empty recentActivities}">

                                <c:forEach var="activity"
                                           items="${recentActivities}">

                                    <div>

                                        <section>

                                            <b>
                                                <c:out value="${activity.title}"/>
                                            </b>

                                            <small>
                                                <c:out value="${activity.description}"/>
                                            </small>

                                        </section>

                                        <time>

                                            <c:if test="${not empty activity.activityDate}">

                                                <fmt:formatDate
                                                    value="${activity.activityDate}"
                                                    pattern="d MMM"/>

                                            </c:if>

                                        </time>

                                    </div>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <div>
                                    <section>
                                        <b>No recent activity</b>
                                        <small>Your latest activities will appear here.</small>
                                    </section>
                                </div>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </section>


            </div>

        </main>


        <!-- STUDENT INITIALS -->

        <script>

            const studentName = localStorage.getItem("studentName");

            if (studentName) {

                const initials = studentName
                        .trim()
                        .split(/\s+/)
                        .map(word => word.charAt(0))
                        .join("")
                        .substring(0, 2)
                        .toUpperCase();

                document.getElementById("f_user").textContent = initials;

            }

        </script>

    </body>
</html>
