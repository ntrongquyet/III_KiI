<?php
$stmt = $db->query("SELECT * FROM users");
// Lấy hết toàn bộ dữ liệu
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);


function findUserByUsername($username){
    global $db;
    $stmt = $db->prepare("SELECT * FROM users WHERE username=?");
    $stmt->execute(array($username));
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
function addAccountToDB($username,$pwd){
    global $db;
    $stmt = $db->prepare("INSERT INTO users (username,pwd) VALUES (?,?)");
    $stmt->execute(array($username,$pwd));
    


}
function getCurrentUser(){
    if(isset($_SESSION['username'])){
        $user = findUserByUsername($_SESSION['username']);
        return $user;
    }
    return null;
}
function updatePassword($username,$pwd){
    global $db;
    $stmt = $db->prepare("UPDATE users SET pwd = ? WHERE username = ?");
    $stmt->execute([$pwd,$username]);
}