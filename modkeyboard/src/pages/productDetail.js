import React, { useState, useRef } from 'react';
import './productDetail.css';
import products from "../data/products";

const ArrowButton = ({ direction, onClick }) => {
    return (
        <button
            onClick={onClick}
            className={`arrow-button ${direction === 'left' ? 'left-arrow' : 'right-arrow'}`}
            style={{
                position: 'absolute',
                top: '50%',
                [direction]: 0,
                transform: 'translateY(-50%)',
                zIndex: 10,
                backgroundColor: 'rgba(255,255,255,0.9)',
                border: 'none',
                cursor: 'pointer',
                padding: '8px',
                borderRadius: '50%',
                boxShadow: '0 2px 6px rgba(0,0,0,0.2)',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                width: 36,
                height: 36,
            }}
            aria-label={direction === 'left' ? 'Scroll left' : 'Scroll right'}
        >
            {direction === 'left' ? (
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <polyline points="15 18 9 12 15 6" />
                </svg>
            ) : (
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <polyline points="9 18 15 12 9 6" />
                </svg>
            )}
        </button>
    );
};

const ProductDetail = () => {
    const [activeTab, setActiveTab] = useState('description');
    const product = products[1];

    const relatedProducts = products.filter(p => p.id !== product.id).slice(0, 6);

    const scrollRef = useRef(null);

    const scrollLeft = () => {
        scrollRef.current.scrollBy({ left: -300, behavior: 'smooth' });
    };

    const scrollRight = () => {
        scrollRef.current.scrollBy({ left: 300, behavior: 'smooth' });
    };

    return (
        <div className="product-detail-container">
            <div className="breadcrumb">
                <a href="/">Trang chủ</a> &gt; <a href="/category">Bàn phím cơ</a> &gt; <span>{product.name}</span>
            </div>

            <div className="product-main-content">
                <div className="product-image-section">
                    <img src={product.imgUrl} alt={product.name} className="product-image" />
                </div>

                <div className="product-info-section">
                    <h2 className="product-title">{product.name}</h2>
                    <div className="product-rating">
                        <span>⭐⭐⭐⭐☆</span> <span>(42 đánh giá)</span>
                    </div>
                    <p className="product-price">2,590,000 VNĐ</p>

                    <div className="product-options">
                        <label>
                            Chọn Switch:
                            <select>
                                <option>Holy Panda</option>
                                <option>Gateron Red</option>
                                <option>Cherry MX Blue</option>
                            </select>
                        </label>

                        <label>
                            Chọn Keycap:
                            <select>
                                <option>PBT</option>
                                <option>ABS</option>
                            </select>
                        </label>

                        <label>
                            Số lượng:
                            <input type="number" min="1" defaultValue="1" />
                        </label>
                    </div>

                    <button className="add-to-cart-btn">Thêm vào giỏ hàng</button>
                    <button className="buy-now-btn">Mua ngay</button>
                </div>
            </div>

            <div className="product-detail-reviews-container">
                <div className="product-detail-info">
                    <h3>Thông tin chi tiết sản phẩm</h3>

                    <div className="product-tabs">
                        <button
                            className={activeTab === 'description' ? 'active' : ''}
                            onClick={() => setActiveTab('description')}
                        >
                            Mô tả
                        </button>
                        <button
                            className={activeTab === 'specs' ? 'active' : ''}
                            onClick={() => setActiveTab('specs')}
                        >
                            Thông số kỹ thuật
                        </button>
                        <button
                            className={activeTab === 'warranty' ? 'active' : ''}
                            onClick={() => setActiveTab('warranty')}
                        >
                            Bảo hành
                        </button>
                    </div>

                    <div className="tab-content">
                        {activeTab === 'description' && (
                            <p>
                                Bàn phím cơ custom cao cấp, hỗ trợ hot swap, LED RGB, build chắc chắn, phù hợp cho gaming và làm việc.
                            </p>
                        )}
                        {activeTab === 'specs' && (
                            <ul>
                                <li>Layout: 75%</li>
                                <li>Switch: Hot Swap, có thể thay thế dễ dàng</li>
                                <li>LED: RGB đa màu, hiệu ứng phong phú</li>
                                <li>Keycap: Chất liệu PBT, chống mờ chữ</li>
                                <li>Kết nối: USB Type-C</li>
                                <li>Khung: Hợp kim nhôm chắc chắn, bền bỉ</li>
                            </ul>
                        )}
                        {activeTab === 'warranty' && (
                            <p>
                                Sản phẩm được bảo hành 12 tháng chính hãng, lỗi đổi mới trong vòng 7 ngày đầu.
                            </p>
                        )}
                    </div>
                </div>
            </div>

            <div className="product-reviews-section">
                <h3>Đánh giá sản phẩm</h3>
                <div className="review">
                    <strong>Nguyễn Văn A</strong>
                    <span>⭐⭐⭐⭐☆</span>
                    <p>Sản phẩm rất tốt, độ bền cao, thiết kế đẹp.</p>
                </div>
                <div className="review">
                    <strong>Trần Thị B</strong>
                    <span>⭐⭐⭐⭐⭐</span>
                    <p>Phím bấm nhẹ, LED đẹp, rất hài lòng với sản phẩm.</p>
                </div>
                <div className="review">
                    <strong>Phạm Văn C</strong>
                    <span>⭐⭐⭐☆☆</span>
                    <p>Switch hơi cứng, nhưng overall vẫn ổn.</p>
                </div>
            </div>

            <div className="related-products-section" style={{ position: 'relative', marginTop: 40 }}>
                <h3>Sản phẩm liên quan</h3>

                <ArrowButton direction="left" onClick={scrollLeft} />
                <ArrowButton direction="right" onClick={scrollRight} />

                <div
                    className="related-products-scroll"
                    ref={scrollRef}
                    style={{
                        display: 'flex',
                        gap: 16,
                        overflowX: 'auto',
                        padding: '10px 40px',
                        scrollBehavior: 'smooth',
                    }}
                >
                    {relatedProducts.map((item) => (
                        <div
                            key={item.id}
                            className="related-product-card"
                            style={{
                                minWidth: 150,
                                flexShrink: 0,
                                border: '1px solid #ddd',
                                borderRadius: 8,
                                padding: 10,
                                textAlign: 'center',
                                backgroundColor: '#fff',
                            }}
                        >
                            <img
                                src={item.imgUrl}
                                alt={item.name}
                                style={{ width: '100%', borderRadius: 4, marginBottom: 8 }}
                            />
                            <h4>{item.name}</h4>
                            <p>{item.price} VND</p>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default ProductDetail;
