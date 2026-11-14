
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Pathway - Coordinator Dashboard</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/3_Admin_Side/Dashboard.css">

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>

    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">

            <div class="logo">
                <img
                    src="${pageContext.request.contextPath}/3_Admin_Side/image/pathway%20logo.png"
                    width="150"
                    height="75"
                    alt="Pathway Logo">
            </div>

            <p class="menu-title">OPERATIONS CONSOLE</p>

            <nav>
                <a href="${pageContext.request.contextPath}/admin-dashboard" class="active">🎛️ Overview</a>
                <a href="${pageContext.request.contextPath}/admin-students">👥 Students</a>
                <a href="${pageContext.request.contextPath}/admin-companies">🏢 Companies</a>
                <a href="${pageContext.request.contextPath}/admin-opportunities">💼 Opportunities</a>
                <a href="${pageContext.request.contextPath}/admin-applications">📋 Applications</a>
            </nav>

            <a href="${pageContext.request.contextPath}/admin-logout" class="signout"> [→ Sign out </a>

        </aside>


        <!-- MAIN CONTENT -->
        <main class="main-content">

            <!-- HEADER -->
            <header class="topbar">

                <div>
                    <p>Placement Operations</p>

                    <h1>
                        Welcome,
                        <c:out value="${sessionScope.adminName}"
                               default="Administrator"/>.
                    </h1>
                </div>

                <span class="user">
                    <c:choose>
                        <c:when test="${not empty sessionScope.adminName}">
                            <c:out value="${fn:toUpperCase(fn:substring(sessionScope.adminName, 0, 1))}"/>
                        </c:when>
                        <c:otherwise>
                            AD
                        </c:otherwise>
                    </c:choose>
                </span>

            </header>


            <!-- DASHBOARD -->
            <section class="dashboard">

                <div class="intro">
                    <p>
                        A clear view of the placement season — monitor
                        students, partner companies, opportunities, and
                        student applications from one workspace.
                    </p>

                    <span class="date"><c:out value="${requestScope.currentDate}"/></span>
                </div>


                <!-- STATISTICS -->
                <div class="stats">

                    <!-- STUDENTS -->
                    <div class="stat-card">

                        <div class="stat-top">
                            <div class="stat-icon student-icon">👥</div>

                            <a href="${pageContext.request.contextPath}/admin-students"
                               class="trend">↗</a>
                        </div>

                        <h2>
                            <c:out value="${requestScope.totalStudents}"
                                   default="0"/>
                        </h2>

                        <p >
                            Students
                            <span>
                                +<c:out value="${requestScope.newStudentsThisWeek}" default="0"/>
                                this week
                            </span>
                        </p>

                    </div>


                    <!-- COMPANIES -->
                    <div class="stat-card">

                        <div class="stat-top">
                            <div class="stat-icon company-icon">🏢</div>

                            <a href="${pageContext.request.contextPath}/admin-companies"
                               class="trend">↗</a>
                        </div>

                        <h2>
                            <c:out value="${requestScope.totalCompanies}"
                                   default="0"/>
                        </h2>

                        <p>
                            Partner companies
                            <span>
                                +<c:out value="${requestScope.newCompaniesThisMonth}" default="0"/>
                                this month
                            </span>
                        </p>

                    </div>


                    <!-- OPPORTUNITIES -->
                    <div class="stat-card">

                        <div class="stat-top">
                            <div class="stat-icon opportunity-icon">💼</div>

                            <a href="${pageContext.request.contextPath}/admin-opportunities"
                               class="trend">↗</a>
                        </div>

                        <h2>
                            <c:out value="${requestScope.totalOpportunities}"
                                   default="0"/>
                        </h2>

                        <p>
                            Open opportunities
                            <span>
                                <c:out value="${requestScope.closingSoon}" default="0"/>
                                closing soon
                            </span>
                        </p>

                    </div>


                    <!-- APPLICATIONS -->
                    <div class="stat-card">

                        <div class="stat-top">
                            <div class="stat-icon placement-icon">📋</div>

                            <a href="${pageContext.request.contextPath}/admin-applications"
                               class="trend">↗</a>
                        </div>

                        <h2>
                            <c:out value="${requestScope.totalApplications}"
                                   default="0"/>
                        </h2>


                        <p>
                            Placement rate
                            <span>
                                <c:out value="${requestScope.placementRate}"
                                       default="0.0%"/>
                                this season
                            </span>
                        </p>

                    </div>

                </div>


                <!-- LOWER CONTENT -->
                <div class="content-section">

                    <!-- LEFT CONTENT -->
                    <div class="left-content">

                        <div class="section-heading">
                            <h2>Season at a glance</h2>
                            <p>A little context behind the numbers</p>
                        </div>

                        <div class="chart-panel">

                            <div class="chart-header">
                                <div>
                                    <h3>Applications to placements</h3>
                                    <p>Monthly application statistics</p>
                                </div>

                                <span class="chart-icon">▥</span>
                            </div>


                            <div class="chart-area">
                                <canvas id="applicationStatusChart"></canvas>
                            </div>


                        </div>

                    </div>


                    <!-- RIGHT CONTENT -->
                    <div class="right-content">

                        <div class="activity-header">
                            <h2>Recent activity</h2>

                            <a href="${pageContext.request.contextPath}/admin-applications">
                                Review applications →
                            </a>
                        </div>


                        <!-- RECENT ACTIVITY -->
                        <div class="activity-list">

                            <c:choose>

                                <c:when test="${not empty requestScope.recentActivities}">

                                    <c:forEach var="activity"
                                               items="${requestScope.recentActivities}">

                                        <div class="activity-item">

                                            <span class="activity-dot"></span>

                                            <div class="activity-content">

                                                <h3>
                                                    <c:out value="${activity.title}"/>
                                                </h3>

                                                <p>
                                                    <c:out value="${activity.description}"/>
                                                </p>

                                            </div>

                                            <time>
                                                <c:out value="${activity.date}"/>
                                            </time>

                                        </div>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <div class="activity-item">
                                        <div class="activity-content">
                                            <h3>No recent activity</h3>
                                            <p>New student, company, opportunity and application activities will appear here.</p>
                                        </div>
                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div> 

                    </div>

                </div>

            </section>

        </main>


        <!-- DYNAMIC APPLICATION STATUS GRAPH -->


        <script>

            const months = [
                "Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug",
                "Sep", "Oct", "Nov", "Dec"
            ];

            // APPLICATIONS DATA
            const applicationsData = [
            <c:forEach items="${requestScope.monthlyStats.applications}"
                       var="value" varStatus="loop">
                <c:out value="${value}"/><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            // INTERVIEWED DATA
            const interviewedData = [
            <c:forEach items="${requestScope.monthlyStats.interviewed}"
                       var="value" varStatus="loop">
                <c:out value="${value}"/><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            // SELECTED DATA
            const selectedData = [
            <c:forEach items="${requestScope.monthlyStats.selected}"
                       var="value" varStatus="loop">
                <c:out value="${value}"/><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            // REJECTED DATA
            const rejectedData = [
            <c:forEach items="${requestScope.monthlyStats.rejected}"
                       var="value" varStatus="loop">
                <c:out value="${value}"/><c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            // CREATE GRAPH
            const ctx = document.getElementById(
                    'applicationStatusChart'
                    );

            new Chart(ctx, {

                type: 'line',

                data: {

                    labels: months,

                    datasets: [

                        {
                            label: 'Applications',
                            data: applicationsData,
                            borderColor: '#2463b5',
                            backgroundColor: '#2463b5',
                            tension: 0.3,
                            borderWidth: 2,
                            pointRadius: 4
                        },

                        {
                            label: 'Interviewed',
                            data: interviewedData,
                            borderColor: '#e6a23c',
                            backgroundColor: '#e6a23c',
                            tension: 0.3,
                            borderWidth: 2,
                            pointRadius: 4
                        },

                        {
                            label: 'Selected',
                            data: selectedData,
                            borderColor: '#388e3c',
                            backgroundColor: '#388e3c',
                            tension: 0.3,
                            borderWidth: 2,
                            pointRadius: 4
                        },

                        {
                            label: 'Rejected',
                            data: rejectedData,
                            borderColor: '#d9534f',
                            backgroundColor: '#d9534f',
                            tension: 0.3,
                            borderWidth: 2,
                            pointRadius: 4
                        }

                    ]

                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },

                    plugins: {

                        legend: {
                            display: true,
                            position: 'bottom'
                        }

                    },

                    scales: {

                        y: {
                            beginAtZero: true,
                            ticks: {
                                precision: 0
                            }
                        }

                    }

                }

            });

        </script>


    </body>

</html>
