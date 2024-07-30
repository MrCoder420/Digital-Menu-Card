<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php'; // Include the database connection file

$query = "SELECT items.id, items.item_name, items.price, item_type.tname, psize.ps 
          FROM items 
          LEFT JOIN item_type ON items.item_type_id = item_type.tid
          LEFT JOIN psize ON items.psize_id = psize.id";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    $items = [];
    while($row = $result->fetch_assoc()) {
        $items[] = $row;
    }
    echo json_encode(["status" => "success", "data" => $items]);
} else {
    echo json_encode(["status" => "error", "message" => "No items found"]);
}

$conn->close();
?>
