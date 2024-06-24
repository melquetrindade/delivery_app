import React, {useState, useEffect} from "react";
import { getDocs, collection, getDoc, doc, addDoc, setDoc, updateDoc} from 'firebase/firestore';
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
    const [dayOpen, setDay] = useState({
        segunda: false,
        terca: false,
        quarta: false,
        quinta: false,
        sexta: false,
        sabado: false,
        domingo: false,
    })
    var listaTeste = [
        [dayOpen.segunda, 'abtrSegunda', 'fchSegunda'],
        [dayOpen.terca, 'abtrTerca', 'fchTerca'],
        [dayOpen.quarta, 'abtrQuarta', 'fchQuarta'],
        [dayOpen.quinta, 'abtrQuinta', 'fchQuinta'],
        [dayOpen.sexta, 'abtrSexta', 'fchSexta'],
        [dayOpen.sabado, 'abtrSabado', 'fchSabado'],
        [dayOpen.domingo, 'abtrDomingo', 'fchDomingo'],
    ]
    const [editDay, setEditDay] = useState({})
    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    const loadHorario = async () => {
        try{
            var listaDias = []
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/horarios`, 'horarios'));
            const snapData = querySnapshot.data()
            if(snapData){
                for (var i = 0; i < 7; i++){
                    if(i == 0){
                        listaDias.push(snapData.segunda)
                    } else if(i == 1){
                        listaDias.push(snapData.terca)
                    } else if(i == 2){
                        listaDias.push(snapData.quarta)
                    } else if(i == 3){
                        listaDias.push(snapData.quinta)
                    } else if(i == 4){
                        listaDias.push(snapData.sexta)
                    } else if(i == 5){
                        listaDias.push(snapData.sabado)
                    } else {
                        listaDias.push(snapData.domingo)
                    }
                    
                }
            }
            if(listaDias.length != 0){
                setHorario(listaDias)
            }
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

    if(dataHorario != undefined){
        console.log(dataHorario)
    }

    const registerTimeFirebase = async (objt) => {
        try{
            const docRef = doc(db, `loja/configuracoes/horarios`, 'horarios');
            const data = {
                segunda: objt[0].status ? objt[0] : {status: false},
                terca: objt[1].status ? objt[1] : {status: false},
                quarta: objt[2].status ? objt[2] : {status: false},
                quinta: objt[3].status ? objt[3] : {status: false},
                sexta: objt[4].status ? objt[4] : {status: false},
                sabado: objt[5].status ? objt[5] : {status: false},
                domingo: objt[6].status ? objt[6] : {status: false}
            };
            await setDoc(docRef, data);
            console.log('horarios add com sucesso')
        } catch(error) {
            console.error('Erro ao adicionar dado:', error);
        }
        
    }

    const registerTime2 = () => {
        var tudoOk = true
        var objtHorarios = [
            {status: false},
            {status: false},
            {status: false},
            {status: false},
            {status: false},
            {status: false},
            {status: false},
        ]

        for(var i = 0; i < listaTeste.length; i++){
            const abtr = document.getElementById(listaTeste[i][1]).value;
            const fch = document.getElementById(listaTeste[i][2]).value;
            if(listaTeste[i][0]) {
                if(abtr && fch && formataHorario(abtr) && formataHorario(fch)){
                    objtHorarios[i] = {
                        abre: abtr,
                        fecha: fch,
                        status: true
                    }
                } else{
                    tudoOk = false
                }
            }
        }

        if(tudoOk){
            registerTimeFirebase(objtHorarios)
        }
        else{
            console.log('apresentar um notificação para preencher corretamente os horários de atendimento')
        }
    }

    const formataHorario = (hora) => {
        const formthora = hora.split(":");
        if(formthora.length == 2){
            const hoursArray = formthora[0];
            const minutesArray = formthora[1];
            if(hoursArray.length == 2 && minutesArray.length == 2){
                return true
            }
            return false
        }
        return false 
    }

    const opCheckBox = (dia) => {
        if(dia == 0){
            setDay({
                segunda: !dayOpen.segunda,
                terca: dayOpen.terca,
                quarta: dayOpen.quarta,
                quinta: dayOpen.quinta,
                sexta: dayOpen.sexta,
                sabado: dayOpen.sabado,
                domingo: dayOpen.domingo,
            })
        } else if (dia == 1) {
            setDay({
                segunda: dayOpen.segunda,
                terca: !dayOpen.terca,
                quarta: dayOpen.quarta,
                quinta: dayOpen.quinta,
                sexta: dayOpen.sexta,
                sabado: dayOpen.sabado,
                domingo: dayOpen.domingo,
            })
        } else if (dia == 2) {
            setDay({
                segunda: dayOpen.segunda,
                terca: dayOpen.terca,
                quarta: !dayOpen.quarta,
                quinta: dayOpen.quinta,
                sexta: dayOpen.sexta,
                sabado: dayOpen.sabado,
                domingo: dayOpen.domingo,
            })
        } else if (dia == 3) {
            setDay({
                segunda: dayOpen.segunda,
                terca: dayOpen.terca,
                quarta: dayOpen.quarta,
                quinta: !dayOpen.quinta,
                sexta: dayOpen.sexta,
                sabado: dayOpen.sabado,
                domingo: dayOpen.domingo,
            })
        } else if (dia == 4) {
            setDay({
                segunda: dayOpen.segunda,
                terca: dayOpen.terca,
                quarta: dayOpen.quarta,
                quinta: dayOpen.quinta,
                sexta: !dayOpen.sexta,
                sabado: dayOpen.sabado,
                domingo: dayOpen.domingo,
            })
        } else if (dia == 5) {
            setDay({
                segunda: dayOpen.segunda,
                terca: dayOpen.terca,
                quarta: dayOpen.quarta,
                quinta: dayOpen.quinta,
                sexta: dayOpen.sexta,
                sabado: !dayOpen.sabado,
                domingo: dayOpen.domingo,
            })
        } else {
            setDay({
                segunda: dayOpen.segunda,
                terca: dayOpen.terca,
                quarta: dayOpen.quarta,
                quinta: dayOpen.quinta,
                sexta: dayOpen.sexta,
                sabado: dayOpen.sabado,
                domingo: !dayOpen.domingo,
            })
        }
    }

    const verificaDia = (index) => {
        if(index == 0){
            return 'Segunda-Feira'
        } else if(index == 1){
            return 'Terça-Feira'
        } else if(index == 2){
            return 'Quarta-Feira'
        } else if(index == 3){
            return 'Quinta-Feira'
        } else if(index == 4){
            return 'Sexta-Feira'
        } else if(index == 5){
            return 'Sábado'
        }
        return 'Domingo'
    }

    const funcSetDay = (dia, abre, fecha) => {
        setEditDay({
            dia: dia,
            abre, abre,
            fecha: fecha
        })
        handleShow()
    }

    const registerTime = () => {
        var tudoOk = true
        var objtHorario = {}
        const abtr = document.getElementById('inputAbre').value
        const fch = document.getElementById('inputFecha').value

        if(formataHorario(abtr) && formataHorario(fch)){
            objtHorario = {
                abre: abtr,
                fecha: fch,
                status: true
            }
        } else{
            tudoOk = false
        }
        if(!tudoOk){
            console.log('erro no input')
        } else {
            //console.log(objtHorario)
            var newData = updateSchedules(objtHorario)
            registerEditFirebase(newData)
        }
    }

    const updateSchedules = (objt) => {
        if(editDay.dia == 'Segunda-Feira'){
            var newSchedules = dataHorario
            console.log(`newSchedules antes: ${newSchedules}`)
            //console.log(`newSchedules[0].segunda antes: ${newSchedules[0].segunda.abre}`)
            newSchedules[0] = objt
            //console.log(`newSchedules[0].segunda depois: ${newSchedules[0].segunda.abre}`)
            //newSchedules[0].segunda.abre = objt.abre
            //newSchedules[0].segunda.fecha = objt.fecha
            //newSchedules[0].segunda.status = objt.status

            return newSchedules
        } else if(editDay.dia == 'Terça-Feira'){

        } else if(editDay.dia == 'Quarta-Feira'){
            
        } else if(editDay.dia == 'Quinta-Feira'){
            
        } else if(editDay.dia == 'Sexta-Feira'){
            
        } else if(editDay.dia == 'Sábado-Feira'){
            
        }
        return dataHorario
    }

    const registerEditFirebase = async (objtData) => {
        //console.log(`novos dados: ${objtData}`)
        const data = {
            segunda: objtData[0].status ? objtData[0] : {status: false},
            terca: objtData[1].status ? objtData[1] : {status: false},
            quarta: objtData[2].status ? objtData[2] : {status: false},
            quinta: objtData[3].status ? objtData[3] : {status: false},
            sexta: objtData[4].status ? objtData[4] : {status: false},
            sabado: objtData[5].status ? objtData[5] : {status: false},
            domingo: objtData[6].status ? objtData[6] : {status: false}
        };
        objtData.forEach((item, index) => {
            console.log(`dia: ${index} - item: ${item.status}`)
        })
        try{
            
            const docRef = doc(db, `loja/configuracoes/horarios`, 'horarios');
            await updateDoc(docRef, data);
            console.log('horário atualizado com sucesso!')
        } catch (error){
            console.error('Erro ao adicionar dado:', error);
        }
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
                                    {
                                        dataHorario.map((day, index) => (
                                            <tr key={index}>
                                                <td className={styles.tdStatus} style={day.status ? {color: 'rgb(47, 218, 0)'} : {color: 'red'}}>{day.status ? `Aberto` : `Fechado`}</td>
                                                <td>{verificaDia(index)}</td>
                                                <td>{day.status ? `${day.abre} - ${day.fecha}` : `---`}</td>
                                                <td className={styles.buttonDetails} onClick={() => funcSetDay(verificaDia(index), day.status ? day.abre : 'null', day.status ? day.fecha : 'null')}>
                                                    <span class="material-symbols-outlined">edit</span>
                                                </td>
                                            </tr>
                                        ))
                                    }
                                </tbody>
                            </table>
                            <div className={styles.opa}>
                                <div className={styles.buttonLock}>
                                    <p>Fechar o aplicativo momentaneamente</p>
                                    <span class="material-symbols-outlined">lock</span>
                                </div>
                            </div>
                            <Modal show={show} onHide={handleClose}>
                                <Modal.Header closeButton>
                                    <Modal.Title>Editar Horarios</Modal.Title>
                                </Modal.Header>
                                <Modal.Body>
                                    <p>{editDay.dia}</p>
                                    <Form>
                                        <Row className="mb-3">
                                            <Form.Group as={Col} controlId="inputAbre">
                                                <Form.Label>Abre às:</Form.Label>
                                                <Form.Control
                                                    type="text"
                                                    placeholder="18:00"
                                                    autoFocus
                                                />
                                            </Form.Group>
                                            <Form.Group as={Col} controlId="inputFecha">
                                                <Form.Label>Fecha às:</Form.Label>
                                                <Form.Control
                                                    type="text"
                                                    placeholder="23:00"
                                                    autoFocus
                                                />
                                            </Form.Group>
                                        </Row>
                                    
                                    </Form>
                                </Modal.Body>
                                <Modal.Footer>
                                <Button variant="secondary" onClick={handleClose}>
                                    Close
                                </Button>
                                <Button variant="primary" onClick={registerTime}>
                                    Salvar
                                </Button>
                                </Modal.Footer>
                            </Modal>
                        </>
                        :
                        <>
                            <table className={styles.tableForm}>
                                <thead>
                                    <tr>
                                        <th colspan="2"></th>
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
                                        <th rowspan="2" scope="rowgroup">Horários</th>
                                        <th scope="row">Abre às</th>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrSegunda" disabled={!dayOpen.segunda} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrTerca"  disabled={!dayOpen.terca} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrQuarta" disabled={!dayOpen.quarta} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrQuinta" disabled={!dayOpen.quinta} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrSexta" disabled={!dayOpen.sexta} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrSabado" disabled={!dayOpen.sabado} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="abtrDomingo" disabled={!dayOpen.domingo} placeholder="ex: 18:00"></input>
                                            </form>
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <th scope="row">Fecha às</th>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchSegunda" disabled={!dayOpen.segunda} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchTerca" disabled={!dayOpen.terca} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchQuarta" disabled={!dayOpen.quarta} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchQuinta" disabled={!dayOpen.quinta} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchSexta" disabled={!dayOpen.sexta} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchSabado" disabled={!dayOpen.sabado} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                        <td className={styles.tdInput}>
                                            <form>
                                                <input type="text" id="fchDomingo" disabled={!dayOpen.domingo} placeholder="ex: 23:00"></input>
                                            </form>
                                        </td>
                                    </tr>
                                    <tr className={styles.rowCheck}>
                                        <th colspan="2" scope="row">Abrir</th>
                                        <td><span id="segunda" class="material-symbols-outlined" onClick={() => opCheckBox(0)}>{dayOpen.segunda ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                        <td><span id="terca" class="material-symbols-outlined" onClick={() => opCheckBox(1)}>{dayOpen.terca ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                        <td><span id="quarta" class="material-symbols-outlined" onClick={() => opCheckBox(2)}>{dayOpen.quarta ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                        <td><span id="quinta" class="material-symbols-outlined" onClick={() => opCheckBox(3)}>{dayOpen.quinta ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                        <td><span id="sexta" class="material-symbols-outlined" onClick={() => opCheckBox(4)}>{dayOpen.sexta ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                        <td><span id="sabado" class="material-symbols-outlined" onClick={() => opCheckBox(5)}>{dayOpen.sabado ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                        <td><span id="domingo" class="material-symbols-outlined" onClick={() => opCheckBox(6)}>{dayOpen.domingo ? 'check_box' : 'check_box_outline_blank'}</span></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div className={styles.opa}>
                                <div className={styles.buttonLock} onClick={registerTime2}>
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


/*
{
                                        dataHorario.map((day, index) => (
                                            <tr key={index}>
                                                <td className={styles.tdStatus}>Aberto</td>
                                                <td>Segunda-Feira</td>
                                                <td>18:00 - 23:00</td>
                                                <td className={styles.buttonDetails}>
                                                    <span class="material-symbols-outlined">edit</span>
                                                </td>
                                            </tr>
                                        ))
                                    }

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




const registerTime = () => {
        var tudoOk = true
        var objtHorarios = []

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

        if(dayOpen.segunda){
            if(abtrSegunda && fchSegunda && formataHorario(abtrSegunda) && formataHorario(fchSegunda)){
                objtHorarios.push({
                    segunda: {
                        abre: abtrSegunda,
                        fecha: fchSegunda,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        } if(dayOpen.terca){
            if(abtrTerca && fchTerca && formataHorario(abtrTerca) && formataHorario(fchTerca)){
                objtHorarios.push({
                    terca: {
                        abre: abtrTerca,
                        fecha: fchTerca,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        } if(dayOpen.quarta){
            if(abtrQuarta && fchQuarta && formataHorario(abtrQuarta) && formataHorario(fchQuarta)){
                objtHorarios.push({
                    quarta: {
                        abre: abtrQuarta,
                        fecha: fchQuarta,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        } if(dayOpen.quinta){
            if(abtrQuinta && fchQuinta && formataHorario(abtrQuinta) && formataHorario(fchQuinta)){
                objtHorarios.push({
                    quita: {
                        abre: abtrQuinta,
                        fecha: fchQuinta,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        } if(dayOpen.sexta){
            if(abtrSexta && fchSexta && formataHorario(abtrSexta) && formataHorario(fchSexta)){
                objtHorarios.push({
                    sexta: {
                        abre: abtrSexta,
                        fecha: fchSexta,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        } if(dayOpen.sabado){
            if(abtrSabado && fchSabado && formataHorario(abtrSabado) && formataHorario(fchSabado)){
                objtHorarios.push({
                    sabado: {
                        abre: abtrSabado,
                        fecha: fchSabado,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        } if(dayOpen.domingo) {
            if(abtrDomingo && fchDomingo && formataHorario(abtrDomingo) && formataHorario(fchDomingo)){
                objtHorarios.push({
                    domingo: {
                        abre: abtrDomingo,
                        fecha: fchDomingo,
                        status: true
                    }
                })
            } else{
                tudoOk = false
            }
        }

        if(tudoOk){
            console.log('registrar no firebase')
            console.log(objtHorarios)
        }
        else{
            console.log('apresentar um notificação para preencher corretamente os horários de atendimento')
        }
    }
*/