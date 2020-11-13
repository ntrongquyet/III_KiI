<!doctype html>
<html lang="en">
  <head>
    <title><?php echo $title; ?></title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>
  <body>
      <nav class="navbar navbar-expand-sm navbar-light bg-light">
          <a class="navbar-brand" href="./index.php">Trang chủ</a>
          <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target="#collapsibleNavId" aria-controls="collapsibleNavId"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
            </button>
          <div class="collapse navbar-collapse" id="collapsibleNavId">
              <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                
                  <li class="nav-item <?php echo $active=="sum"?"active":"";?>">
                      <a class="nav-link" href="./sum.php">Tính tổng</a>
                  </li>
                  <?php if (isset($_SESSION['username'])):?>
                    <li class="nav-item">
                      <a class="nav-link" href="./logout.php">Đăng xuất</a>
                  </li>
                  <?php else:?>
                  <li class="nav-item <?php echo $active=="login"?"active":"";?>">
                      <a class="nav-link" href="./login.php">Đăng nhập</a>
                  </li>
                  <li class="nav-item <?php echo $active=="register"?"active":"";?>">
                      <a class="nav-link" href="./register.php">Đăng kí</a>
                  </li>
                  <?php endif ?>
              </ul>
          </div>
      </nav>