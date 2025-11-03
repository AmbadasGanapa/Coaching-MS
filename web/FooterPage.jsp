<!-- Footer HTML -->
<html>
    <head>
        <!-- FontAwesome for Social Media Icons -->

        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<!-- Footer CSS -->
<style>
  /* Footer Basic Style */
  .footer {
    background-color: #1e2a38; ;
    color: #fff;
    padding: 40px 0;
    text-align: center;
    /*animation: fadeIn 2s ease forwards;*/
  }

  .footer .container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .footer-logo h2 {
    margin: 0;
    font-size: 24px;
    color: #ff6347;
  }

  .footer-logo p {
    margin: 5px 0;
    font-size: 14px;
  }

  /* Footer Sections */
  .footer-sections {
    display: flex;
    justify-content: space-around;
    width: 100%;
    margin-top: 20px;
  }

  .footer-section {
    max-width: 200px;
    text-align: left;
  }

  .footer-section h3 {
    font-size: 18px;
    color: #ff6347;
    margin-bottom: 10px;
    position: relative;
    /*animation: slideIn 1s ease forwards;*/
  }

  .footer-section p, .footer-section ul {
    font-size: 14px;
    line-height: 1.5;
  }

  /* Footer Links */
  .footer-links {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }

  .footer-links li {
    margin-bottom: 8px;
  }

  .footer-links a {
    color: #fff;
    text-decoration: none;
    transition: color 0.3s ease;
  }

  .footer-links a:hover {
    color: #ff6347;
  }

  /* Social Media Icons */
  .social-icons a {
    font-size: 20px;
    color: #fff;
    margin-right: 15px;
    transition: color 0.3s ease;
  }

  .social-icons a:hover {
    color: #ff6347;
  }

/*   Animations 
  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  @keyframes slideIn {
    from {
      opacity: 0;
      transform: translateX(-20px);
    }
    to {
      opacity: 1;
      transform: translateX(0);
    }
  }*/
</style>
    </head>
    <body>
<footer class="footer">
  <div class="container">
    <!-- Logo and Copyright -->
    <div class="footer-logo">
      <h2>Classmate Software</h2>
      <p>&copy; 2024 Classmate Software. All rights reserved.</p>
    </div>

    <!-- Footer Links -->
    <div class="footer-sections">
      <!-- Quick Links -->
      <div class="footer-section">
        <h3>Quick Links</h3>
        <ul class="footer-links">
          <li><a href="#">Home</a></li>
          <li><a href="#">About Us</a></li>
          <li><a href="#">Contact</a></li>
          <li><a href="#">Privacy Policy</a></li>
        </ul>
      </div>

      <!-- Contact Info -->
      <div class="footer-section">
        <h3>Contact Us</h3>
        <p>Email: support@classmate.com</p>
        <p>Phone: +1 (555) 123-4567</p>
        <p>Address: 123 Classmate Street, Learning City</p>
      </div>

      <!-- Social Media -->
      <div class="footer-section">
        <h3>Follow Us</h3>
        <div class="social-icons">
          <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
          <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
          <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
          <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
        </div>
      </div>
    </div>
  </div>
</footer>
</body>

</html>