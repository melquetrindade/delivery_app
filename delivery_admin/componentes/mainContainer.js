import MyNavBar from './navBar'
import Sidebar from './sideBar'
import styles from '../styles/mainContainer.module.css'
import Container from 'react-bootstrap/Container'
import React from "react";

export default function MainContainer({children}){
    return(
        <div className="d-flex">
            <Sidebar/>
            <Container className={`flex-grow-1 p-3 ${styles.mainContainer}`}>
                {children}
            </Container>
        </div>
    )
}