import React from "react";
import "./productList.css";
import { Link } from "react-router-dom";
import { useDispatch,useSelector } from "react-redux";
import { addToCart ,removeFromCart} from "../../redux/cartSlice";

const ProductList = ({ products = [] }) => {
  const dispatch = useDispatch();
   // Lấy danh sách sản phẩm trong giỏ hàng từ Redux
  const cart = useSelector((state) => state.cart.items);


  return (
    <div className="product-grid">
     
      <div class="row">
        {products.map((product) => {
            // kiểm tra xem có id của product trong cart chưa
           const isInCart = cart.some((item) => item.id === product.id);
           const handleToggleCart = () => {
            if (isInCart) {
              dispatch(removeFromCart(product.id));
            } else {
              dispatch(addToCart(product));
            }
          };
           return (
          <div class="col-lg-3 col-md-6 product-item "  key={product.id}>
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
                  <button  onClick={handleToggleCart}>
                    <i className={`fa-solid fa-cart-plus ${
            isInCart ? "pink-icon" : ""
          }`}></i>
                  </button>
                </div>
              </div>
            </div>
          </div>
           );
})}
      </div>
    </div>
  );
};
export default ProductList;
