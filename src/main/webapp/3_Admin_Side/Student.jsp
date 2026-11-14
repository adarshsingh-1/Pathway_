
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Students | PATHWAY</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/3_Admin_Side/student.css">

    <style>
        .student-row[hidden] {
            display: none !important;
        }

        .student-row .avatar {
            text-transform: uppercase;
        }

        .contact-link {
            text-decoration: none;
        }

        .status.registered {
            display: inline-block;
        }

        #noStudentsFound {
            display: none;
            padding: 25px;
            text-align: center;
        }
    </style>
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
            <a href="${pageContext.request.contextPath}/admin-dashboard">🎛️ Overview</a>
            <a href="${pageContext.request.contextPath}/admin-students" class="active">👥 Students</a>
            <a href="${pageContext.request.contextPath}/admin-companies">🏢 Companies</a>
            <a href="${pageContext.request.contextPath}/admin-opportunities">💼 Opportunities</a>
            <a href="${pageContext.request.contextPath}/admin-applications">📋 Applications</a>
        </nav>

        <a href="${pageContext.request.contextPath}/admin-logout" class="signout"> [→ Sign out </a>

    </aside>


    <!-- MAIN CONTENT -->
    <main class="main-content">

        <!-- TOPBAR -->
        <header class="topbar">

            <div>
                <p>Placement Operations</p>
                <h1>Students</h1>
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


        <!-- PAGE CONTENT -->
        <section class="page-content">

            <!-- INTRODUCTION -->
            <div class="intro">

                <div>
                    
                    <p>Know the people behind the pipeline.</p>
                </div>

                <span class="records" id="recordsCount">
                    <c:choose>
                        <c:when test="${not empty requestScope.students}">
                            <c:out value="${fn:length(requestScope.students)}"/>
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                    records
                </span>

            </div>


            <!-- ERROR MESSAGE -->
            <c:if test="${not empty requestScope.errorMessage}">
                <div class="error-message">
                    <c:out value="${requestScope.errorMessage}"/>
                </div>
            </c:if>


            <!-- SEARCH AND FILTER -->
            <div class="search-section">

                <div class="search-box">
                    <input
                        type="search"
                        id="studentSearch"
                        placeholder="Search by name, email, skills..."
                        aria-label="Search students">
                </div>

                <select
                    class="branch-filter"
                    id="branchFilter"
                    aria-label="Filter students by branch">

                    <option value="all">All branches</option>
                    <option value="Computer Science">Computer Science</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Electronics & Communication">
                        Electronics &amp; Communication
                    </option>
                    <option value="Mechanical Engineering">
                        Mechanical Engineering
                    </option>

                </select>

            </div>


            <!-- STUDENT TABLE -->
            <div class="student-table">

                <!-- TABLE HEADER -->
                <div class="table-header">

                    <div class="student-column">STUDENT</div>
                    <div class="academic-column">ACADEMICS</div>
                    <div class="skills-column">SKILLS</div>
                    <div class="status-column">STATUS</div>
                    <div class="contact-column">CONTACT</div>

                </div>


                <!-- DATABASE STUDENTS -->
                <c:forEach var="student"
                           items="${requestScope.students}">

                    <div class="student-row"
                         data-branch="${fn:escapeXml(student.branch)}">

                        <!-- STUDENT DETAILS -->
                        <div class="student-column">

                            <div class="student-details">

                                <div class="avatar">
                                    <c:choose>
                                        <c:when test="${not empty student.fullName}">
                                            <c:out value="${fn:substring(student.fullName, 0, 1)}"/>
                                        </c:when>
                                        <c:otherwise>?</c:otherwise>
                                    </c:choose>
                                </div>

                                <div>
                                    <h3>
                                        <c:out value="${student.fullName}"
                                               default="Unnamed Student"/>
                                    </h3>

                                    
                                </div>

                            </div>

                        </div>


                        <!-- ACADEMICS -->
                        <div class="academic-column">

                            <strong>
                                <c:out value="${student.cgpa}"/> CGPA
                            </strong>

                            <p>
                                <c:out value="${student.branch}"
                                       default="Branch not provided"/>
                            </p>

                            

                        </div>


                        <!-- SKILLS -->
                        <div class="skills-column">

                            <c:choose>

                                <c:when test="${not empty student.skills}">

                                    <c:forTokens var="skill"
                                                 items="${student.skills}"
                                                 delims=",">

                                        <span class="skill">
                                            <c:out value="${fn:trim(skill)}"/>
                                        </span>

                                    </c:forTokens>

                                </c:when>

                                <c:otherwise>

                                    <span class="skill">
                                        No skills added
                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </div>


                        <!-- STATUS -->
                        <div class="status-column">

                            <span class="status active">
                                Active
                            </span>

                        </div>


                        <!-- CONTACT -->
                        <div class="contact-column">

                            <c:choose>

                                <c:when test="${not empty student.email}">

                                    <a
                                        href="mailto:<c:out value='${student.email}'/>"
                                        class="contact-link"
                                        aria-label="Email student">

                                        <span>✉</span>

                                    </a>

                                </c:when>

                                <c:otherwise>
                                    <span>No email available</span>
                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>

                </c:forEach>


                <!-- NO STUDENTS IN DATABASE -->
                <c:if test="${empty requestScope.students
                              and empty requestScope.errorMessage}">

                    <p id="emptyStudentsMessage">
                        No students registered yet.
                    </p>

                </c:if>


                <!-- NO SEARCH RESULTS -->
                <p id="noStudentsFound">
                    No students found.
                </p>

            </div>

        </section>

    </main>


    <!-- SEARCH AND FILTER SCRIPT -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const searchInput =
                document.getElementById("studentSearch");

            const branchFilter =
                document.getElementById("branchFilter");

            const studentRows =
                document.querySelectorAll(".student-row");

            const recordsCount =
                document.getElementById("recordsCount");

            const noStudentsFound =
                document.getElementById("noStudentsFound");

            const emptyStudentsMessage =
                document.getElementById("emptyStudentsMessage");

            function normalizeBranch(branch) {

                const value = branch.trim().toLowerCase();

                if (value === "computer science"
                        || value === "cs"
                        || value === "cse") {
                    return "computer science";
                }

                if (value === "information technology"
                        || value === "it") {
                    return "information technology";
                }

                if (value === "electronics & communication"
                        || value === "electronics and communication"
                        || value === "ece") {
                    return "electronics & communication";
                }

                if (value === "mechanical engineering"
                        || value === "mechanical"
                        || value === "me") {
                    return "mechanical engineering";
                }

                return value;
            }

            function filterStudents() {

                const searchText =
                    searchInput.value.trim().toLowerCase();

                const selectedBranch =
                    branchFilter.value === "all"
                        ? "all"
                        : normalizeBranch(branchFilter.value);

                let visibleCount = 0;

                studentRows.forEach(function (row) {

                    const studentDetails =
                        row.textContent.toLowerCase();

                    const matchesSearch =
                        studentDetails.includes(searchText);

                    const studentBranch =
                        normalizeBranch(
                            row.getAttribute("data-branch") || ""
                        );

                    const matchesBranch =
                        selectedBranch === "all"
                        || studentBranch === selectedBranch;

                    if (matchesSearch && matchesBranch) {

                        row.hidden = false;
                        visibleCount++;

                    } else {

                        row.hidden = true;

                    }

                });

                recordsCount.textContent =
                    visibleCount
                    + (visibleCount === 1 ? " record" : " records");

                noStudentsFound.style.display =
                    studentRows.length > 0 && visibleCount === 0
                        ? "block"
                        : "none";

                if (emptyStudentsMessage) {
                    emptyStudentsMessage.style.display =
                        studentRows.length === 0 ? "block" : "none";
                }
            }

            searchInput.addEventListener("input", filterStudents);

            branchFilter.addEventListener("change", filterStudents);

            filterStudents();

        });
    </script>

</body>
</html>
