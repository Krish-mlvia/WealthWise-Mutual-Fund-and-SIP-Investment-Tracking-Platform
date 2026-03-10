# WealthWise Backend Setup Guide

This guide explains how to create and configure the **Spring Boot backend** for the WealthWise project.

The backend will handle:

- User Signup
- User Login
- Database Storage
- API Communication with the Frontend

---

# Step 1 — Create the Spring Boot Backend Project

## Open Spring Initializr

Go to:

https://start.spring.io

### Project Settings

| Setting | Value |
|------|------|
| Project | Maven |
| Language | Java |
| Spring Boot | Latest Stable |
| Packaging | Jar |
| Java | 17 |

### Project Metadata

| Field | Value |
|------|------|
| Group | com.wealthwise |
| Artifact | wealthwise-backend |
| Name | wealthwise-backend |

### Add Dependencies

Add the following dependencies:

- Spring Web
- Spring Data JPA
- MySQL Driver
- Spring Security
- Lombok
- Validation

Click **Generate**, download the project, and extract it.

Open the project in:

- IntelliJ IDEA
- Eclipse
- VS Code

---

# Step 2 — Configure MySQL Database Connection

Open:


src/main/resources/application.properties


Add the following configuration:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/wealthwise
spring.datasource.username=root
spring.datasource.password=yourpassword

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect

This configuration connects Spring Boot with the wealthwise MySQL database.

Step 3 — Create the Project Folder Structure

Inside:

src/main/java/com/wealthwise

Create the following packages:

controller
service
repository
model
config
Final Project Structure
wealthwise-backend
 ├── controller
 ├── service
 ├── repository
 ├── model
 └── config
Step 4 — Create the User Model (Entity)

Create file:

model/User.java
package com.wealthwise.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name="users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Column(unique = true)
    private String email;

    private String password;
}

This entity maps the users table in the database to Java objects.

Step 5 — Create the Repository

Create file:

repository/UserRepository.java
package com.wealthwise.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.wealthwise.model.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

}

The Repository layer handles database queries.

Step 6 — Create the Service Layer

Create file:

service/AuthService.java
package com.wealthwise.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wealthwise.repository.UserRepository;
import com.wealthwise.model.User;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    public User signup(User user) {
        return userRepository.save(user);
    }

    public User login(String email, String password) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if(!user.getPassword().equals(password)) {
            throw new RuntimeException("Invalid password");
        }

        return user;
    }
}

The Service layer handles the business logic.

Step 7 — Create the Controller

Create file:

controller/AuthController.java
package com.wealthwise.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.wealthwise.service.AuthService;
import com.wealthwise.model.User;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/signup")
    public User signup(@RequestBody User user) {
        return authService.signup(user);
    }

    @PostMapping("/login")
    public User login(@RequestBody User user) {
        return authService.login(user.getEmail(), user.getPassword());
    }
}

The Controller layer exposes REST APIs to the frontend.

Step 8 — Run the Backend Server

Run the main application class:

WealthwiseBackendApplication.java

Spring Boot will start the server at:

http://localhost:8080
Step 9 — Test APIs Using Postman
Signup API

Request

POST http://localhost:8080/api/auth/signup

Body → JSON

{
"name":"Rahul",
"email":"rahul@gmail.com",
"password":"123456"
}

Check MySQL:

SELECT * FROM users;

The new user should appear in the table.

Login API

Request

POST http://localhost:8080/api/auth/login

Body:

{
"email":"rahul@gmail.com",
"password":"123456"
}

Response:

User data will be returned.

Step 10 — Connect React Login Page

Install Axios in the frontend project:

npm install axios
Signup Request
axios.post("http://localhost:8080/api/auth/signup", {
name,
email,
password
});
Login Request
axios.post("http://localhost:8080/api/auth/login", {
email,
password
})
.then(res=>{
localStorage.setItem("user", JSON.stringify(res.data))
});
Step 11 — Redirect to Dashboard

After login:

navigate("/dashboard")

The user will be redirected to the portfolio dashboard.

Step 12 — Next Feature Development

After authentication is working, implement the following features.

1️⃣ SIP Management
APIs
POST /api/sip/add
GET /api/sip/user/{id}
Tables Used
sip_investments
transactions
2️⃣ Portfolio Summary
API
GET /api/portfolio/summary
Data Source
portfolio_summary
3️⃣ Charts and Analytics

Use libraries such as:

Chart.js

Recharts

Dashboard should display:

Total Invested

Current Value

Profit / Loss

CAGR


---

✅ This version is **fully GitHub README compatible** with:

- proper **Markdown headings**
- **syntax-highlighted code blocks**
- **tables**
- **clean folder structure formatting**
- **API documentation sections**

---

If you want, I can also convert this into a **complete professional README with architecture di
