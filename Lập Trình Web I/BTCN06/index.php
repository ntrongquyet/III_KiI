<?php 
  session_start();
  require_once 'init.php';
  require_once 'functions.php';
  $currentUser = getCurrentUser();
  $title = "Trang chủ";
  $active ="";
?>
<?php include 'header.php'; ?>
<?php if (isset($_SESSION['username'])):?>
  <div class="alert alert-primary" role="alert">
  Xin chào <strong><?php echo $currentUser["username"]; ?></strong> chúc bạn ngày <?php echo date('d/m/Y') ?> tốt lành
  </div>
<?php endif ?>
<?php include 'footer.php'; ?>
