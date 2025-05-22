import React from "react";
import "./header.css";
import { Link } from "react-router-dom";
import logo from "../../assets/logo.png";

const Header = () => {
  return (
    <header className="header_area">
      <div className="top_menu">
        <div className="container">
          <div className="row">
            <div className="col-lg-7">
              <div className="float-left">
                <p>Phone: +01 256 25 235</p>
                <p>email: info@eiser.com</p>
              </div>
            </div>
            <div className="col-lg-5">
              <div className="float-right">
                <ul className="right_side">
                  <li>
                    {/* <a href="cart.html">
                            gift card
                        </a> */}
                    <Link className="nav-link" to="/cart">
                      gift cardcard
                    </Link>
                  </li>
                  <li>
                    {/* <a href="tracking.html">
                            track order
                        </a> */}
                    <Link className="nav-link" to="/tracking">
                      track orderorder
                    </Link>
                  </li>
                  <li>
                    {/* <a href="contact.html">
                            Contact Us
                        </a> */}
                    <Link className="nav-link" to="/contact">
                      Contact Us
                    </Link>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="main_menu">
        <div className="container">
          <nav className="navbar navbar-expand-lg navbar-light w-100">
            {/* <!-- Brand and toggle get grouped for better mobile display --> */}
            {/* <a className="navbar-brand logo_h" href="index.html">
                    <img src="img/logo.png" alt="" />
                </a> */}
            <Link className="nav-link" to="#">
              <img src={logo} alt="Logo" />
            </Link>
            <button
              className="navbar-toggler"
              type="button"
              data-toggle="collapse"
              data-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent"
              aria-expanded="false"
              aria-label="Toggle navigation"
            >
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            {/* <!-- Collect the nav links, forms, and other content for toggling --> */}
            <div
              className="collapse navbar-collapse offset w-100"
              id="navbarSupportedContent"
            >
              <div className="row w-100 mr-0">
                <div className="col-lg-8 pr-0">
                  <ul className="nav navbar-nav center_nav pull-right">
                    <li className="nav-item active">
                      {/* <a className="nav-link" href="index.html">Home</a> */}
                      <Link className="nav-link" to="#">
                        Home
                      </Link>
                    </li>
                    <li className="nav-item submenu dropdown">
                      {/* <a href="#" className="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                            aria-expanded="false">Shop</a> */}
                      <Link
                        className="nav-link dropdown-toggle"
                        data-toggle="dropdown"
                        role="button"
                        aria-haspopup="true"
                        aria-expanded="false"
                        to="/product"
                      >
                        Sản phẩm{" "}
                      </Link>
                      <ul className="dropdown-menu">
                        <li className="nav-item">
                          {/* <a className="nav-link" href="category.html">Shop Category</a> */}
                          <Link className="nav-link" to="/product">
                            Bàn phím custom
                          </Link>
                        </li>
                        <li className="nav-item">
                          {/* <a className="nav-link" href="single-product.html">Product Details</a> */}
                          <Link className="nav-link" to="/product">
                            Bàn phím gaming
                          </Link>
                        </li>
                        <li className="nav-item">
                          {/* <a className="nav-link" href="checkout.html">Product Checkout</a> */}
                          <Link className="nav-link" to="/product">
                            Bàn phím cơ
                          </Link>
                        </li>
                        <li className="nav-item">
                          {/* <a className="nav-link" href="cart.html">Shopping Cart</a> */}
                          <Link className="nav-link" to="/product">
                            Bàn phím văn phòng
                          </Link>
                        </li>
                      </ul>
                    </li>
                    <li className="nav-item submenu dropdown">
                      {/* <a href="#" className="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                            aria-expanded="false">Blog</a> */}
                      <Link
                        className="nav-link dropdown-toggle"
                        data-toggle="dropdown"
                        role="button"
                        aria-haspopup="true"
                        aria-expanded="false"
                        to="/product"
                      >
                        Phụ kiện
                      </Link>

                      <ul className="dropdown-menu">
                        <li className="nav-item">
                          {/* <a className="nav-link" href="blog.html">Blog</a> */}
                          <Link className="nav-link" to="/categogy">
                            Keycaps
                          </Link>
                        </li>
                        <li className="nav-item">
                          {/* <a className="nav-link" href="single-blog.html">Blog Details</a> */}
                          <Link className="nav-link" to="/categogy">
                            kits
                          </Link>
                        </li>
                      </ul>
                    </li>
                    <li className="nav-item submenu dropdown">
                      {/* <a href="#" className="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                            aria-expanded="false">Pages</a> */}
                      <Link
                        className="nav-link dropdown-toggle"
                        data-toggle="dropdown"
                        role="button"
                        aria-haspopup="true"
                        aria-expanded="false"
                        to="#"
                      >
                        Dịch vụ
                      </Link>
                      <ul className="dropdown-menu">
                        <li className="nav-item">
                          {/* <a className="nav-link" href="tracking.html">Tracking</a> */}
                          <Link className="nav-link" to="/tracking">
                            Dịch vụ custom
                          </Link>
                        </li>
                      </ul>
                    </li>
                    <li className="nav-item">
                      {/* <a className="nav-link" href="contact.html">Contact</a> */}
                      <Link className="nav-link" to="/contact">
                        Liên hệ
                      </Link>
                    </li>
                  </ul>
                </div>

                <div className="col-lg-4 pr-0">
                  <ul className="nav navbar-nav navbar-right right_nav pull-right">
                    <li className="nav-item ">
                      {/* <a href="#" className="icons"> */}
                      <Link className=" icons" to="#">
                        <i className="fa-solid fa-user"></i>
                      </Link>
                      {/* </a> */}
                    </li>

                    <li className="nav-item   ">
                      {/* <a href="#" className="icons"> */}
                      <Link className=" icons" to="#">
                        <i className="fa-solid fa-cart-shopping"></i>
                      </Link>
                      {/* </a> */}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </nav>
        </div>
      </div>
      <div className="sub_menu">
        <div className="container">
          <nav className="navbar navbar-expand-lg navbar-light nav-sub-blue nav-round">
            <div className="collapse navbar-collapse" id="navbarNav">
              <ul className="navbar-nav">
                <li>
                  <div className="dropdown">
                    <div
                      className="dropbtn"
                      type="button"
                      aria-expanded="false"
                    >
                        <i className="fa-solid fa-list"></i>
                        <span>Danh mục</span>
                    </div>
                    <ul className="dropdown-content list-unstyled">
                      <li>
                        <a className="dropdown-item" href="#">
                          Bàn phím cơ
                        </a>
                      </li>
                      <li>
                        <a className="dropdown-item" href="#">
                          Bàn phím văn phòng
                        </a>
                      </li>
                      <li>
                        <a className="dropdown-item" href="#">
                          Bàn phím gaming
                        </a>
                      </li>
                      <li>
                        <a className="dropdown-item" href="#">
                          Bàn phím không dây
                        </a>
                      </li>
                      <li>
                        <a className="dropdown-item" href="#">
                          Bàn phím ipad                
                        </a>
                      </li>
                    </ul>
                  </div>
                </li>
                <li className="nav-item">
                  <a className="nav-link custom-nav" href="#">
                    Đặt hàng theo yêu cầu
                  </a>
                </li>
                <li className="nav-item search-group">
                  <form class="d-flex search-form">
                    <input class="form-control me-2" type="search" placeholder="Tìm kiếm sản phẩm, linh kiện" aria-label="Search"/>
                    <button class="btn searchbtn" type="submit">
                      <i class="fa-solid fa-magnifying-glass"></i>
                      </button>
                  </form>
                </li>
               
              </ul>
            </div>
          </nav>
        </div>
      </div>
    </header>
  );
};
export default Header;
