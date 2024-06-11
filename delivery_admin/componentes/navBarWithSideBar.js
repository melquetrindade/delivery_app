import React, { useState } from 'react';
import { Navbar, Nav, Button, Offcanvas } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import styles from '../styles/NavbarWithSidebar.module.css';
import {logOut} from '../utils/firebase/authService'
import Link from "next/link";

const NavbarWithSidebar = () => {
  const [show, setShow] = useState(false);

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);

  const buttonStyle = {
    color: 'black',
    borderRadius: '3px',
    fontSize: '1rem',
    color: 'yellow',
    fontWeight: 500,
    paddingTop: '3px',
  };

  const logout = {
    fontWeight: 700,
    color: 'red',
    paddingRight: '20px',
    paddingTop: '5px'
  };

  const teste = {
    backgroundColor: 'rgb(255, 236, 236)',
  }

  const contButtons = {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'auto',
    cursor: 'pointer',
    backgroundColor: 'red',
    borderRadius: '5px',
    padding: '8px 15px',
    textDecoration: 'none'
  }

  const contButtons2 = {
    marginTop: '15px',
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'auto',
    cursor: 'pointer',
    padding: '8px 15px'
  }


  const span = {
    color: 'red',
    paddingTop: '5px'
  }

  const span2 = {
    color: 'yellow',
    paddingTop: '5px'
  }

  const title = {
    fontWeight: 600,
    fontSize: '1.3rem',
    color: 'white'
  }

  const contLogo = {
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    width: '15%'
  }

  const img = {
    width: '40px',
    height: '40px',
    borderRadius: '50%',
    marginLeft: '7%'
  }

  return (
    <>
        <Navbar className={`${styles.navBar} d-flex justify-content-between align-items-center px-5`}>
            <Button className={styles.buttonHamburguer} onClick={handleShow}>
                <span className={`material-symbols-outlined ${styles.buttonSpan}`}>menu</span>
            </Button>
            <div style={contLogo}>
              <h1 href="#" style={title}>Delivery-Admin</h1>
              <img src='/icon.png' style={img}></img>
            </div>
        </Navbar>

        <Offcanvas show={show} onHide={handleClose} style={teste}>
            <Offcanvas.Header closeButton>
            <Offcanvas.Title>Menu</Offcanvas.Title>
            </Offcanvas.Header>
            <Offcanvas.Body className={styles.offcanvasBody}>
                <Nav className='flex-column'>
                    <Link href="/" style={contButtons}>
                        <h5 style={buttonStyle}>Home</h5>
                        <span class="material-symbols-outlined" style={span2}>home</span>
                    </Link>
                    <hr></hr>
                    <Link href="/produtos" style={contButtons}>
                        <h5 style={buttonStyle}>Produtos</h5>
                        <span class="material-symbols-outlined" style={span2}>fastfood</span>
                    </Link>
                    <hr></hr>
                    <Link href="/promocoes" style={contButtons}>
                        <h5 style={buttonStyle}>Promoções</h5>
                        <span class="material-symbols-outlined" style={span2}>shopping_bag</span>
                    </Link>
                    <hr></hr>
                    <Link href="/configuracoes" style={contButtons}>
                        <h5 style={buttonStyle}>Configurações</h5>
                        <span class="material-symbols-outlined" style={span2}>settings</span>
                    </Link>
                    <hr></hr>
                    <Link href="/pedidos" style={contButtons}>
                        <h5 style={buttonStyle}>Pedidos</h5>
                        <span class="material-symbols-outlined" style={span2}>receipt_long</span>
                    </Link>
                    <hr></hr>
                    <Link href="/vendas" style={contButtons}>
                        <h5 style={buttonStyle}>Vendas</h5>
                        <span class="material-symbols-outlined" style={span2}>order_approve</span>
                    </Link>
                    <div style={contButtons2}>
                        <h5 href="#" onClick={logOut} style={logout}>Sair</h5>
                        <span class="material-symbols-outlined" style={span}>logout</span>
                    </div>
                </Nav>
            </Offcanvas.Body>
        </Offcanvas>
    </>
  );
};

export default NavbarWithSidebar;
