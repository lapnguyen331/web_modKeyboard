import React from "react";
import "./footer.css";
import { Link, Links } from "react-router-dom";
import logo from "../../assets/logo.png";

const Footer = () => {
  return (
    <footer class="modern-footer pt-5">
      <div class="container footer-content">
        <div class="row g-4 ">
          {/* <!-- Company Info --> */}
          <div class="col-lg-3 col-md-2">
            <a href="#" class="footer-logo d-block mb-4">
              <img src={logo} alt="Logo" />
              <span class="text-primary">.</span>
            </a>
            <p class="text-muted mb-5">
              Thành lập năm 2025, Modkey là 1 dự án Website mua bán và thiết kế
              bàn phím cho các đối tượng khách hàng. Chọn Custom, lụm phong
              cách.
            </p>
            <p class="text-muted mb-4">Modkey - Keyboard Custom For Everyone</p>
            <ul class="contact-info mb-4">
              <li>
                <i class="fas fa-map-marker-alt"></i>
                <span>
                  Linh Trung, Thủ đức
                  <br />
                </span>
              </li>
              <li>
                <i class="fas fa-phone"></i>
                <span>(+84)333333333</span>
              </li>
              <li>
                <i class="fas fa-envelope"></i>
                <span>contact@yourbrand.com</span>
              </li>
            </ul>
          </div>

          {/* <!-- Quick Links --> */}
          <div class="col-lg-2 col-md-2">
            <h3 class="footer-title">Các dịch vụ</h3>
            <ul class="quick-links">
              <li>
                <Link className="foot-links" to={"/search"}>Tìm kiếm</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/policy"}>Chính sách hoàn trả</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/search"}>Chính sách bảo mật</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/search"}>Hướng dẫn người dùng</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/search"}>giao hàng</Link>
              </li>
              {/* <li>
                <a href="#">Contact Details</a>
              </li>
              <li>
                <a href="#">Privacy Policy</a>
              </li>
              <li>
                <a href="#">Terms of Service</a>
              </li> */}
            </ul>
          </div>
          <div class="col-lg-2 col-md-2">
            <h3 class="footer-title">Danh mục</h3>
            <ul class="quick-links">
              <li>
                <Link className="foot-links" to={"/search"}>Bàn phím lắp sẫn</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/policy"}>Phụ kiện</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/search"}>linh kiện bàn phím</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/search"}>Bàn phím custom</Link>
              </li>
              <li>
                <Link className="foot-links" to={"/search"}>Bàn phím văn phòng</Link>
              </li>
              {/* <li>
                <a href="#">Contact Details</a>
              </li>
              <li>
                <a href="#">Privacy Policy</a>
              </li>
              <li>
                <a href="#">Terms of Service</a>
              </li> */}
            </ul>
          </div>
          <div class="col-lg-2 col-md-2">
            <h3 class="footer-title">Hỗ trợ khách hàng</h3>
            <ul class="quick-links">
              <li>
                <Link  className="foot-links"  to={"#"}>Giới thiệu</Link>
              </li>
              <li>
                <Link className="foot-links"  to={"#"}>Thông tin liện hệ</Link>
              </li>
              <li>
                <Link  className="foot-links" to={"#"}>Hỏi đáp</Link>
              </li>
            
              <li>
                <Link className="foot-links"  to={"#"}>giao hàng</Link>
              </li>
              {/* <li>
                <a href="#">Contact Details</a>
              </li>
              <li>
                <a href="#">Privacy Policy</a>
              </li>
              <li>
                <a href="#">Terms of Service</a>
              </li> */}
            </ul>
          </div>

          {/* <!-- Newsletter --> */}
          <div class="col-lg-3 col-md-7">
            <h3 class="footer-title">Theo dõi chúng tôi</h3>
            <p class="text-muted mb-4">
                Đăng kí email để tham gia vào CLB, Fanpage của chúng tôi ngay!
            </p>
            <form class="mb-4">
              <div class="">
                <input
                  type="email"
                  class="form-control newsletter-input"
                  placeholder="Your email address"
                />
              </div>
              <button type="submit" class="btn btn-subscribe text-white subbtn ">
                Theo dõi
              </button>
            </form>
            <div class="social-links">
                <Link className="foot-social" to="">
                <i class="fa-brands fa-square-facebook"></i>
                </Link>
                <Link className="foot-social" to="">
                <i class="fa-brands fa-square-twitter"></i>
            </Link>
                <Link className="foot-social" to="">
                <i class="fa-brands fa-square-instagram"></i>
              </Link>
                <Link className="foot-social" to="">
                <i class="fa-brands fa-youtube"></i>
              </Link>
                <Link className="foot-social" to="">
               <i class="fa-brands fa-square-behance"></i>
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* <!-- Footer Bottom --> */}
      <div class="footer-bottom">
        <div class="container">
          <div class="row py-4">
            <div class="col-md-6 text-center text-md-start">
              <p>&copy; 2024 ModKey. mod theo cách của bạn</p>
            </div>
            <div class="col-md-6 text-center text-md-end bootom-text">
              <span >
                Modkey.vn-@Copyright2025
                
              </span>
              <a href="#" className="foot-social">
                  <i class="fa-brands fa-cc-paypal"></i>
                </a>
                <a href="#" className="foot-social">
                  <i class="fa-brands fa-cc-visa"></i>
                </a>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
};
export default Footer;
