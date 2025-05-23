import React from "react"
import './productsSec.css'
import ProductList from "../productList/productList"

const ProductsSec =(props) =>{
    const ishasMore = props.ishasMore
    const products = props.products
    const title= props.title
    return (
        <>
        <section className="productSec " >
                <div className="container flex-wrap" style={ishasMore ? { backgroundColor: '#F8F1F1' } : {}}>
                    <div className="head-sec">
                        <h3>{title}</h3>
                        {ishasMore?(
                            <div className="moreBut">
                                <p>Xem thêm</p>
                                <i class="fa-solid fa-angle-right"></i>
                            </div>
                        ):""}
                        
                    </div>
                    <ProductList products={products}></ProductList>
                </div>
           </section>

        </>
    )
}

export default ProductsSec