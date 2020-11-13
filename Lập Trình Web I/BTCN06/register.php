<?php 
  require_once 'init.php';
  require_once 'functions.php';
  session_start();
  $active = strpos($_SERVER['REQUEST_URI'], "register.php")!=false?'register':'false';
  $title = "Đăng kí";
  if(isset($_POST['uname'])&& isset($_POST['pswd'])){
    $username = $_POST['uname'];
    $password = $_POST['pswd'];
    $user = findUserByUsername($username);
    if($user){
      $error = "Tài khoản đã tồn tại";
    }else{
      $hashPassword = password_hash($password,PASSWORD_DEFAULT);
      addAccountToDB($username,$hashPassword);
      $success = "Đăng kí thành công tài khoản <strong>$username</strong>";
    }
  }

?>
<?php include 'header.php'; ?>
<?php if(isset($_SESSION['username'])): ?>
  <div class="alert alert-dark text-center" role="alert">
  Bạn đã đăng nhập nên không thể thực hiện chức năng này
  </div>
<?php else: ?>
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

<form method="post" action="./register.php" class="was-validated">
  <div class="form-group">
    <label for="uname">Username:</label>
    <input type="text" class="form-control" id="uname" placeholder="Username" name="uname" required>
    <div class="invalid-feedback">Please fill out this field.</div>
  </div>
  <div class="form-group">
    <label for="pwd">Password:</label>
    <input type="password" class="form-control" id="pwd" placeholder="Password" name="pswd" required>
    <div class="invalid-feedback">Please fill out this field.</div>
  </div>
  <button type="submit" class="btn btn-primary">Register</button>
</form>
<?php endif ?>
<?php include 'footer.php'; ?>
