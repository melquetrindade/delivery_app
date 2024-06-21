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

    const registerTime = () => {
        const abtrSegunda = document.getElementById('abtrSegunda').value;
        const abtrTerca = document.getElementById('abtrTerca').value;
        const abtrQuarta = document.getElementById('abtrQuarta').value;
        const abtrQuinta = document.getElementById('abtrQuinta').value;
        const abtrSexta = document.getElementById('abtrSexta').value;
        const abtrSabado = document.getElementById('abtrSabado').value;
        const abtrDomingo = document.getElementById('abtrDomingo').value;
        const fchSegunda = document.getElementById('fchSegunda').value;
        const fchTerca = document.getElementById('fchTerca').value;
        const fchQuarta = document.getElementById('fchQuarta').value;
        const fchQuinta = document.getElementById('fchQuinta').value;
        const fchSexta = document.getElementById('fchSexta').value;
        const fchSabado = document.getElementById('fchSabado').value;
        const fchDomingo = document.getElementById('fchDomingo').value;

        console.log(abtrSegunda)
        console.log(fchSegunda)
    }

    return(
        <main className={styles.main}>
            <div>
                <div className={styles.sessaoHorarios}>
                    <h1 className={styles.title}>Horários de Funcionamento</h1>
                    <hr style={{marginBottom: '3%'}}></hr>
                    {
                        dataHorario
                        ?
                        <>
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
                            <div className={styles.opa}>
                                <div className={styles.buttonLock}>
                                    <p>Fechar o aplicativo momentaneamente</p>
                                    <span class="material-symbols-outlined">lock</span>
                                </div>
                            </div>
                        </>
                        :
                        <>
                            <table className={styles.tableForm}>
                                <thead>
                                    <tr>
                                        <th>Horários</th>
                                        <th>Segunda-Feira</th>
                                        <th>Terça-Feira</th>
                                        <th>Quarta-Feira</th>
                                        <th>Quinta-Feira</th>
                                        <th>Sexta-Feira</th>
                                        <th>Sábado</th>
                                        <th>Domingo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">Abre às</th>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrSegunda" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrTerca" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrQuarta" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrQuinta" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrSexta" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrSabado" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrDomingo" required placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Fecha às</th>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchSegunda" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchTerca" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchQuarta" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchQuinta" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchSexta" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchSabado" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchDomingo" required placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                            <div className={styles.opa}>
                                <div className={styles.buttonLock} onClick={registerTime}>
                                    <p>Registrar Horários</p>
                                    <span class="material-symbols-outlined">schedule</span>
                                </div>
                            </div>
                        </>
                    }
                    
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