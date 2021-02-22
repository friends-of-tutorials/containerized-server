<?php

// Add autoloader
require_once 'vendor/autoload.php';

// Read .env file
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Read .env mysql confing
$host = $_ENV['MYSQL_8_0_19_SERVER_HOSTNAME'];
$user = $_ENV['MYSQL_SERVER_ROOT_USER'];
$pass = $_ENV['MYSQL_SERVER_ROOT_PASSWORD'];
$daba = $_ENV['MYSQL_SERVER_DB'];

// Try to connect to daba
try {
    $conn = new PDO("mysql:host=$host;dbname=$daba", $user, $pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "Connected successfully";
} catch(PDOException $e) {
    echo "Connection failed 2: " . $e->getMessage();
}

