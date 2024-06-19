import React from "react";
import styles from '../styles/configuracoes.module.css'
import Button from 'react-bootstrap/Button';
import Col from 'react-bootstrap/Col';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';

export default function Configuracoes() {
    return(
        <main className={styles.main}>
            <div>
                <div>
                    <h1 className={styles.title}>Horários de Funcionamento</h1>
                    <hr style={{marginBottom: '3%'}}></hr>
                    <table responsive="sm" className={styles.table}>
                        <thead>
                            <tr>
                                <th>Dia</th>
                                <th>Horário</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Segunda-Feira</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}>
                                    <span class="material-symbols-outlined">edit</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Terça-Feira</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}>
                                    <span class="material-symbols-outlined">edit</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Quarta-Feira</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}>
                                    <span class="material-symbols-outlined">edit</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Quinta-Feira</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}>
                                    <span class="material-symbols-outlined">edit</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Sexta-Feira</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}>
                                    <span class="material-symbols-outlined">edit</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Sábado</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}>
                                    <span class="material-symbols-outlined">edit</span>
                                </td>
                            </tr>
                            <tr>
                                <td>Domingo</td>
                                <td>18:00 - 23:00</td>
                                <td className={styles.buttonDetails}><span class="material-symbols-outlined">edit</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div className={styles.sessaoEndereco}>
                    <h1 className={styles.title}>Endereço</h1>
                    <hr style={{marginBottom: '3%'}}></hr>
                    <div className={styles.contForm}>
                        <Form>
                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridEmail">
                                <Form.Label>Email</Form.Label>
                                <Form.Control type="email" placeholder="Enter email" />
                                </Form.Group>
    
                                <Form.Group as={Col} controlId="formGridPassword">
                                <Form.Label>Password</Form.Label>
                                <Form.Control type="password" placeholder="Password" />
                                </Form.Group>
                            </Row>
    
                            <Form.Group className="mb-3" controlId="formGridAddress1">
                                <Form.Label>Address</Form.Label>
                                <Form.Control placeholder="1234 Main St" />
                            </Form.Group>
    
                            <Form.Group className="mb-3" controlId="formGridAddress2">
                                <Form.Label>Address 2</Form.Label>
                                <Form.Control placeholder="Apartment, studio, or floor" />
                            </Form.Group>
    
                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridCity">
                                <Form.Label>City</Form.Label>
                                <Form.Control />
                                </Form.Group>
    
                                <Form.Group as={Col} controlId="formGridState">
                                <Form.Label>State</Form.Label>
                                <Form.Select defaultValue="Choose...">
                                    <option>Choose...</option>
                                    <option>...</option>
                                </Form.Select>
                                </Form.Group>
    
                                <Form.Group as={Col} controlId="formGridZip">
                                <Form.Label>Zip</Form.Label>
                                <Form.Control />
                                </Form.Group>
                            </Row>
    
                            <Form.Group className="mb-3" id="formGridCheckbox">
                                <Form.Check type="checkbox" label="Check me out" />
                            </Form.Group>
    
                            <Button variant="primary" type="submit">
                                Submit
                            </Button>
                        </Form>
                    </div>
                </div>
            </div>
        </main>
    );
}