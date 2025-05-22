import "./homebanner.css";
const HomeBanner = () => {
  return (
    <>
      <section class="home_banner_area lg-10">
        <div class="banner_inner d-flex align-items-center">
          <div class="container">
            <div class="banner_content row">
              <div class="col-lg-12 bannerBut">
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
