import React from "react";
import { Link } from "react-router-dom";
import "./products.css";
import ProductList from "../component/productList/productList";

import products from "../data/products";
const Products = () => {
  const FILTER_DATA = {
    brand: ["Akko", "Keychron", "Varmilo", "Logitech", "Durgod"],
    layout: ["60%", "65%", "75%", "TKL", "Full-size"],
    switch: ["Gateron Red", "Gateron Brown", "Cherry Blue", "Akko Silver"],
    connection: ["USB", "Bluetooth", "Wireless 2.4GHz", "Có dây", "Kết hợp"],
    led: ["RGB", "Đơn sắc", "Không có"],
    keycap: ["ABS", "PBT", "Doubleshot", "Dye-sub"],
    caseMaterial: ["Nhôm", "Nhựa", "Gasket Mount", "Tray Mount"],
    isBestSeller: ["Chỉ hiện sản phẩm bán chạy"],
  };
  return (
    <>
      <div className="body">
        <nav aria-label="breadcrumb">
          <div className="container">
            <ol class="breadcrumb">
              <li class="breadcrumb-item">
                <Link to="/home">Home</Link>
              </li>
              <li class="breadcrumb-item active" aria-current="page">
                <Link to="/products">Sản phẩm</Link>
              </li>
            </ol>
          </div>
        </nav>
        <div className="container products-sec">
          <div className="filter-group left-side"></div>
          <div className="productList">
            <ProductList products={products}></ProductList>
          </div>
        </div>
      </div>
    </>
  );
};
export default Products;
