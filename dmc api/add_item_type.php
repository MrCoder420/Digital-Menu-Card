<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php'; // Include your database connection file

// Get the JSON data from POST
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['tname'])) {
    $tname = $data['tname'];

    // Prepare and execute the insert query
    $stmt = $conn->prepare("INSERT INTO item_type (tname) VALUES (?)");
    $stmt->bind_param("s", $tname);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Item type added successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to add item type"]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
}

$conn->close();
?>
