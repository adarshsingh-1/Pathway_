
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.pathway.model.Application"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pathway - Application Review</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/3_Admin_Side/Applications.css">
    </head>

    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">

            <div class="logo">
                <img
                    src="${pageContext.request.contextPath}/3_Admin_Side/image/pathway%20logo.png"
                    width="150px"
                    height="75px"
                    alt="logo">
            </div>

            <p class="menu-title">OPERATIONS CONSOLE</p>

            <nav>
                <a href="${pageContext.request.contextPath}/admin-dashboard">🎛️ Overview</a>
                <a href="${pageContext.request.contextPath}/admin-students">👥 Students</a>
                <a href="${pageContext.request.contextPath}/admin-companies">🏢 Companies</a>
                <a href="${pageContext.request.contextPath}/admin-opportunities">💼 Opportunities</a>
                <a href="${pageContext.request.contextPath}/admin-applications" class="active">📋 Applications</a>
            </nav>

            <a href="${pageContext.request.contextPath}/admin-logout" class="signout"> [→ Sign out </a>

        </aside>


        <!-- MAIN CONTENT -->
        <main class="main-content">

            <!-- HEADER -->
            <header class="topbar">

                <div>
                    <p>Move the right people forward</p>
                    <h1>Application review</h1>
                </div>

                <span class="user">AR</span>

            </header>


            <!-- CONTENT -->
            <section class="content">

                <!-- INTRO -->
                <div class="intro">

                    <p>
                        A queue is just a collection of potential.
                        Give each one a thoughtful next step.
                    </p>

                    <select class="status-filter">
                        <option value="All statuses">All statuses</option>
                        <option value="Applied">Applied</option>
                        <option value="Shortlisted">Shortlisted</option>
                        <option value="Interview">Interview</option>
                        <option value="Selected">Selected</option>
                        <option value="Rejected">Rejected</option>
                    </select>

                </div>


                <!-- ERROR MESSAGE -->
                <c:if test="${not empty requestScope.applicationError}">
                    <div class="error-message">
                        <c:out value="${requestScope.applicationError}"/>
                    </div>
                </c:if>


                <!-- APPLICATION TABLE -->
                <div class="application-table">

                    <!-- TABLE HEADER -->
                    <div class="table-header">

                        <div class="candidate-column">
                            CANDIDATE
                        </div>

                        <div class="opportunity-column">
                            OPPORTUNITY
                        </div>

                        <div class="applied-column">
                            APPLIED
                        </div>

                        <div class="status-column">
                            STATUS
                        </div>

                        <div class="change-column">
                            CHANGE STATUS
                        </div>

                    </div>


                    <!-- DYNAMIC APPLICATION ROWS -->
                    <c:choose>

                        <c:when test="${not empty requestScope.applications}">

                            <c:forEach var="application"
                                       items="${requestScope.applications}">

                                <div class="application-row">

                                    <!-- CANDIDATE -->
                                    <div class="candidate-column">

                                        <h3>
                                            <c:out value="${application.studentName}"/>
                                        </h3>

                                        <small>
                                            ID
                                            <c:out value="${application.studentId}"/>
                                        </small>





                                    </div>


                                    <!-- OPPORTUNITY -->
                                    <div class="opportunity-column">

                                        <h3>
                                            <c:out value="${application.jobTitle}"/>
                                        </h3>

                                        <p>
                                            <c:out value="${application.companyName}"/>
                                            · ₹<c:out value="${application.packageAmount}"/> LPA
                                        </p>

                                    </div>


                                    <!-- APPLICATION DATE -->
                                    <div class="applied-column">

                                        <c:out value="${application.applicationDate}"/>

                                    </div>


                                    <!-- CURRENT STATUS -->
                                    <div class="status-column">

                                        <c:set var="currentStatus"
                                               value="${application.status}"/>

                                        <c:choose>

                                            <c:when test="${currentStatus eq 'Pending'}">
                                                <span class="status pending">Pending</span>
                                            </c:when>

                                            <c:when test="${currentStatus eq 'Applied'}">
                                                <span class="status pending">Applied</span>
                                            </c:when>

                                            <c:when test="${currentStatus eq 'Shortlisted'}">
                                                <span class="status shortlisted">Shortlisted</span>
                                            </c:when>

                                            <c:when test="${currentStatus eq 'Interview'}">
                                                <span class="status interview">Interview</span>
                                            </c:when>

                                            <c:when test="${currentStatus eq 'Selected'
                                                            or currentStatus eq 'Accepted'}">
                                                    <span class="status selected">Selected</span>
                                            </c:when>

                                            <c:when test="${currentStatus eq 'Rejected'}">
                                                <span class="status rejected">Rejected</span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="status">
                                                    <c:out value="${currentStatus}"/>
                                                </span>
                                            </c:otherwise>

                                        </c:choose>

                                    </div>


                                    <!-- CHANGE STATUS -->
                                    <div class="change-column">
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin-applications">

                                            <input type="hidden" name="action" value="updateStatus">

                                            <input type="hidden"
                                                   name="applicationId"
                                                   value="${application.applicationId}">

                                            <select name="status"
                                                    aria-label="Change application status"
                                                    onchange="this.form.submit()">

                                                <option value="Pending" ${application.status eq 'Pending' ? 'selected="selected"' : ''}>Pending</option>

                                                <option value="Applied" ${application.status eq 'Applied' ? 'selected="selected"' : ''}>Applied</option>

                                                <option value="Shortlisted" ${application.status eq 'Shortlisted' ? 'selected="selected"' : ''}>Shortlisted</option>

                                                <option value="Interview" ${application.status eq 'Interview' ? 'selected="selected"' : ''}>Interview</option>

                                                <option value="Selected" ${application.status eq 'Selected' or application.status eq 'Accepted' ? 'selected="selected"' : ''}>Selected</option>

                                                <option value="Rejected" ${application.status eq 'Rejected' ? 'selected="selected"' : ''}>Rejected</option>

                                            </select>
                                        </form>
                                    </div>

                                </div>

                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <div class="application-row">
                                <div class="candidate-column">
                                    <h3>No applications found</h3>
                                    <small>
                                        Applications submitted by students will appear here.
                                    </small>
                                </div>
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </section>

        </main>


        <!-- STATUS FILTER -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                const statusFilter = document.querySelector(".status-filter");
                const applicationRows = document.querySelectorAll(
                        ".application-row"
                        );

                function filterApplications() {

                    const selectedStatus =
                            statusFilter.value.toLowerCase();

                    applicationRows.forEach(function (row) {

                        const statusElement = row.querySelector(".status");

                        if (!statusElement) {
                            row.style.display = "";
                            return;
                        }

                        const statusText =
                                statusElement.textContent.trim().toLowerCase();

                        const isVisible =
                                selectedStatus === "all statuses"
                                || statusText === selectedStatus
                                || (
                                        selectedStatus === "applied"
                                        && statusText === "pending"
                                        )
                                || (
                                        selectedStatus === "selected"
                                        && statusText === "accepted"
                                        );

                        row.style.display = isVisible ? "" : "none";

                    });
                }

                statusFilter.addEventListener("change", filterApplications);

            });
        </script>

    </body>
</html>
