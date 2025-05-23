import React from "react";
import "./feartureCategogy.css";
import cate1 from "../../assets/categogy/cate1.png";
import cate2 from "../../assets/categogy/cate2.png";
import cate3 from "../../assets/categogy/cate3.png";
import cate4 from "../../assets/categogy/cate4.png";
import cate5 from "../../assets/categogy/cate5.png";

const cateList = [cate1, cate2, cate3, cate4, cate5];
const nameList = [
  "Bàn phím buid sẵn",
  "Switch phím",
  "Keycaps",
  "Dụng cụ hỗ trợ",
  "Phụ kiện khác",
];
const FearturedCate = () => {
  return (
    <>
      <div className="feartureCate-area">
        <div className="container flex-wrap">
          <div className="title">
            <h3>Danh mục sản phẩm nổi bật</h3>
          </div>
          <div className="cateList">
            {cateList.map((img, index) => (
              <div key={index} className="card">
                <img
                  src={img}
                  className="card-img-top"
                  alt={`category-${index}`}
                />
                <div className="card-body">
                  <h5 className="card-text">
                    {nameList[index] || "Danh mục chưa đặt tên"}
                  </h5>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </>
  );
};
export default FearturedCate;
