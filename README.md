# Pathway – Discover. Apply. Achive.

**Pathway** is a web-based placement management system designed to connect students, companies, and placement administrators through a centralized platform.

The system helps administrators manage student profiles, company partnerships, placement opportunities, and student applications. It also provides a dashboard to monitor placement activities and application progress.

## 🚀 Features

### 👨‍💼 Admin Module
- Secure administrator login and logout.
- Admin dashboard with placement statistics.
- View and manage registered students.
- Add, edit, view, and delete company records.
- Add, edit, view, and delete placement opportunities.
- View and manage student applications.
- Update application statuses.
- View recent placement activities.
- Session management for administrator access.

### 🎓 Student Module
- Student registration and login.
- Manage student profile information.
- View available placement opportunities.
- Apply for placement opportunities.
- Track application status.

### 🏢 Company & Opportunity Management
- Store company details, including name, email, location, website, and description.
- Publish job and internship opportunities.
- Manage job title, job type, package, eligibility CGPA, required skills, and application deadline.

### 📊 Dashboard
- Total registered students.
- Total registered companies.
- Total placement opportunities.
- Total student applications.
- Monthly application statistics.
- Recent placement activities.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend programming |
| Jakarta EE 10 | Web application platform |
| JSP | Dynamic web pages |
| Servlets | Request handling and application logic |
| JDBC | Database connectivity |
| MySQL | Relational database |
| HTML5 | Web page structure |
| CSS3 | Styling and layout |
| JavaScript | Client-side interactivity |
| JSTL | Dynamic content rendering |
| Apache Maven | Project and dependency management |
| Apache Tomcat | Application server |
| NetBeans IDE | Development environment |

## 🗄️ Database

The project uses **MySQL** as its database.

Main database tables include:

- `students` – Stores student registration and profile details.
- `companies` – Stores company information.
- `opportunities` – Stores job and internship opportunities.
- `applications` – Stores student applications and their statuses.

The application uses JDBC and DAO classes to communicate with the database.

## 📁 Project Structure

```text
Pathway/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/mycompany/pathway/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── modal/
│       │       ├── model/
│       │       └── util/
│       │
│       └── webapp/
│           ├── 3_Admin_Side/
│           ├── Student_Side/
│           ├── WEB-INF/
│           │   └── web.xml
│           └── index.jsp
│
├── pom.xml
└── README.md
```

*Note: The folder structure above is illustrative; adjust it to match the final structure of your repository.*

## ⚙️ Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/Pathway.git
```

### 2. Open the Project

1. Open NetBeans IDE.
2. Select **File → Open Project**.
3. Select the cloned Pathway project.
4. Allow Maven to download the required dependencies.

### 3. Configure MySQL

1. Start your MySQL server.
2. Create a database for the project.
3. Create the required tables (`students`, `companies`, `opportunities`, and `applications`).
4. Update the database connection details in your `DBConnection.java` file.

Example:

```java
String url = "jdbc:mysql://localhost:3306/pathway";
String username = "root";
String password = "YOUR_PASSWORD";
```

Use your own database credentials.

### 4. Configure the Application Server

- Install Apache Tomcat compatible with Jakarta EE 10.
- Add the server in NetBeans.
- Configure the project to run on that server.

### 5. Run the Project

1. Right-click the Pathway project.
2. Select **Clean and Build**.
3. Select **Run**.
4. Open the application in your browser using the URL provided by the server.

## 🔐 Application Security

- Administrator session validation.
- Session invalidation during logout.
- JDBC `PreparedStatement` usage for database operations.
- Password handling should use secure password hashing before deployment.

## 🎯 Project Objective

The main objective of Pathway is to simplify and organize the campus placement process by providing a centralized platform for students, companies, and placement administrators.

It reduces manual placement coordination and makes it easier to manage opportunities, applications, and recruitment progress.

## 🔮 Future Enhancements

- Email notifications for application status updates.
- Resume upload and download functionality.
- Advanced student and opportunity search.
- Company/recruiter login module.
- Placement reports and analytics.
- Role-based access control.
- Improved password security.


⭐ If you find this project useful, feel free to star the repository!
