import React, {useState, useEffect} from "react";
import { getDocs, collection, getDoc, doc} from 'firebase/firestore';
import styles from '../styles/configuracoes.module.css'
import { db } from '../utils/firebase/firebaseService';

// componentes bootstrap
import Button from 'react-bootstrap/Button';
import Col from 'react-bootstrap/Col';
import Form from 'react-bootstrap/Form';
import Row from 'react-bootstrap/Row';
import Modal from 'react-bootstrap/Modal';

export default function Configuracoes() {
    const [loading, setLoading] = useState('load')
    const [dataHorario, setHorario] = useState()
    const [dataEndereco, setEndereco] = useState()
    const [dataContato, setContato] = useState()
    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    const loadHorario = async () => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/horarios`, 'horarios'));
            const snapData = querySnapshot.data()
            console.log(`snapData: ${snapData}`)
            setHorario(snapData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    const loadEndereco = async () => {
        try{
            var newData = []

            const querySnapshot = await getDocs(collection(db, `loja/owner/vendas`));
            querySnapshot.forEach((doc) => {
                var docData = doc.data();
                newData.push(docData);
            })

            setVendas(newData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    const loadContato = async () => {
        try{
            var newData = []

            const querySnapshot = await getDocs(collection(db, `loja/owner/vendas`));
            querySnapshot.forEach((doc) => {
                var docData = doc.data();
                newData.push(docData);
            })

            setVendas(newData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    useEffect(() => {
        loadHorario()
        setLoading('ok')
    }, []);

    if(loading == 'ok'){
        console.log('loading == ok')
        if(dataHorario){
            console.log(`horarios: ${dataHorario}`)
        }
    }

    return(
        <main className={styles.main}>
            <div>
                <div>
                    <h1 className={styles.title}>Horários de Funcionamento</h1>
                    <hr style={{marginBottom: '3%'}}></hr>
                    {
                        dataHorario
                        ?
                        <table responsive="sm" className={styles.table}>
                            <thead>
                                <tr>
                                    <th>Status</th>
                                    <th>Dia</th>
                                    <th>Horário</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Segunda-Feira</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}>
                                        <span class="material-symbols-outlined">edit</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Terça-Feira</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}>
                                        <span class="material-symbols-outlined">edit</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Quarta-Feira</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}>
                                        <span class="material-symbols-outlined">edit</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Quinta-Feira</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}>
                                        <span class="material-symbols-outlined">edit</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Sexta-Feira</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}>
                                        <span class="material-symbols-outlined">edit</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Sábado</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}>
                                        <span class="material-symbols-outlined">edit</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td className={styles.tdStatus}>Aberto</td>
                                    <td>Domingo</td>
                                    <td>18:00 - 23:00</td>
                                    <td className={styles.buttonDetails}><span class="material-symbols-outlined">edit</span></td>
                                </tr>
                            </tbody>
                        </table>
                        :
                        <div>
                            <Button variant="primary" onClick={handleShow}>
                                Cadastrar Horários
                            </Button>

                            <Modal show={show} onHide={handleClose}>
                                <Modal.Header closeButton>
                                    <Modal.Title>Horários de funcionamento</Modal.Title>
                                </Modal.Header>
                                <Modal.Body>
                                    <Form>
                                        <div className={styles.formModal}>
                                            <h1>Segunda-Feira</h1>
                                            <Row className="mb-3">
                                                <Form.Group as={Col} controlId="segundaAbertura">
                                                <Form.Label>Abertura</Form.Label>
                                                <Form.Control
                                                    type="text"
                                                    placeholder="18:00"
                                                    autoFocus
                                                />
                                                </Form.Group>
                                                <Form.Group as={Col} controlId="segundaFechamento">
                                                <Form.Label>Fechamento</Form.Label>
                                                <Form.Control
                                                    type="text"
                                                    placeholder="23:00"
                                                    autoFocus
                                                />
                                                </Form.Group>
                                            </Row>
                                        </div>
                                        <div className={styles.formModal}>
                                            <h1>Terça-Feira</h1>
                                            <Row className="mb-3">
                                                <Form.Group as={Col} controlId="segundaAbertura">
                                                <Form.Label>Abertura</Form.Label>
                                                <Form.Control
                                                    type="text"
                                                    placeholder="18:00"
                                                    autoFocus
                                                />
                                                </Form.Group>
                                                <Form.Group as={Col} controlId="segundaFechamento">
                                                <Form.Label>Fechamento</Form.Label>
                                                <Form.Control
                                                    type="text"
                                                    placeholder="23:00"
                                                    autoFocus
                                                />
                                                </Form.Group>
                                            </Row>
                                        </div>
                                    </Form>
                                </Modal.Body>
                                <Modal.Footer>
                                    <Button variant="secondary" onClick={handleClose}>
                                        Close
                                    </Button>
                                    <Button variant="primary" onClick={handleClose}>
                                        Save Changes
                                    </Button>
                                </Modal.Footer>
                            </Modal>
                        </div>
                    }
                    <div className={styles.opa}>
                        <div className={styles.buttonLock}>
                            <p>Fechar o aplicativo momentaneamente</p>
                            <span class="material-symbols-outlined">lock</span>
                        </div>
                    </div>
                </div>
                <div className={styles.sessaoEndereco}>
                    <h1 className={styles.title}>Endereço e Frete</h1>
                    <hr style={{marginBottom: '3%'}}></hr>
                    <div className={styles.contForm}>
                        <Form>
                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridCity">
                                    <Form.Label>Cidade</Form.Label>
                                    <Form.Control type="text" placeholder="ex: Rio de Janeiro" />
                                </Form.Group>
    
                                <Form.Group as={Col} controlId="formGridNeighborhood">
                                    <Form.Label>Bairro</Form.Label>
                                    <Form.Control type="text" placeholder="ex: Centro" />
                                </Form.Group>
                            </Row>
    
                            <Row className="mb-3">
                                <Col xs={8}>
                                    <Form.Group as={Col} controlId="formGridRoad">
                                        <Form.Label>Rua</Form.Label>
                                        <Form.Control placeholder="ex: 7 de Setembro" />
                                    </Form.Group>
                                </Col>
        
                                <Col>
                                    <Form.Group as={Col} controlId="formGridNumber">
                                        <Form.Label>Nº</Form.Label>
                                        <Form.Control placeholder="ex: 311" />
                                    </Form.Group>
                                </Col>

                                <Col>
                                    <Form.Group as={Col} controlId="formGridNumber">
                                        <Form.Label>Frete</Form.Label>
                                        <Form.Control placeholder="ex: 5,00" />
                                    </Form.Group>
                                </Col>
                            </Row>
    
                            <Button variant="primary">
                                Salvar
                            </Button>
                        </Form>
                    </div>
                </div>
                <div className={styles.sessaoContato} styles={{marginBottom: '5%'}}>
                    <h1 className={styles.title}>Contato</h1>
                    <hr style={{marginBottom: '3%'}}></hr>
                    <table responsive="sm" className={styles.tableContato}>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Telefone</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>84 9.9811-3464</td>
                                <td className={styles.buttonDelete}>
                                    <span class="material-symbols-outlined">delete</span>
                                </td>
                            </tr>
                            <tr>
                            <td>1</td>
                                <td>84 9.9822-3432</td>
                                <td className={styles.buttonDelete}>
                                    <span class="material-symbols-outlined">delete</span>
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    );
}