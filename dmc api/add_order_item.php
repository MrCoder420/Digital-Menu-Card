<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php'; // Include your database connection file

$data = json_decode(file_get_contents("php://input"));

if (isset($data->order_id) && isset($data->item_id) && isset($data->quantity) && isset($data->price)) {
    $order_id = $data->order_id;
    $item_id = $data->item_id;
    $quantity = $data->quantity;
    $price = $data->price;

    // Validate input
    if (!is_numeric($order_id) || !is_numeric($item_id) || !is_numeric($quantity) || !is_numeric($price)) {
        echo json_encode(["status" => "error", "message" => "Invalid input"]);
        exit();
    }

    // Insert the order item
    $query = $conn->prepare("INSERT INTO order_items (order_id, item_id, quantity, price) VALUES (?, ?, ?, ?)");
    $query->bind_param("iiid", $order_id, $item_id, $quantity, $price);

    if ($query->execute()) {
        echo json_encode(["status" => "success"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to add order item"]);
    }

    $query->close();
} else {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
}

$conn->close();
?>
