# School Management System (API)

A role-based **School Management System** built with **Ruby on Rails (API-only)** that allows Admins, School Admins, and Students to manage schools, courses, batches, and enrollments in a secure and scalable way.

This project has been developed strictly according to the given assignment requirements and is designed to reflect real-world backend architecture and best practices.

---

## 🚀 Features Overview

* Role-based authentication & authorization (Admin, SchoolAdmin, Student)
* JWT-based authentication
* RESTful APIs with proper HTTP methods
* Enrollment request & approval workflow
* Clean project structure using controllers, serializers, and concerns
* Postman collection for API testing

---

## 👥 User Roles & Responsibilities

### 1️⃣ Admin

Admins have **full control** over the system.

**Capabilities:**

* Create Schools
* Create School Admins
* Manage system-level data

---

### 2️⃣ School Admin

School Admins manage a specific school.

**Capabilities:**

* Update school information
* Create Courses
* Create Batches
* Add Students to Batches
* Approve or Reject Enrollment Requests raised by Students

---

### 3️⃣ Student

Students interact with batches and enrollments.

**Capabilities:**

* Raise enrollment requests for batches
* View classmates enrolled in the same batch

---

## 🧱 Application Architecture

* **Framework:** Ruby on Rails (API-only)
* **Authentication:** JWT (JSON Web Token)
* **Authorization:** Role-based access control using concerns
* **Database:** PostgreSQL
* **Serialization:** ActiveModel Serializers

---

## 📂 Project Structure

```
app/
 ├── controllers/
 │   └── api/v1/
 │       ├── auth_controller.rb
 │       ├── schools_controller.rb
 │       ├── school_admins_controller.rb
 │       ├── courses_controller.rb
 │       ├── batches_controller.rb
 │       ├── student_batches_controller.rb
 │       └── enrollment_requests_controller.rb
 │
 ├── models/
 │   ├── user.rb
 │   ├── school.rb
 │   ├── course.rb
 │   ├── batch.rb
 │   ├── student_batch.rb
 │   └── enrollment_request.rb
 │
 ├── serializers/
 │   └── *_serializer.rb
 │
 └── concerns/
     └── authorization.rb
```

---

## 🔐 Authentication Flow

* User logs in using email & password
* Server returns a **JWT token**
* Token must be passed in request headers for protected routes

**Header format:**

```
Authorization: Bearer <jwt_token>
```

---

## 🔄 Enrollment Workflow

1. Student raises an enrollment request for a batch
2. Request status defaults to `pending`
3. School Admin reviews the request
4. School Admin can:

   * `approve`
   * `reject`
5. Approved students are added to the batch

---

## 📡 API Endpoints (Sample)

### Authentication

| Method | Endpoint       | Description       |
| ------ | -------------- | ----------------- |
| POST   | /api/v1/signup | User Registration |
| POST   | /api/v1/login  | User Login        |

### Schools (Admin)

| POST | /api/v1/schools | Create School |
| PATCH | /api/v1/schools/:id | Update School |

### Courses (School Admin)

| POST | /api/v1/courses | Create Course |

### Batches (School Admin)

| POST | /api/v1/batches | Create Batch |

### Enrollment Requests (Student / School Admin)

| POST | /api/v1/enrollment_requests | Raise Request |
| PATCH | /api/v1/enrollment_requests/:id | Approve / Reject |

---

## 🧪 Testing

The application is designed to support comprehensive testing.

Recommended test coverage includes:

* Authentication & authorization
* Enrollment request lifecycle
* Role-based access restrictions

*(RSpec/Minitest can be used for automated testing)*

---

## 📮 Postman Collection

A Postman collection is included to test all APIs.

**Steps to use:**

1. Import the Postman collection
2. Set base URL to `http://localhost:3000`
3. Add JWT token in Authorization header
4. Test APIs role-wise

---

## ⚙️ Setup Instructions

### Prerequisites

* Ruby 3.x
* Rails 7.x
* PostgreSQL

### Steps

```bash
git clone https://github.com/vikas2580/school_management.git
cd school_management
bundle install
rails db:create db:migrate db:seed
rails server
```

Server will start at:

```
http://localhost:3000
```

---

## 🌱 Future Enhancements (Optional)

* Student progress tracking
* Pagination & filtering
* Role-based dashboards
* API documentation using Swagger

---

## 📌 Assignment Compliance

✔ All mandatory features implemented
✔ Role-based access control
✔ Enrollment approval workflow
✔ REST API support
✔ Clean, scalable architecture
✔ Ready for evaluation and verification

---

## 👨‍💻 Author

**Vikas**
Backend Developer (Ruby on Rails)

---

## 📄 License

This project is created for assignment and learning purposes.

