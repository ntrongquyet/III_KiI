<?php 
  session_start();
  $active = strpos($_SERVER['REQUEST_URI'], "sum.php")!=false?"sum":"";
  $title = "Tính tổng";
  require_once 'init.php';
  require_once 'functions.php';
  ?>
<?php include 'header.php'; ?>
<?php if (isset($_SESSION['username'])):?>
<p>Đã đăng nhập</p>
<?php else: ?>
<p>Đăng nhập để thực hiện chức năng này</p>
<?php endif ?>
<?php include 'footer.php'; ?>