import './App.css';
import React from 'react';
import Header from './component/header/header';
import Footer from './component/footer/footer';
import AppRoutes from './route/AppRoute';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

function App() {
  return (
    <>
      <AppRoutes />
      <Header />
      <Footer />
    </>
  );
}

export default App;
