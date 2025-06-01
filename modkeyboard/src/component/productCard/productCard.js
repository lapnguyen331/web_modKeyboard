import "./productCard.css";
import { Link } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { addToCart, removeFromCart } from "../../redux/cartSlice";

const ProductCard = ({ product }) => {
  console.log("hi" + product)
  const dispatch = useDispatch();
  const isInCart = useSelector((state) =>
    state.cart.items.some((item) => item.id === product.id)
  );

  const handleToggleCart = () => {
    if (isInCart) dispatch(removeFromCart(product.id));
    else dispatch(addToCart(product));
  };
  return (
      <div className="single-product">
        <div className="product-img">
          <img
            className="img-fluid w-100"
            src={
              product.imgUrl.startsWith("//")
                ? "https:" + product.imgUrl
                : product.imgUrl
            }
            alt={product.name}
          />
        </div>
        <div className="product-btm">
          <Link to="#" className="d-block">
            <h4 className="prductName">{product.name}</h4>
          </Link>
          <div className="mt-3 price-sec">
            <span className="mr-4 price">
              {(product.price || 0).toLocaleString("vi-VN")} đ
            </span>
            {product.discount !== 0 ? (
              <>
                <del className="discount-price">
                  {(
                    product.price -
                    product.price * product.discount
                  ).toLocaleString("vi-VN")}
                  đ
                </del>
                <i className="fa-solid fa-tag saletag"></i>
              </>
            ) : null}
          </div>
          <div className="mt-3 p_icon">
            <button>
              <i className="fa-solid fa-eye"></i>
            </button>
            <button>
              <i className="fa-solid fa-heart"></i>
            </button>
            <button key={product.id} onClick={handleToggleCart}>
              <i
                className={`fa-solid fa-cart-plus  `}
                style={{ color: isInCart ? "#ff0066" : "#333" }}
              ></i>
            </button>
          </div>
        </div>
      </div>
  );
};
export default ProductCard;
