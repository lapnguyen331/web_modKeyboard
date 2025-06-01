import React from "react";
import "./footer.css";
import { Link, Links } from "react-router-dom";
import logo from "../../assets/logo.png";

const Footer = () => {
  return (
    <footer className="modern-footer pt-5">
      <div className=" container footer-content"> {/* container*/}
        <div className="row g-4 ">
          {/* <!-- Company Info --> */}
          <div className="col-lg-3 col-lg-2">
            <a href="#" className="footer-logo d-block mb-4">
              <img src={logo} alt="Logo" />
              <span className="text-primary">.</span>
            </a>
            <p className="text-muted mb-5">
              Thành lập năm 2025, Modkey là 1 dự án Website mua bán và thiết kế
              bàn phím cho các đối tượng khách hàng. Chọn Custom, lụm phong
              cách.
            </p>
            <p className="text-muted mb-4">Modkey - Keyboard Custom For Everyone</p>
            <ul className="contact-info mb-4">
              <li>
                <i className="fas fa-map-marker-alt"></i>
                <span>
                  Linh Trung, Thủ đức
                  <br />
                </span>
              </li>
              <li>
                <i className="fas fa-phone"></i>
                <span>(+84)333333333</span>
              </li>
              <li>
                <i className="fas fa-envelope"></i>
                <span>contact@yourbrand.com</span>
              </li>
            </ul>
          </div>

          {/* <!-- Quick Links --> */}
          <div className="col-lg-2 col-md-2">
            <h3 className="footer-title">Các dịch vụ</h3>
            <ul className="quick-links">
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
          <div className="col-lg-2 col-md-2">
            <h3 className="footer-title">Danh mục</h3>
            <ul className="quick-links">
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
          <div className="col-lg-2 col-md-2">
            <h3 className="footer-title">Hỗ trợ khách hàng</h3>
            <ul className="quick-links">
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
          <div className="col-lg-3 col-md-7">
            <h3 className="footer-title">Theo dõi chúng tôi</h3>
            <p className="text-muted mb-4">
                Đăng kí email để tham gia vào CLB, Fanpage của chúng tôi ngay!
            </p>
            <form className="mb-4">
              <div className="">
                <input
                  type="email"
                  className="form-control newsletter-input"
                  placeholder="Your email address"
                />
              </div>
              <button type="submit" className="btn btn-subscribe text-white subbtn ">
                Theo dõi
              </button>
            </form>
            <div className="social-links">
                <Link className="foot-social" to="">
                <i className="fa-brands fa-square-facebook"></i>
                </Link>
                <Link className="foot-social" to="">
                <i className="fa-brands fa-square-twitter"></i>
            </Link>
                <Link className="foot-social" to="">
                <i className="fa-brands fa-square-instagram"></i>
              </Link>
                <Link className="foot-social" to="">
                <i className="fa-brands fa-youtube"></i>
              </Link>
                <Link className="foot-social" to="">
               <i className="fa-brands fa-square-behance"></i>
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* <!-- Footer Bottom --> */}
      <div className="footer-bottom">
        <div className="container">
          <div className="row py-4">
            <div className="col-md-6 text-center text-md-start">
              <p>&copy; 2024 ModKey. mod theo cách của bạn</p>
            </div>
            <div className="col-md-6 text-center text-md-end bootom-text">
              <span >
                Modkey.vn-@Copyright2025
                
              </span>
              <a href="#" className="foot-social">
                  <i className="fa-brands fa-cc-paypal"></i>
                </a>
                <a href="#" className="foot-social">
                  <i className="fa-brands fa-cc-visa"></i>
                </a>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
};
export default Footer;
