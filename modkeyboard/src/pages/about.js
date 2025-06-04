import React from 'react';
import './about.css';

const About = () => {
    return (
        <div className="about-container">
            <div className="about-hero">
                <h1>Về chúng tôi</h1>
                <p>Khám phá hành trình và sứ mệnh của chúng tôi trong thế giới bàn phím cơ custom.</p>
            </div>

            <div className="about-section">
                <h2>Câu chuyện của chúng tôi</h2>
                <p>
                    Chúng tôi là những người yêu thích công nghệ và nghệ thuật, đặc biệt là thế giới bàn phím cơ. Từ một nhóm nhỏ mê bàn phím,
                    chúng tôi đã phát triển thành một cửa hàng chuyên cung cấp bàn phím custom chất lượng cao, phục vụ cộng đồng đánh máy, coder và game thủ tại Việt Nam.
                </p>
            </div>

            <div className="about-section highlight-section">
                <div className="highlight">
                    <h3>✨ Thiết kế theo yêu cầu</h3>
                    <p>Chúng tôi cung cấp giải pháp thiết kế bàn phím theo đúng cá tính của bạn – từ layout, switch, keycap đến màu sắc.</p>
                </div>
                <div className="highlight">
                    <h3>💡 Tư vấn bởi AI</h3>
                    <p>Tự động đề xuất cấu hình bàn phím phù hợp dựa trên phong cách gõ và thói quen sử dụng của bạn.</p>
                </div>
                <div className="highlight">
                    <h3>🚚 Giao hàng toàn quốc</h3>
                    <p>Đóng gói cẩn thận, giao hàng nhanh chóng đến mọi miền đất nước.</p>
                </div>
            </div>

            <div className="about-section team-section">
                <h2>Đội ngũ của chúng tôi</h2>
                <div className="team-group-photo">
                    <img src="https://angia.com.vn/pictures/catalog/about/gioithieu20222.jpg" alt="Đội ngũ của chúng tôi" />
                </div>
            </div>
        </div>
    );
};

export default About;
