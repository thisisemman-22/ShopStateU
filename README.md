# ShopStateU Backend

ShopStateU is a campus-exclusive marketplace platform designed to assist Batangas State University Alangilan students in buying, selling, or renting second-hand academic materials. This repository contains the backend implementation of the system, built using Spring Boot and Java.

## Features
- **User Management**: Secure registration and login using college emails.
- **Product Listings**: Create, update, search, and delete product listings.
- **Chat System**: Direct messaging between buyers and sellers.
- **Saved Items**: Save favorite listings for later.
- **Notification Settings**: Customize notification preferences.
- **Admin Tools**: Manage users and listings.

## Technologies Used
- **Java**: Backend programming language.
- **Spring Boot**: Framework for building the backend.
- **Hibernate**: ORM for database interactions.
- **PostgreSQL**: Database for storing application data.
- **Heroku**: Deployment platform.

## Project Structure
```
ShopStateU/
├── src/
│   ├── main/
│   │   ├── java/com/shopstateu/
│   │   │   ├── controllers/    # REST API controllers
│   │   │   ├── models/         # Data models
│   │   │   ├── repositories/   # Database repositories
│   │   │   ├── services/       # Business logic
│   │   │   ├── utils/          # Utility classes
│   │   ├── resources/          # Configuration files
├── target/                     # Compiled files
├── uploads/                    # Uploaded images
├── pom.xml                     # Maven configuration
├── Procfile                    # Heroku deployment configuration
```

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/thisisemman-22/ShopStateU.git
   ```
2. Navigate to the backend directory:
   ```bash
   cd ShopStateU/Draft Backend
   ```
3. Build the project using Maven:
   ```bash
   mvn clean install
   ```
4. Run the application:
   ```bash
   java -jar target/shopstateu-backend-1.0-SNAPSHOT.jar
   ```

## Deployment
The backend is configured for deployment on Heroku. Ensure the following:
- A `Procfile` is present to specify the startup command.
- Environment variables for database credentials are set in Heroku.

## Future Plans
- **Flutter Frontend**: A Flutter-based frontend will be added to this repository.
- **Enhanced Features**: Additional features like payment integration and analytics.

## About
ShopStateU addresses the financial burden of expensive course materials by enabling peer-to-peer trades within the university community. It promotes resourcefulness and sustainability while demonstrating the practical application of object-oriented programming principles.