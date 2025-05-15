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

## Code Documentation

This section provides detailed explanations of the key Java files in the ShopStateU backend.

### Main Application Components

1. **ShopstateuApplication.java**
   - Entry point for the Spring Boot application
   - Initializes the application context and runs embedded web server
   - Configures the application's default timezone to Asia/Manila for consistent timestamp handling

2. **SecurityConfig.java**
   - Configures Spring Security for the application
   - Implements CORS (Cross-Origin Resource Sharing) settings to allow frontend access
   - Sets up JWT-based authentication with stateless sessions
   - Defines security filters and authentication entry points
   - Configures endpoint access permissions (public vs. authenticated)
   - Sets up resource handlers for serving uploaded files

### Controllers (API Endpoints)

1. **UserController.java**
   - Manages user registration with email validation (@g.batstate-u.edu.ph domain)
   - Handles user login and JWT token generation
   - Provides endpoints for profile management and retrieval
   - Implements profile picture upload and update functionality

2. **ProductController.java**
   - Exposes endpoints for product listing operations
   - Manages product creation with multi-image uploads
   - Implements filtering by category, seller, and search query
   - Provides endpoints for retrieving product details
   - Handles product update and deletion operations
   - Serves product images through dedicated endpoints

3. **MessageController.java**
   - Facilitates direct messaging between users
   - Provides endpoints for retrieving inbox and sent messages
   - Formats message timestamps for consistent display
   - Includes sender/recipient profile pictures in responses

4. **SavedItemController.java**
   - Manages favorite product listings
   - Handles saving and unsaving operations
   - Prevents duplicate saved items
   - Returns product details along with saved item information

5. **NotificationSettingsController.java**
   - Manages user notification preferences
   - Provides endpoints to retrieve current settings
   - Allows updating notification preferences for different event types

### Models (Data Entities)

1. **User.java**
   - Represents user accounts in the system
   - Contains personal information (fullName, email, college)
   - Stores authentication credentials with password validation
   - Tracks account creation time and profile picture
   - Mapped to the "users" database table

2. **Product.java**
   - Represents items listed for sale or rent
   - Stores product details (name, description, category, price)
   - Manages seller information and posting timestamp
   - Maintains image paths for product photos
   - Establishes relationship with User entity
   - Mapped to the "products" database table

3. **Message.java**
   - Represents communication between users
   - Stores sender and recipient information
   - Contains message content and timestamp
   - Mapped to the "messages" database table

4. **SavedItem.java**
   - Represents favorited product listings
   - Links users to products they've saved
   - Includes timestamp information
   - Mapped to the "saved_items" database table

5. **NotificationSettings.java**
   - Stores user preferences for notifications
   - Contains boolean flags for different notification types:
     - New messages
     - New comments
     - New offers
     - Exclusive deals
     - Feature updates
   - Mapped to the "notification_settings" database table

### Repositories (Database Access)

1. **UserRepository.java**
   - Extends JpaRepository for standard CRUD operations on User entities
   - Provides methods to find users by email and fullName
   - Supports authentication and profile retrieval operations

2. **ProductRepository.java**
   - Manages product data persistence
   - Implements methods to find products by category, seller, and user ID
   - Contains custom JPQL query for flexible product searching across multiple fields
   - Supports full-text search capabilities

3. **MessageRepository.java**
   - Handles message storage and retrieval
   - Provides methods to find messages by recipient or sender
   - Supports the chat system functionality

4. **SavedItemRepository.java**
   - Manages saved item records
   - Provides methods to find saved items by user ID
   - Supports deleting saved items by user and product IDs
   - Checks for existing saved items to prevent duplicates

5. **NotificationSettingsRepository.java**
   - Manages notification preferences data
   - Provides method to find settings by user ID
   - Supports retrieving and updating notification configurations

### Services (Business Logic)

1. **UserService.java**
   - Implements user registration with validation logic
   - Enforces email domain restrictions (@g.batstate-u.edu.ph)
   - Validates password strength (minimum length, uppercase, numbers)
   - Handles authentication for login
   - Manages profile updates and information retrieval

2. **ProductService.java**
   - Coordinates product listing operations
   - Associates products with their sellers
   - Implements search and filtering functionality
   - Manages product lifecycle (creation, updates, deletion)

3. **MessageService.java**
   - Manages user-to-user communication
   - Creates messages with proper sender/recipient associations
   - Retrieves conversation history for inbox/sent messages
   - Handles message timestamp formatting

4. **SavedItemService.java**
   - Implements favorite listing functionality
   - Manages user-product associations for saved items
   - Prevents duplicate saved items
   - Formats save dates for consistent display

5. **NotificationSettingsService.java**
   - Manages user notification preferences
   - Creates default settings for new users
   - Updates notification flags based on user selections
   - Retrieves current settings by user ID or email

### Utility Classes

1. **JwtFilter.java**
   - Implements JWT authentication filter
   - Extracts and validates tokens from request headers
   - Sets up security context for authenticated requests
   - Integrates with Spring Security filter chain

2. **JwtUtil.java**
   - Provides JWT token generation and validation
   - Manages token signing and verification
   - Extracts user information from tokens
   - Sets token expiration policies

### Configuration Files

1. **application.properties**
   - Contains database connection settings
   - Configures server port and context path
   - Sets up logging levels and patterns
   - Defines JWT secret key and expiration time
   - Configures file upload limits and locations
   - Contains environment-specific settings

2. **keystore.p12**
   - Stores SSL/TLS certificates for secure communication
   - Used for HTTPS configuration in production

### Build and Deployment Files

1. **pom.xml**
   - Maven project configuration
   - Defines project dependencies
   - Configures build plugins and processes
   - Manages packaging and deployment settings

2. **Procfile**
   - Heroku deployment configuration
   - Specifies the command to start the application
   - Defines process types for the application

3. **system.properties**
   - Specifies Java runtime version for deployment
   - Ensures compatibility with the deployment environment