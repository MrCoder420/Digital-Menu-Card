<?php
header('Content-Type: application/json');

// Enable CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'db.php'; // Include your database connection file

$query = "SELECT id, ps FROM psize";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $psizes = [];
    while ($row = $result->fetch_assoc()) {
        $psizes[] = $row;
    }
    echo json_encode(["status" => "success", "data" => $psizes]);
} else {
    echo json_encode(["status" => "error", "message" => "No plate sizes found"]);
}

$conn->close();
?>
