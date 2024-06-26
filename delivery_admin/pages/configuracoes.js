import React, {useState, useEffect} from "react";
import { getDocs, collection, getDoc, doc, setDoc, updateDoc, deleteDoc} from 'firebase/firestore';
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
    const [dataEndereco, setEndereco] = useState({
        cidade: '',
        bairro: '',
        rua: '',
        num: '',
        frete: ''
    })
    const [dataContato, setContato] = useState([])
    const [fechaApp, setFechaApp] = useState()
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
    const [inputTell, setTell] = useState('')

    // modal para os horários
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    // modal para os telefones
    const [show2, setShow2] = useState(false);
    const handleClose2 = () => setShow2(false);
    const handleShow2 = () => setShow2(true);

    const loadFechaApp = async () => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/close`, 'closeApp'));
            if(querySnapshot.data()){
                const snapData = querySnapshot.data()
                setFechaApp(snapData.fechar)
            }
            else{
                setFechaApp(false)
            }
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
        }
    }

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
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/endereco`, 'endereco'));
            if(querySnapshot.data()){
                const snapData = querySnapshot.data()
                setEndereco(snapData)
            }
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
        }
    }

    const loadContato = async () => {
        try{
            var newData = []
            const querySnapshot = await getDocs(collection(db, `loja/configuracoes/contato`));
            querySnapshot.forEach((doc) => {
                var docData = doc.data();
                newData.push(docData);
            })
            setContato(newData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    useEffect(() => {
        loadHorario()
        loadFechaApp()
        loadEndereco()
        loadContato()
        setLoading('ok')
    }, []);

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
            var newData = updateSchedules(objtHorario)
            registerEditFirebase(newData)
        }
        handleClose()
    }

    const updateSchedules = (objt) => {
        var newSchedules = dataHorario
        if(editDay.dia == 'Segunda-Feira'){
            newSchedules[0] = objt
            return newSchedules
        } else if(editDay.dia == 'Terça-Feira'){
            newSchedules[1] = objt
            return newSchedules
        } else if(editDay.dia == 'Quarta-Feira'){
            newSchedules[2] = objt
            return newSchedules
        } else if(editDay.dia == 'Quinta-Feira'){
            newSchedules[3] = objt
            return newSchedules
        } else if(editDay.dia == 'Sexta-Feira'){
            newSchedules[4] = objt
            return newSchedules
        } else if(editDay.dia == 'Sábado'){
            newSchedules[5] = objt
            return newSchedules
        }
        newSchedules[6] = objt
        return newSchedules
    }

    const registerEditFirebase = async (objtData) => {
        const data = {
            segunda: objtData[0],
            terca: objtData[1],
            quarta: objtData[2],
            quinta: objtData[3],
            sexta: objtData[4],
            sabado: objtData[5],
            domingo: objtData[6]
        };
        try{
            
            const docRef = doc(db, `loja/configuracoes/horarios`, 'horarios');
            await updateDoc(docRef, data);
            console.log('horário atualizado com sucesso!')
        } catch (error){
            console.error('Erro ao adicionar dado:', error);
        }
    }

    const deleteDayFirebase = async (objtData) => {
        const data = {
            segunda: objtData[0],
            terca: objtData[1],
            quarta: objtData[2],
            quinta: objtData[3],
            sexta: objtData[4],
            sabado: objtData[5],
            domingo: objtData[6]
        };
        try{
            
            const docRef = doc(db, `loja/configuracoes/horarios`, 'horarios');
            await updateDoc(docRef, data);
            console.log('horário atualizado com sucesso!')
        } catch (error){
            console.error('Erro ao adicionar dado:', error);
        }
    }

    const deleteDay = () => {
        if(editDay.abre != 'null' && editDay.fecha != 'null'){
            const objtTime = dataHorario
            if(editDay.dia == 'Segunda-Feira'){
                objtTime[0] = {status: false}
            } else if (editDay.dia == 'Terça-Feira'){
                objtTime[1] = {status: false}
            } else if (editDay.dia == 'Quarta-Feira'){
                objtTime[2] = {status: false}
            } else if (editDay.dia == 'Quinta-Feira'){
                objtTime[3] = {status: false}
            } else if (editDay.dia == 'Sexta-Feira'){
                objtTime[4] = {status: false}
            } else if (editDay.dia == 'Sábado'){
                objtTime[5] = {status: false}
            } else {
                objtTime[6] = {status: false}
            }
            deleteDayFirebase(objtTime)
            setHorario(objtTime)
        }
        handleClose()
    }

    const closeApp = async () => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/close`, 'closeApp'));
            if(querySnapshot.data()){
                const docRef = doc(db, `loja/configuracoes/close`, 'closeApp');
                await updateDoc(docRef, {
                    fechar: !fechaApp
                });
                setFechaApp(!fechaApp)
                console.log('deu certo o update')
            } else {
                const docRef = doc(db, `loja/configuracoes/close`, 'closeApp');
                await setDoc(docRef, {
                    fechar: !fechaApp
                });
                console.log('deu certo o set')
            }
        } catch(error) {
            console.error('Erro ao adicionar dado:', error);
        }
    }

    const saveAddress = () => {
        const inputCidade = document.getElementById('formGridCity').value
        const inputBairro = document.getElementById('formGridNeighborhood').value
        const inputRua = document.getElementById('formGridRoad').value
        const inputNum = document.getElementById('formGridNumber').value
        const inputFrete = document.getElementById('formGridFrete').value
        var objtEndereco = {}

        if(inputCidade && inputBairro && inputRua && inputNum && inputFrete){
            objtEndereco = {
                cidade: inputCidade,
                bairro: inputBairro,
                rua: inputRua,
                num: inputNum,
                frete: inputFrete
            }
            saveAddressFirebase(objtEndereco)
        }
    }

    const saveAddressFirebase = async (data) => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/endereco`, 'endereco'));
            if(querySnapshot.data()){
                const docRef = doc(db, `loja/configuracoes/endereco`, 'endereco');
                await updateDoc(docRef, data);
                setEndereco(data)
            } else {
                const docRef = doc(db, `loja/configuracoes/endereco`, 'endereco');
                await setDoc(docRef, data);
                setEndereco(data)
            }
        } catch(error) {
            console.error('Erro ao adicionar dado:', error);
        }
    }

    const handleInputCidade = (e) => {
        const inputText = e.target.value

        if (/^[a-zA-ZÀ-ÖØ-öø-ÿ 0-9 ']+$/.test(inputText) || inputText === '') {
            setEndereco({
                cidade: inputText,
                bairro: dataEndereco.bairro,
                rua: dataEndereco.rua,
                num: dataEndereco.num,
                frete: dataEndereco.frete,
            })
        }
    }

    const handleInputBairro = (e) => {
        const inputText = e.target.value

        if (/^[a-zA-ZÀ-ÖØ-öø-ÿ 0-9 ']+$/.test(inputText) || inputText === '') {
            setEndereco({
                cidade: dataEndereco.cidade,
                bairro: inputText,
                rua: dataEndereco.rua,
                num: dataEndereco.num,
                frete: dataEndereco.frete
            })
        }
    }

    const handleInputRua = (e) => {
        const inputText = e.target.value

        if (/^[a-zA-ZÀ-ÖØ-öø-ÿ 0-9 ']+$/.test(inputText) || inputText === '') {
            setEndereco({
                cidade: dataEndereco.cidade,
                bairro: dataEndereco.bairro,
                rua: inputText,
                num: dataEndereco.num,
                frete: dataEndereco.frete
            })
        }
    }

    const handleInputNum = (e) => {
        const inputText = e.target.value

        if (/^[a-zA-Z 0-9 ']+$/.test(inputText) || inputText === '') {
            setEndereco({
                cidade: dataEndereco.cidade,
                bairro: dataEndereco.bairro,
                rua: dataEndereco.rua,
                num: inputText,
                frete: dataEndereco.frete,
            })
        }
    }

    const handleInputFrete = (e) => {
        const inputText = e.target.value

        if (/^[0-9 , .']+$/.test(inputText) || inputText === '') {
            setEndereco({
                cidade: dataEndereco.cidade,
                bairro: dataEndereco.bairro,
                rua: dataEndereco.rua,
                num: dataEndereco.num,
                frete: inputText,
            })
        }
    }

    const handleInputTell = (e) => {
        const inputText = e.target.value

        if (/^[() . -- 0-9 ']+$/.test(inputText) || inputText === '') {
            setTell(inputText)
        }
    }

    const addTelefoneFirebase = async (tell, docTell) => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/configuracoes/contato`, `${docTell}`));
            
            if(querySnapshot.data()){
                console.log('este tell já foi cadastrado')
            } else {
                console.log('este tell não foi cadastrado')
                
                const docRef = doc(db, `loja/configuracoes/contato`, `${docTell}`);
                await setDoc(docRef, {
                    telefone: tell
                });
                var newDataContato = dataContato
                newDataContato.push({
                    telefone: tell
                })
                setContato(newDataContato)
                setTell('')
            }
        } catch(error) {
            console.error('Erro ao adicionar dado:', error);
        }
    }

    const addTelefone = () => {
        const tellFormatado = inputTell.replace(/\D/g, '');
        if(tellFormatado.length == 11){
            addTelefoneFirebase(inputTell, tellFormatado)
        } else {
            console.log('o tell não tem 11 dígitos')
        }
        handleClose2()
    }

    const removeTeleone = async (telefone) => {
        const tellFormatado = telefone.replace(/\D/g, '');
        try{
            await deleteDoc(doc(db, `loja/configuracoes/contato`, tellFormatado));
            const newLista = dataContato.filter(item => item.telefone !== telefone);
            setContato(newLista)
            console.log('deletou')
        } catch(error){
            console.error('Erro ao deletar o doc:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    return(
        <main className={styles.main}>
            {
                loading == 'load'
                ?
                <Load/>
                :
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
                                    <div className={styles.buttonLock} onClick={closeApp}>
                                        <p>{fechaApp ? 'Reabrir o aplicativo' : 'Fechar o aplicativo momentaneamente'}</p>
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
                                    <Button variant="secondary" onClick={deleteDay}>
                                        Fechar este dia
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
                                        <Form.Control type="text" placeholder="ex: Rio de Janeiro" value={dataEndereco.cidade} onChange={handleInputCidade}/>
                                    </Form.Group>
        
                                    <Form.Group as={Col} controlId="formGridNeighborhood" >
                                        <Form.Label>Bairro</Form.Label>
                                        <Form.Control type="text" placeholder="ex: Centro" value={dataEndereco.bairro} onChange={handleInputBairro}/>
                                    </Form.Group>
                                </Row>
        
                                <Row className="mb-3">
                                    <Col xs={7}>
                                        <Form.Group as={Col} controlId="formGridRoad">
                                            <Form.Label>Rua</Form.Label>
                                            <Form.Control placeholder="ex: 7 de Setembro" value={dataEndereco.rua} onChange={handleInputRua}/>
                                        </Form.Group>
                                    </Col>
            
                                    <Col>
                                        <Form.Group as={Col} controlId="formGridNumber">
                                            <Form.Label>Nº</Form.Label>
                                            <Form.Control placeholder="ex: 311" value={dataEndereco.num} onChange={handleInputNum}/>
                                        </Form.Group>
                                    </Col>

                                    <Col>
                                        <Form.Group as={Col} controlId="formGridFrete">
                                            <Form.Label>Frete</Form.Label>
                                            <Form.Control placeholder="ex: 5,00" value={dataEndereco.frete} onChange={handleInputFrete}/>
                                        </Form.Group>
                                    </Col>
                                </Row>
        
                                <Button variant="primary" onClick={saveAddress}>
                                    Salvar
                                </Button>
                            </Form>
                        </div>
                    </div>
                    <div className={styles.sessaoContato} styles={{marginBottom: '5%'}}>
                        <h1 className={styles.title}>Contato</h1>
                        <hr style={{marginBottom: '3%'}}></hr>
                        {
                            dataContato.length != 0
                            ?
                                <>
                                    <table responsive="sm" className={styles.tableContato}>
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Telefone</th>
                                            </tr>
                                            </thead>
                                        <tbody>
                                            {dataContato.map((item, index) => (
                                                <tr key={index}>
                                                    <td>{index + 1}</td>
                                                    <td>{item.telefone}</td>
                                                    <td className={styles.buttonDelete} onClick={() => removeTeleone(item.telefone)}>
                                                        <span class="material-symbols-outlined">delete</span>
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                    <div className={styles.opa}>
                                        <div className={styles.buttonLock} onClick={handleShow2}>
                                            <p>Adicionar Telefone</p>
                                            <span class="material-symbols-outlined">add_call</span>
                                        </div>
                                    </div>
                                </>
                            :
                            <div className={styles.divAddTell}>
                                <h1>Ainda não tem telefones cadastrados. Adicione agora!</h1>
                                <div className={styles.opa}>
                                    <div className={styles.buttonLock} onClick={handleShow2}>
                                        <p>Adicionar Telefone</p>
                                        <span class="material-symbols-outlined">add_call</span>
                                    </div>
                                </div>
                            </div>
                        }
                        <>
                            <Modal show={show2} onHide={handleClose2}>
                                <Modal.Header closeButton>
                                    <Modal.Title>Adicione um novo Telefone</Modal.Title>
                                </Modal.Header>
                                <Modal.Body>
                                    <Form>
                                        <Form.Group className="mb-3" controlId="telefone">
                                        <Form.Label>Telefone</Form.Label>
                                        <Form.Control
                                            type="text"
                                            placeholder="(XX) X.XXXX-XXXX"
                                            autoFocus
                                            value={inputTell}
                                            onChange={handleInputTell}
                                        />
                                        </Form.Group>
                                    </Form>
                                </Modal.Body>
                                <Modal.Footer>
                                    <Button variant="primary" onClick={addTelefone}>
                                        Salvar
                                    </Button>
                                </Modal.Footer>
                            </Modal>
                        </>
                    </div>
                </div>
            }
        </main>
    );
}

function Load(){
    return(
        <div className={styles.fade}>
            <div class="spinner-border text-info" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
    )
  }