<?php
include 'session.php';
include 'dbconnect.php';
$promotions = "SELECT promotions.Category, promotions.Discount, products.Image_url, products.SalePrice 
      FROM promotions JOIN (Select Category, MIN(SalePrice) AS SalePrice FROM products GROUP BY Category) cheapest
      ON promotions.Category = cheapest.Category JOIN products ON products.Category = promotions.Category AND products.SalePrice = cheapest.SalePrice";
$promotionsresult = $conn->query($promotions);
$promotionData = [];
while ($row = $promotionsresult->fetch_assoc()) {
  $promotionData[] = $row;
}
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gizmo Garage | My Account</title>
    <link rel="stylesheet" href="css/main.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <header>
    <div class="running-promo-banner">
      <div class="banner-inner">
        <div class="banner-text">Welcome to Gizmo Garage!</div>
        <?php
          foreach ($promotionData as $row) {
              echo "<div class='banner-text'>Get $row[Discount]% off on $row[Category] now!</div>";
            }
          ?>
      </div>
    </div>
      <div class="top-bar">
        <div class="logo">
          <a href="index.php"
            ><img src="images/gizmogaragelogo.png" alt="Gizmo Garage"
          /></a>
        </div>
        <form action="search_results.php" method="GET" class="search-bar">
        <select name="category">
          <option value="all">BY CATEGORY</option>
          <option value="laptops">LAPTOPS</option>
          <option value="desktops">DESKTOPS</option>
          <option value="phones">PHONES</option>
          <option value="tablets">TABLETS</option>
          <option value="accessories">ACCESSORIES</option>
        </select>
        <input type="text" name="query" placeholder="Search for a Product..." />
        <button>
          <img src="images/search_icon.png" alt="Search" height="40px" width="40px" />
        </button>
        </form>
        <div class="account-cart">
          <?php if (isset($_SESSION['valid_user'])) {
            echo "<a href='profile.php' class='account-link'><span class='material-symbols-outlined'> person </span>
            MY ACCOUNT</a>";
          } else {
            echo "<a href='login.html' class='account-link'><span class='material-symbols-outlined'> person </span>
            MY ACCOUNT</a>";
          } ?>
          <a href="cart.php" class="cart-link">
            <span class="material-symbols-outlined"> shopping_cart </span>
            CART
          </a>
        </div>
      </div>
      <nav class="nav-bar">
      <a href="categories.php?category=Laptops">LAPTOPS</a>
      <a href="categories.php?category=desktops">DESKTOPS</a>
      <a href="categories.php?category=phones">PHONES</a>
      <a href="categories.php?category=tablets">TABLETS</a>
      <a href="categories.php?category=accessories">ACCESSORIES</a>
      <a href="categories.php?sale" class="sale-link">SALE</a>
    </nav>
    </header>
    <div class="profile-container">
        <div class="profile-wrapper">
          <h1>MY ACCOUNT</h1>
          <div>
            <?php
            include 'dbconnect.php';
            if (isset($_SESSION['admin'])){
              echo "<h2>Welcome, Admin <u>".$_SESSION['valid_user']."</u>!</h2>";
              echo "<h2>ADMIN DASHBOARD</h2>";
              echo "<div class='admin-section'><h3>SET PROMOTION</h3>";
              echo "<form method='POST' action='set_promotion.php'><table><tbody>";
              echo "<tr><td><label for='category'>Select a Category:</label></td>";
              echo "<td><select name='category'>";
              echo "<option value='Laptops'>Laptops</option>";
              echo "<option value='Desktops'>Desktops</option>";
              echo "<option value='Phones'>Phones</option>";
              echo "<option value='Tablets'>Tablets</option>";
              echo "<option value='Accessories'>Accessories</option>";
              echo "</select></td></tr>";
              echo "<tr><td><label for='discount'>Enter Discount Percentage(1-100%):</label></td>";
              echo "<td><input type='number' name='discount' min='1' max='100' required></td></tr></tbody></table>";
              echo "<button type='submit'>Set Promotion</button>";
              echo "</form></div>";
              echo "<div class='admin-section'><h3>VIEW EXISTING PROMOTIONS</h3>";
              $promotions = "SELECT * FROM promotions";
              $result = $conn->query($promotions);
              if ($result->num_rows == 0){
                echo "<h4>No promotions have been set yet.</h4></div>";
              } else {
                echo "<table><tbody><tr><th>Category</th><th>Discount</th><th>Delete Promotion?</th></tr>";
                while ($row = $result->fetch_assoc()){
                  echo "<tr>";
                  echo "<td>".$row['Category']."</td>";
                  echo "<td>".$row['Discount']."%</td>";
                  echo "<td><a href='delete_promotion.php?delete=".$row['Category']."'>Delete</a></td>";
                  echo "</tr>";
                }
                echo "</tbody></table></div>";
              }
            } else {
            echo "<h2>Welcome, ".$_SESSION['valid_user']."!</h2>";
            echo "<h2>MY PROFILE</h2>";
            $savedinfo = "SELECT CustomerName, Phone, Address, CardNum, OrderID FROM orders WHERE Email = '".$_SESSION['valid_user']."'";
            $profileresult = $conn->query($savedinfo);
            if ($profileresult -> num_rows == 0){
              echo "<h3>You have not saved any profile information yet.</h3>";
            } else {
              $row = $profileresult->fetch_assoc();
              echo "<table id='profiletable'><tbody><tr><th>Name</th><td>".$row['CustomerName']."</td></tr>";
              echo "<tr><th>Phone Number</th><td>".$row['Phone']."</td></tr>";
              echo "<tr><th>Shipping Address</th><td>".$row['Address']."</td></tr>";
              echo "<tr><th>Card Payment Details</th><td>**** **** **** ".$row['CardNum']."</td></tr></tbody></table>";
              echo "</tbody></table>";
              echo "<p>*Only the latest set of records are retrieved (Reference: Order ID #". $row['OrderID'] .")</p>";
            }
            echo "<h2>MY ORDERS</h2>";
            $sql = "SELECT orders.OrderID, DATE(orders.CreatedAt) AS CreatedAt, orders.Status, orders.Total, GROUP_CONCAT(CONCAT(products.ProductName, ' x', orderitems.Quantity) SEPARATOR '<br>') AS OrderItems 
            FROM orders JOIN orderitems ON orders.OrderID = orderitems.OrderID 
            JOIN products ON orderitems.ProductID = products.ProductID 
            WHERE Email = '".$_SESSION['valid_user']."' 
            GROUP BY orders.OrderID
            ORDER BY orders.CreatedAt DESC";
            $result = $conn->query($sql);
            if ($result->num_rows == 0){
              echo "<h3>You have not made any orders yet.</h3>";
            } else {
              echo "<table><tbody><tr><th>Order ID</th><th>Order Items</th><th>Order Status</th><th>Order Total</th><th>Order Date</th></tr>";
              while ($row = $result->fetch_assoc()){
                echo "<tr>";
                echo "<td>".$row['OrderID']."</td>";
                echo "<td>".$row['OrderItems']."</td>";
                echo "<td>".$row['Status']."</td>";
                echo "<td>$".$row['Total']."</td>";
                echo "<td>".$row['CreatedAt']."</td>";
                echo "</tr>";
              }
              echo "</tbody></table>";
            }
          }
            ?>
          </div>
        </div>
        <div class="sidebar">
            <div class="action-box">
            <h3>ACTION MENU</h3>
            <img
              src="images/gizmogaragelogo.png"
              id="form-logo"
              alt="Gizmo Garage Logo"
            />
            <p>Sick of us already? Oh no..... I guess we'll have to let you go.</p>
            <a href="logout.php">
            <button id="homepage-button" type="button">Log Out</button>
            </a>
            </div>
        </div>
    </div>
    <footer>
    <div class="footer-container">
      <div class="footer-column">
        <h4><u>Contact Us</u></h4>
        <p>+65 1234 5678</p>
        <p>Mon - Fri 9am-6pm<br>(excl. public holidays)</p>
        <p>gizmogarage@gmail.com</p>
      </div>
      <div class="footer-column">
        <h4><u>Our Products</u></h4>
        <ul>
          <li><a href="categories.php?category=Laptops">Laptops</a></li>
          <li><a href="categories.php?category=desktops">Desktops</a></li>
          <li><a href="categories.php?category=phones">Phones</a></li>
          <li><a href="categories.php?category=tablets">Tablets</a></li>
          <li><a href="categories.php?category=accessories">Accessories</a></li>
          <li><a href="categories.php?sale" class="sale-link">Sale</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h4><u>Customer Service</u></h4>
        <ul>
          <li><a href="#">About Us</a></li>
          <li><a href="#">Terms of Service</a></li>
          <li><a href="#">FAQs</a></li>
          <li><a href="#">Contact Us</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h4><u>My Gizmo Garage</u> </h4>
        <ul>
          <?php
          if (isset($_SESSION['valid_user'])) {
            echo "<li><a href='profile.php'>My Account</a></li>";
            echo "<li><a href='profile.php'>Track Your Order</a></li>";
          } else {
            echo "<li><a href='login.html'>My Account</a></li>";
            echo "<li><a href='login.html'>Track Your Order</a></li>";
          }
          ?>
          <li><a href="cart.php">My Cart</a></li>
        </ul>
      </div>
      <div class="newsletter-column">
        <h4>Join Our Newsletter!</h4>
        <form action="newsletter.php" method="POST" class="newsletter-form">
          <input type="email" name="email" placeholder="Enter Email Address">
          <button type="submit">&#10148;</button>
        </form>
        <p>Stay up-to-date with the latest news, products and exclusive deals.</p>
        <div class="payment-methods">
          <img src="images/visa_logo.png" alt="Visa">
          <img src="images/mastercard_logo.png" alt="MasterCard">
          <img src="images/paynow_logo.png" alt="PayNow">
          <img src="images/Grab_pay_logo.png" alt="GrabPay">
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© 2024 A Website by Ariel & Sai</p>
    </div>
  </footer>
    </body>
    </html>