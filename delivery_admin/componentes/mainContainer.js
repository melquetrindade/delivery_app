import MyNavBar from './navBar'
import styles from '../styles/mainContainer.module.css'
import Container from 'react-bootstrap/Container'
import React from "react";

export default function MainContainer({children}){
    return(
        <div>
            <MyNavBar/>
            <Container className={styles.mainContainer}>
                {children}
            </Container>
        </div>
    )
}