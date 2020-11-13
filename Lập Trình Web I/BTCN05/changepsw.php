<?php 
  require_once 'init.php';
  require_once 'functions.php';
  
  session_start();
  $title="Đổi mật khẩu";

  $active = strpos($_SERVER['REQUEST_URI'], "login.php")!=false?'login':false;
  if(isset($_POST['pwd']) && isset($_POST['pwdNew'])&& isset($_POST['pwdRe'])){
    $pwd = $_POST['pwd'];
    $pwdNew = $_POST['pwdNew'];
    $pwdRe = $_POST['pwdRe'];
    $user = findUserByUsername($_SESSION["username"]);

    if(!(password_verify($pwd,$user["pwd"]))){
      $error = 'Mật khẩu cũ không chính xác';
    }
    else if($pwdNew!=$pwdRe){
      $error = 'Mật khẩu mới không trùng khớp';
    }else{
      $passwordHash = password_hash($pwdNew,PASSWORD_DEFAULT);
      updatePassword($_SESSION["username"],$passwordHash);
      $success = "Đổi mật khẩu thành công";
    }
  }
?>
<?php include 'header.php'; ?>
<?php if(isset($_SESSION['username'])): ?>
  <?php if(isset($error)):?>
    <div class="alert alert-dark text-center" role="alert">
     <?php echo $error; ?>
  </div>
  <?php endif ?>
  <?php if(isset($success)): ?>
    <div class="alert alert-success text-center" role="alert">
     <?php echo $success; ?>
  </div>
  <?php endif ?>
    <form action="./changepsw.php" method="POST">
    <div class="form-group">

    <label for="pwd">Mật khẩu hiện tại:</label>
    <input type="password" class="form-control" placeholder="Mật khẩu hiện tại" name="pwd" id="pwd">
  </div>
  <div class="form-group">
    <label for="pwdNew">Mật khẩu mới:</label>
    <input type="password" class="form-control" placeholder="Mật khẩu mới" name="pwdNew" id="pwdNew">
  </div>
  <div class="form-group">
    <label for="pwdRe">Nhập lại mật khẩu mới:</label>
    <input type="password" class="form-control" placeholder="Nhập lại mật khẩu mới" name="pwdRe" id="pwdRe">
  </div>
  
  <button type="submit" class="btn btn-primary">Submit</button>
</form>

<?php else: ?>
    <div class="alert alert-dark text-center" role="alert">
  Bạn cần đăng nhập để thực hiện chức năng này
  </div>
<?php endif ?>
<?php include 'footer.php'; ?>
