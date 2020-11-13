<?php 
  require_once 'init.php';
  require_once 'functions.php';
  
  session_start();
  $title="Đăng nhập";
  $active = strpos($_SERVER['REQUEST_URI'], "login.php")!=false?'login':false;
  if(isset($_POST['txtUsername'])&& isset($_POST['pwd'])){
    $username = $_POST['txtUsername'];
    $password = $_POST['pwd'];
    $user = findUserByUsername($username);

    if(!$user){
      $error = 'Không tìm thấy người dùng';
    }else {
      
      if(!(password_verify($password, $user["pwd"]))){
        $error = 'Mật khẩu không chính xác';
      }else{
        $_SESSION['username'] = $user["username"];
        header('Location: index.php');
        exit();
      }
    }
  }
?>
<?php include 'header.php'; ?>
<?php if (isset($error)):?>
  <div class="alert alert-danger" role="alert">
  <?php echo "$error"; ?>
  </div>
  <?php endif?>
<?php if(isset($_SESSION['username'])): ?>
<div class="alert alert-dark text-center" role="alert">
  Bạn đã đăng nhập nên không thể thực hiện chức năng này
  </div>
<?php else: ?>
<form action="./login.php" method="POST">
  <div class="form-group">
    <label for="txtUsername">Tài khoản</label>
    <input type="txtUsername" class="form-control" placeholder="UserName" name="txtUsername" id="txtUsername">
  </div>
  <div class="form-group">
    <label for="pwd">Password:</label>
    <input type="password" class="form-control" placeholder="Password" name="pwd" id="pwd">
  </div>
  <div class="form-group form-check">
    <label class="form-check-label">
      <input class="form-check-input" type="checkbox"> Remember me
    </label>
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
<?php endif ?>
<?php include 'footer.php'; ?>
