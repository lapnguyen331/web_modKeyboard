import React from "react";
import "./home.css";
import FearturedCate from "../component/featuredcategories/feartureCategogy";
import HomeBanner from "../component/homebanner/homebanner";
import ProductsSec from "../component/productSec/productsSec";
import introbanner from "../assets/home/introbanner.png";
import products from "../data/products";

const Home = () => {
  const productList = products;
  return (
    <>
      <HomeBanner />
      <FearturedCate />
      <ProductsSec
        products={productList}
        ishasMore={true}
        title={"Sản phẩm mới đăng gần đây"}
      ></ProductsSec>
      <ProductsSec
        products={productList}
        ishasMore={false}
        title={"Chời đón sản phẩm mới - preOrder ngay !"}
      ></ProductsSec>
      <ProductsSec
        products={productList}
        ishasMore={true}
        title={"Sản phẩm người bán đăng !"}
      ></ProductsSec>
      <section className="intro-bottom">
        <div className="container flex-wrap intro-background">
          <div className="wrapper">
            <div className="left-com">
              <div className="title">
                <h4>Thiết kế và đặt hàng riêng cho bàn phím của bạn</h4>
              </div>
              <div className="button-wrap">
                <button>Custom phím</button>
                <button>Tư vấn bằng AI</button>
              </div>
            </div>
            <div className="right-com product-ex">
                <div className="img-wrap">
                    <img src={products[0].imgUrl} />
                    <div className="text-wrap">
                        <span>Custom: FL47</span>
                    </div>
                </div>
                 <div className="img-wrap">
                    <img src={products[1].imgUrl} />
                    <div className="text-wrap">
                        <span>Custom: FL47</span>
                    </div>
                </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};
export default Home;
