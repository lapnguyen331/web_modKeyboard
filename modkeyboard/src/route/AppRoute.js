import React from "react";
import { BrowserRouter, Switch, Route,Routes } from "react-router-dom";
import Contact from "../pages/contact";
import Blog from "../pages/blog";
// import BlogDetail from "./pages/blogDetail";
import Cart from "../pages/cart";
import Category from "../pages/categogy";
import Elements from "../pages/elements";
import Shop from "../pages/shop";
import Checkout from "../pages/checkout";
import ProductDetail from "../pages/productDetail";
import Tracking from "../pages/tracking";
import Home from "../pages/home";
import NotFound from "../pages/notfound";
const AppRoutes = () => {
  return (
    
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/contact" element={<Contact />} />
        <Route path="/blog" element={<Blog />} />
        {/* <Route path="/blog/:id" element={<BlogDetail />} /> */}
        <Route path="/cart" element={<Cart />} />
        <Route path="/category" element={<Category />} />
        <Route path="/elements" element={<Elements />} />
        <Route path="/shop" element={<Shop />} />
        <Route path="/tracking" element={<Tracking />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/productdetail" element={<ProductDetail />} />
        <Route path="/notfound" element={<NotFound />} />
      </Routes>
    
  );
};

export default AppRoutes;
