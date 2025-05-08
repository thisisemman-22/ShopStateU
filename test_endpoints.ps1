# PowerShell script to test all endpoints of the ShopStateU application

# Base URL of the application
$baseUrl = "http://localhost:8081"

# Test User Registration
Write-Output "Testing User Registration..."
$registerResponse = Invoke-RestMethod -Uri "$baseUrl/api/users/register" -Method Post -Body (@{
    fullName = "John Doe"
    email = "johndoe@g.batstate-u.edu.ph"
    password = "Password123"
    college = "Engineering"
} | ConvertTo-Json -Depth 10) -ContentType "application/json"
Write-Output "Register Response: $registerResponse"

# Test User Login
Write-Output "Testing User Login..."
$loginResponse = Invoke-RestMethod -Uri "$baseUrl/api/users/login" -Method Post -Body (@{
    email = "johndoe@g.batstate-u.edu.ph"
    password = "Password123"
} | ConvertTo-Json -Depth 10) -ContentType "application/json"
Write-Output "Login Response: $loginResponse"

# Test Product Addition
Write-Output "Adding a Product with a valid image..."
$productForm = @{
    name = "Example Product"
    description = "This is an example product."
    category = "Electronics"
    price = 100.0
    sellerName = "John Doe"
    sellerCollege = "Engineering"
    images = Get-Item -Path "./uploads/example.jpg"
}
$productResponse = Invoke-RestMethod -Uri "$baseUrl/api/products" -Method Post -Form $productForm
Write-Output "Product Response: $productResponse"

# Test Get All Products
Write-Output "Testing Get All Products..."
$productsResponse = Invoke-RestMethod -Uri "$baseUrl/api/products" -Method Get
Write-Output "Products Response: $productsResponse"

# Test Search Products
Write-Output "Testing Search Products..."
$searchResponse = Invoke-RestMethod -Uri "$baseUrl/api/products/search?query=example" -Method Get
Write-Output "Search Response: $searchResponse"

# Add a second user for messaging
Write-Output "Registering a second user..."
$registerResponse2 = Invoke-RestMethod -Uri "$baseUrl/api/users/register" -Method Post -Body (@{
    fullName = "Jane Doe"
    email = "janedoe@g.batstate-u.edu.ph"
    password = "Password123"
    college = "Engineering"
} | ConvertTo-Json -Depth 10) -ContentType "application/json"
Write-Output "Second User Register Response: $registerResponse2"

# Test Sending a Message
Write-Output "Testing Sending a Message..."
$messagePayload = @{
    senderName = "John Doe"
    recipientName = "Jane Doe"
    messageContent = "Hello, Jane!"
} | ConvertTo-Json -Depth 10 -Compress
$messageResponse = Invoke-RestMethod -Uri "$baseUrl/api/messages" -Method Post -Body $messagePayload -ContentType "application/json"
Write-Output "Message Response: $messageResponse"

# Test Inbox for Jane Doe
Write-Output "Testing Inbox for Jane Doe..."
$inboxResponse = Invoke-RestMethod -Uri "$baseUrl/api/messages/inbox/Jane Doe" -Method Get
Write-Output "Inbox Response: $inboxResponse"

# Test Sent Messages for John Doe
Write-Output "Testing Sent Messages for John Doe..."
$sentResponse = Invoke-RestMethod -Uri "$baseUrl/api/messages/sent/John Doe" -Method Get
Write-Output "Sent Response: $sentResponse"

Write-Output "All tests completed."