import "./homebanner.css";
const HomeBanner = () => {
  return (
    <>
      <section className="home_banner_area lg-10">
        <div className="banner_inner d-flex align-items-center">
          <div className="container">
            <div className="banner_content row">
              <div className="col-lg-12 bannerBut">
                {/* <p class="sub text-uppercase">men Collection</p> */}
                <h3>
                    <span>NEW : LOWER</span>
                  <span>PRICES</span> 
                  <span>SITEWIDE</span> 
                </h3>
                <div className="button-wrapper">
                    <button>CUSTOM KEYBOARD</button>
                    <button>VIEW KEYBOARD</button>
                </div>

              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};
export default HomeBanner;
