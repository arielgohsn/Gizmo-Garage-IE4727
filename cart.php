<?php
include 'dbconnect.php';
include 'session.php';
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
    <title>Gizmo Garage | Shopping Cart</title>
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
    <?php
    if (count($_SESSION['cart']['items']) == 0){
        echo "<div class='empty-cart' id='empty-cart'>";
        echo "<p>Your shopping cart is currently empty.</p>";
        echo "<button id='homepage-button' onclick=\"location.href='index.php'\">Return to Homepage</button></div>";
    } else {
      $subtotal = 0.00;
      $shipping = 0.00;
      echo "<div class='cart-container'><div class='checkout-section'><div class='cart-wrapper'><div id='cart-grid'>";
        for ($i = 0; $i < count($_SESSION['cart']['items']); $i++){
            $item = $_SESSION['cart']['items'][$i];
            $qty = $_SESSION['cart']['qty'][$item];
            $query = "SELECT * FROM Products WHERE ProductID = $item";
            $result = $conn->query($query);
            $row = $result->fetch_assoc();
            $images = explode(',', $row['Image_url']);
            $price = $row['SalePrice'] ?? $row['Price'];
            $item_subtotal = $price * $qty;
            $subtotal += $item_subtotal;
            echo "<div class='order-item'>";
            echo '<img src="' . trim($images[0]) . '" alt="' . $row['ProductName'] . '">';
            echo "<div class='order-item-text'>";
            echo "<p class='product-name'>".$row['ProductName']."</p>";
            if ($row['SalePrice'] != NULL){
                echo '<p class="price"><span>Qty:'.$qty .'&nbsp;&nbsp;&nbsp;</span>$' . $row['SalePrice'] . '</p></div>';
              }
              else {
                echo '<p class="price"><span>Qty:'.$qty .'&nbsp;&nbsp;&nbsp;</span>$' . $row['Price'] . '</p></div>';
              }
            echo "<a href='removeitem.php?remove=".$item."'>";
            echo "<span class='material-symbols-outlined'> delete </span>";
            echo "</a></div>";
        }
        echo "</div></div></div>";
        echo "<div class='order-summary-section'><div class='order-summary'><div id='price-grid'>";
        echo "<h4>Subtotal</h4>";
        echo '<p class="subtotal">$'. number_format($subtotal, 2) .'</p>';
        echo "<h4>Shipping</h4>";
        echo '<p>$'. number_format($shipping, 2) .'</p>';
        echo "<hr />";
        echo "<h3>TOTAL</h3>";
        echo '<h3 class="total">$'. number_format(($subtotal + $shipping),2) .'</h3>';
        echo "</div>";
        echo "<button id='homepage-button' onclick=\"location.href='" . (isset($_SESSION['valid_user']) ? 'checkout.php' : 'login.html') . "'\">Checkout</button>";
        echo "</div></div></div>";
    }
     ?>
            <!-- <div class="order-item">
              <img src="..." />
              <div class="order-item-text">
                <p class="product-name">Product Name</p>
                <p class="price">$XXX.XX</p>
              </div>
              <a href="#">
                <span class="material-symbols-outlined"> delete </span>
              </a>
            </div> -->
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
