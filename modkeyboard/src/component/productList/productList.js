import React from "react";
import "./productList.css";
import { Link } from "react-router-dom";

const ProductList = ({ products = [] }) => {
  return (
    <div className="product-grid">
     
      <div class="row">
        {products.map((product) => (
          <div class="col-lg-3 col-md-6">
            <div class="single-product">
              <div class="product-img">
                <img
                  class="img-fluid w-100"
                  src={
                    product.imgUrl.startsWith("//")
                      ? "https:" + product.imgUrl
                      : product.imgUrl
                  }
                  alt={product.name}
                />
              </div>
              <div class="product-btm">
                <Link to="#" class="d-block">
                  <h4 className="prductName">{product.name}</h4>
                </Link>
                <div class="mt-3 price-sec">
                  <span className="mr-4 price">
                    {" "}
                    {(product.price || 0).toLocaleString("vi-VN")} đ
                  </span>
                  {product.discount !== 0  ? (
                    <>
                      <del className="discount-price">
                        {(
                          product.price -
                          product.price * product.discount
                        ).toLocaleString("vi-VN")}
                        đ
                      </del>
                        <i className ="fa-solid fa-tag saletag"></i>
                    </>
                  ) : (
                    ""
                  )}
                </div>
                <div class="mt-3 p_icon">
                  <button to="#">
                    <i class="fa-solid fa-eye"></i>
                  </button>
                  <button to="#">
                    <i class="fa-solid fa-heart"></i>
                  </button>
                  <button to="#">
                    <i class="fa-solid fa-cart-plus"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
export default ProductList;
