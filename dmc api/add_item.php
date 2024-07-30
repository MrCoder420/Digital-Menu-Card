<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Include the database connection file
include 'db.php'; // Ensure this file contains the correct database connection logic

// Handle POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get JSON data from the request
    $data = json_decode(file_get_contents('php://input'), true);

    // Validate the data
    if (!isset($data['item_name']) || !isset($data['psize_id']) || !isset($data['item_type_id']) || !isset($data['price'])) {
        echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
        exit;
    }

    // Extract data
    $itemName = $data['item_name'];
    $psizeId = $data['psize_id'];
    $itemTypeId = $data['item_type_id'];
    $price = $data['price'];

    // Insert new item
    $query = "INSERT INTO items (item_name, price, item_type_id, psize_id) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sdii", $itemName, $price, $itemTypeId, $psizeId);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Item added successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to add item']);
    }

    $stmt->close();
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

// Close the database connection
$conn->close();
?>
