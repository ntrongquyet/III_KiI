<?php
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
error_reporting(E_ALL);

$hostname ="sql108.epizy.com";
$dbname= "epiz_26807511_local_db";
$userdb = "epiz_26807511";
$pwsdb ="ntrongquyet37";

$db = new PDO("mysql:host=$hostname;dbname=$dbname;charset=utf8", $userdb, $pwsdb);
require_once 'functions.php';
