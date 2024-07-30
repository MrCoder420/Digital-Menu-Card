<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
include 'db.php'; // Include the database connection file

// Get POST data
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['username']) && isset($data['password']) && isset($data['email']) && isset($data['mobile_no'])) {
    $username = $data['username'];
    $password = $data['password'];
    $email = $data['email'];
    $mobile_no = $data['mobile_no'];

    // Validate inputs
    if (empty($username) || empty($password) || empty($email) || empty($mobile_no)) {
        echo json_encode(["status" => "error", "message" => "All fields are required"]);
        exit();
    }

    // Check if mobile number is exactly 10 digits
    if (!preg_match('/^\d{10}$/', $mobile_no)) {
        echo json_encode(["status" => "error", "message" => "Mobile number must be exactly 10 digits"]);
        exit();
    }

    // Check if email already exists
    $stmt = $conn->prepare("SELECT user_id FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();
    
    if ($stmt->num_rows > 0) {
        echo json_encode(["status" => "error", "message" => "Email already in use"]);
        $stmt->close();
        exit();
    }
    
    // Check if username already exists
    $stmt = $conn->prepare("SELECT user_id FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();
    
    if ($stmt->num_rows > 0) {
        echo json_encode(["status" => "error", "message" => "Username already in use"]);
        $stmt->close();
        exit();
    }

    // Check if mobile number already exists
    $stmt = $conn->prepare("SELECT user_id FROM users WHERE mobile_no = ?");
    $stmt->bind_param("s", $mobile_no);
    $stmt->execute();
    $stmt->store_result();
    
    if ($stmt->num_rows > 0) {
        echo json_encode(["status" => "error", "message" => "Mobile number already in use"]);
        $stmt->close();
        exit();
    }

    // Hash password
    $hashed_password = password_hash($password, PASSWORD_BCRYPT);

    // Insert user into database
    $stmt = $conn->prepare("INSERT INTO users (username, password, email, mobile_no) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $username, $hashed_password, $email, $mobile_no);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "User registered successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error registering user"]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid input"]);
}

$conn->close();
?>
