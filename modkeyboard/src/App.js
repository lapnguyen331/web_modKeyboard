import './App.css';
import React from 'react';
import Header from './component/header/header';
import Footer from './component/footer/footer';
import AppRoutes from './route/AppRoute';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import Home from './pages/home';

function App() {
  return (
    <>
      <Header />
      <AppRoutes />
      <Footer />
    </>
  );
}

export default App;
