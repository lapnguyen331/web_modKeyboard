import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import { BrowserRouter } from 'react-router-dom'


  // import './libs/css/bootstrap.css';
  // import './libs/vendors/linericon/style.css'
  // import './libs/css/font-awesome.min.css';
  // import './libs/css/themify-icons.css';
  // import './libs/css/flaticon.css';
  // import './libs/vendors/owl-carousel/owl.carousel.min.css';
  // import './libs/vendors/lightbox/simpleLightbox.css';
  // import './libs/vendors/nice-select/css/nice-select.css';
  // import './libs/vendors/animate-css/animate.css';
  // import './libs/vendors/jquery-ui/jquery-ui.css';
   
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
    <BrowserRouter>
      <App/>
    </BrowserRouter>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
