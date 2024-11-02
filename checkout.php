<?php
include 'dbconnect.php';
include 'session.php';
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout</title>
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
      <div class="running-promo-banner">Running Promotion Banner</div>
      <div class="top-bar">
        <div class="logo">
          <a href="index.php"
            ><img src="images/gizmogaragelogo.png" alt="Gizmo Garage"
          /></a>
        </div>
        <form action="search_results.php" method="GET" class="search-bar">
        <select>
          <option name="category" value="all">BY CATEGORY</option>
          <option name="category" value="laptops">LAPTOPS</option>
          <option name="category" value="desktops">DESKTOPS</option>
          <option name="category" value="phones">PHONES</option>
          <option name="category" value="tablets">TABLETS</option>
          <option name="category" value="accessories">ACCESSORIES</option>
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
        <a href="categories.php?category=Laptops"
          >LAPTOPS<span class="material-symbols-outlined">
            keyboard_arrow_down
          </span></a
        >
        <a href="categories.php?category=desktops"
          >DESKTOPS<span class="material-symbols-outlined">
            keyboard_arrow_down
          </span></a
        >
        <a href="categories.php?category=phones"
          >PHONES<span class="material-symbols-outlined">
            keyboard_arrow_down
          </span></a
        >
        <a href="categories.php?category=tablets"
          >TABLETS<span class="material-symbols-outlined">
            keyboard_arrow_down
          </span></a
        >
        <a href="categories.php?category=accessories"
          >ACCESSORIES<span class="material-symbols-outlined">
            keyboard_arrow_down
          </span></a
        >
        <a href="categories.php?sale" class="sale-link"
          >SALE<span class="material-symbols-outlined">
            keyboard_arrow_down
          </span></a
        >
      </nav>
    </header>
    <div class="checkout-container">
      <div class="checkout-section">
        <div id="checkout-wrapper">
          <img
            src="images/gizmogaragelogo.png"
            id="form-logo"
            alt="Gizmo Garage Logo"
          />
          <div class="form-box">
            <h2>Checkout</h2>
            <form action="order_confirmation.php" method="POST" onsubmit="return validateForm()">
              <h4>Shipping Address</h4>
              <div class="input-grid">
                <div class="input-field">
                  <input
                  type="text"
                  id="firstname"
                  name="firstname"
                  onchange="validateFirstName.call(this)"
                  placeholder="First Name"
                  required
                />
                <span id="errorFirstName"></span>
                </div>
                <div class="input-field">
                  <input
                  type="text"
                  id="lastname"
                  name="lastname"
                  onchange="validateLastName.call(this)"
                  placeholder="Last Name"
                  required
                />
                <span id="errorLastName"></span>
                </div>
                <div class="input-field-span2">
                  <input
                  type="text"
                  id="address"
                  name="address"
                  onchange="validateAddress.call(this)"
                  placeholder="Street Address"
                  required
                />
                <span id="errorAddress"></span>
                </div>
                <div class="input-field">
                  <input
                  type="text"
                  id="postalcode"
                  name="postalcode"
                  onchange="validatePostalCode.call(this)"
                  placeholder="Postal Code"
                  required
                />
                <span id="errorPostalCode"></span>
                </div>
                <div class="input-field">
                <input
                  type="text"
                  id="unitcode"
                  name="unitcode"
                  onchange="validateUnitCode.call(this)"
                  placeholder="Apt / Suite / Unit"
                />
                <span id="errorUnitCode"></span>
              </div>
              </div>
              <h4>Billing Details</h4>
              <div class="input-grid">
                <div class="input-field-span2">
                  <input
                  type="text"
                  id="cardnum"
                  name="cardnum"
                  onchange="validateCardNum.call(this)"
                  oninput="formatCardNumber(this)"
                  placeholder="Card Number"
                  required
                />
                <span id="errorCardNum"></span>
                </div>
                <div class="input-field">
                  <input
                  type="text"
                  id="cardexpiry"
                  name="cardexpiry"
                  onchange="validateCardExpiry.call(this)"
                  placeholder="Card Expiry"
                  required
                />
                <span id="errorCardExpiry"></span>
                </div>
                <div class="input-field">
                  <input
                  type="text"
                  id="cardcvv"
                  name="cardcvv"
                  onchange="validateCardCVV.call(this)"
                  placeholder="CVV"
                  required
                />
                <span id="errorCardCVV"></span>
                </div>
                <div class="input-field">
                  <input
                  type="email"
                  id="email"
                  name="email"
                  onchange="validateEmail.call(this)"
                  placeholder="Email Address"
                  required
                />
                <span id="errorEmail"></span>
                </div>
                <div class="input-field">
                  <input
                  type="tel"
                  id="phone"
                  name="phone"
                  onchange="validatePhone.call(this)"
                  placeholder="Phone Number"
                  required
                />
                <span id="errorPhone"></span>
                </div>
              </div>
              <button type="submit" id="homepage-button">Complete Order</button>
            </form>
          </div>
          <div class="form-footer">
            <a href="/privacy">Privacy Notice</a>
          </div>
        </div>
      </div>
      <div class="order-summary-section">
        <div class="order-summary">
          <h3>ORDER SUMMARY</h3>
          <div id="summary-grid">
            <?php
            $subtotal = 0.00;
            $shipping = 10.00;
            for ($i = 0; $i < count($_SESSION['cart']['items']); $i++){
              $item = $_SESSION['cart']['items'][$i];
              $qty = $_SESSION['cart']['qty'][$item];
              $query = "SELECT * FROM Products WHERE ProductID = $item";
              $result = $conn->query($query);
              $row = $result->fetch_assoc();
              $price = $row['SalePrice'] ?? $row['Price'];
              $item_subtotal = $price * $qty;
              $subtotal += $item_subtotal;
              echo "<div class='order-item'>";
              echo '<img src="' . $row['Image_url'] . '" alt="' . $row['ProductName'] . '">';
              echo "<p class='product-name'>".$row['ProductName']."</p>";
              if ($row['SalePrice'] != NULL){
                  echo '<p class="price"><span>Qty:'.$qty .'&nbsp;&nbsp;&nbsp;</span>$' . $row['SalePrice'] . '</p></div>';
                }
                else {
                  echo '<p class="price"><span>Qty:'.$qty .'&nbsp;&nbsp;&nbsp;</span>$' . $row['Price'] . '</p></div>';
                }
          } 
          echo "</div><hr />";
          echo "<div id='price-grid'><h4>Subtotal</h4><p class='subtotal'>$
          ". number_format($subtotal, 2) ."</p><h4>Shipping</h4><p>$". number_format($shipping, 2) .
          "</p><h3>TOTAL</h3><h3 class='total'>$". number_format(($subtotal + $shipping),2) ."</h3></div>";
          ?>
        </div>
      </div>
    </div>
    <footer>
      <div class="footer-container">
        <div class="footer-column">
          <h4><u>Contact Us</u></h4>
          <p>+65 1234 5678</p>
          <p>Mon - Fri 9am-6pm<br />(excl. public holidays)</p>
          <p>gizmogarage@gmail.com</p>
        </div>
        <div class="footer-column">
          <h4><u>Our Products</u></h4>
          <ul>
            <li><a href="#">Category A</a></li>
            <li><a href="#">Category B</a></li>
            <li><a href="#">Category C</a></li>
            <li><a href="#">Category D</a></li>
            <li><a href="#">Category E</a></li>
            <li><a href="#" class="sale">Sale</a></li>
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
          <h4><u>My Gizmo Garage</u></h4>
          <ul>
            <li><a href="#">My Account</a></li>
            <li><a href="#">Track Your Order</a></li>
            <li><a href="#">Sustainability</a></li>
            <li><a href="#">The Gizmo Newsletter</a></li>
          </ul>
        </div>
        <div class="newsletter-column">
          <h4><u>Join Our Newsletter</u> !</h4>
          <form class="newsletter-form">
            <input type="email" placeholder="Enter Email Address" />
            <button type="submit">&#10148;</button>
          </form>
          <p>
            Stay up-to-date with the latest news, products and exclusive deals.
          </p>
          <div class="payment-methods">
            <img src="images/visa_logo.png" alt="Visa" />
            <img src="images/mastercard_logo.png" alt="MasterCard" />
            <img src="images/paynow_logo.png" alt="PayNow" />
            <img src="images/Grab_pay_logo.png" alt="GrabPay" />
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>© 2024 A Website by Ariel & Sai</p>
      </div>
    </footer>
    <script src="js/checkout_validation.js"></script>
  </body>
</html>
