# ShopStateU

ShopStateU is a campus-exclusive marketplace platform designed to assist Batangas State University Alangilan students in buying, selling, or renting second-hand academic materials. This repository contains both the backend and frontend implementations of the system.

## Features
- **User Management**: Secure registration and login using college emails.
- **Product Listings**: Create, update, search, and delete product listings.
- **Chat System**: Direct messaging between buyers and sellers.
- **Saved Items**: Save favorite listings for later.
- **Notification Settings**: Customize notification preferences.
- **Admin Tools**: Manage users and listings.
- **Mobile App**: A Flutter-based frontend for seamless user experience.

## Technologies Used
- **Backend**:
  - **Java**: Backend programming language.
  - **Spring Boot**: Framework for building the backend.
  - **Hibernate**: ORM for database interactions.
  - **PostgreSQL**: Database for storing application data.
  - **Heroku**: Deployment platform.
- **Frontend**:
  - **Flutter**: Framework for building the mobile application.
  - **FlutterFlow**: Visual development tool for Flutter.

## Project Structure
```
ShopStateU/
├── Draft Backend/                # Backend implementation
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/shopstateu/
│   │   │   │   ├── controllers/    # REST API controllers
│   │   │   │   ├── models/         # Data models
│   │   │   │   ├── repositories/   # Database repositories
│   │   │   │   ├── services/       # Business logic
│   │   │   │   ├── utils/          # Utility classes
│   │   ├── resources/              # Configuration files
│   ├── target/                     # Compiled files
│   ├── uploads/                    # Uploaded images
│   ├── pom.xml                     # Maven configuration
│   ├── Procfile                    # Heroku deployment configuration
├── flutterflow/                   # Flutter frontend implementation
```

## Deployment
The backend is configured for deployment on Heroku.
- A `Procfile` is present to specify the startup command.
- Environment variables for database credentials are set in Heroku.

The frontend can be deployed to platforms like Firebase Hosting or the Google Play Store.