import React from 'react';
import { Nav } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import {logOut} from '../utils/firebase/authService'

const Sidebar = () => {
  return (
    <div className="d-flex flex-column vh-100 p-3 bg-dark text-white" style={{ width: '250px' }}>
      <h4>Delivery - Admin</h4>
      <Nav defaultActiveKey="/" className="flex-column">
        <Nav.Link href="/" className="text-white">Home</Nav.Link>
        <Nav.Link href="#" className="text-white">Produtos</Nav.Link>
        <Nav.Link href="#" className="text-white">Promoções</Nav.Link>
        <Nav.Link href="#" className="text-white">Configurações</Nav.Link>
        <Nav.Link href="#" className="text-white">Pedidos</Nav.Link>
        <Nav.Link href="#" className="text-white">Vendas</Nav.Link>
        <Nav.Link href="#" className="text-white" onClick={logOut}>Sair</Nav.Link>
      </Nav>
    </div>
  );
};

export default Sidebar;
