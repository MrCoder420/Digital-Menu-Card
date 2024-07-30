<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php'; // Include your database connection file

$query = "SELECT tid, tname FROM item_type ORDER BY tid ASC";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    $itemTypes = [];
    while ($row = $result->fetch_assoc()) {
        $itemTypes[] = $row;
    }
    echo json_encode(["status" => "success", "data" => $itemTypes]);
} else {
    echo json_encode(["status" => "error", "message" => "No item types found"]);
}

$conn->close();
?>
