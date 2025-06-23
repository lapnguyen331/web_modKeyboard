# 🛒 An Nhien Essential Oil E-Commerce Platform (Spring Boot + React)


## 🛍️ Features

### 🧾 Product Browsing
- Product cards with thumbnails
- Product detail view
- Related products
- Recently visited products
- Most viewed / Most sold products

### 🔍 Filtering & Sorting
- Filter by price, category, and volume
- Sort by price, rating, popularity
- Pagination support for product listings

### ❤️ Product Interaction
- Add to cart
- Add to wishlist
- Rate products (1–5 stars)
- Comment on products and reply to comments
- Paginated comment view

---

### 🛒 Cart & Orders

#### Cart Management
- Add/remove items from cart
- Update item quantities
- View cart summary
- Checkout with **MoMo** or **VNPay**
- Order summary before payment

#### Order Management
- View all personal orders
- View order details
- Track order status (processing, delivered)
- Admin/Employee: update order status
- Paginated order history
---

### 👤 User Account & Authentication

#### Authentication & Security
- Register / Login / Logout
- Forgot password with token-based recovery via email
- JWT-based authentication (Access/Refresh tokens)
- Role-based access (Customer, Employee, Admin)

#### User Profile
- View and update profile info
- Change password
- Create and manage custom products
- Manage own product listings

---

### 🛠️ Admin & Employee Features

#### Product Management
- Create, update, and delete products
- Upload product images to cloud storage
- Attach and manage product images

#### Order Management
- View all orders with pagination
- View and update order details and status

#### Category Management
- Create, update, delete categories
- Soft delete and restore categories

#### Comment & Rating Moderation
- View all comments and ratings
- Hide/show comments
- Reply to product ratings

#### Account Management
- View all customer accounts
- Block/unblock users
- View user details
- Manage employee accounts (add, view, block)

#### Site Metadata Management
- Manage homepage carousel
- About Us and Policy page management

---

### 📊 Statistics & Dashboard
- Revenue by day, week, month
- Order count and revenue statistics
- Product sales charts
- Category-based revenue breakdown

---

### 🔔 Real-Time Features
- Real-time notifications via WebSocket
  - shop activities
  - New orders
  - Order status updates
  - Admin actions

---

## ⚙️ Tech Stack

### 🧠 Backend
- **Java 21**, **Spring Boot**
- **Spring Security**, **JWT** (Access & Refresh tokens)
- **Spring Data JPA**, **MySQL**
- **WebSocket** for real-time updates

### 💻 Frontend
- **React JS**
- **Redux Toolkit (RTK)** & **RTK Query**
- **Tailwind CSS** for styling
- **ShadCN/UI** for beautiful components
