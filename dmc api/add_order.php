<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php'; // Include your database connection file

$data = json_decode(file_get_contents("php://input"));

if (isset($data->email) && isset($data->total_amount)) {
    $email = $data->email;
    $total_amount = $data->total_amount;

    // Fetch the user ID based on the email
    $userQuery = $conn->prepare("SELECT user_id FROM users WHERE email = ?");
    $userQuery->bind_param("s", $email);
    $userQuery->execute();
    $userResult = $userQuery->get_result();
    $user = $userResult->fetch_assoc();

    if ($user) {
        $user_id = $user['user_id'];

        // Insert a new order
        $query = $conn->prepare("INSERT INTO orders (user_id, total_amount) VALUES (?, ?)");
        $query->bind_param("id", $user_id, $total_amount);

        if ($query->execute()) {
            echo json_encode(["status" => "success", "order_id" => $conn->insert_id]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to create order"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "User not found"]);
    }

    $userQuery->close();
    $query->close();
} else {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
}

$conn->close();
?>
