import React, {useState} from "react";
import { getDocs, doc, collection} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';

export default function Vendas() {
    const [vendas, setVendas] = useState([])
    const [pedidos, setPedidos] = useState([])

    const carregaVendas = async () => {
        try{
            var newData = []

            const querySnapshot = await getDocs(collection(db, `loja/owner/vendas`));
            querySnapshot.forEach((doc) => {
                var docData = doc.data();
                //console.log(docData)
                newData.push(docData);
            })

            setVendas(newData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    const carregaPedidos = async () => {
        try{
            var newData = []

            const querySnapshot = await getDocs(collection(db, `loja/owner/pedidos`));
            querySnapshot.forEach((doc) => {
                var docData = doc.data();
                //console.log(docData)
                newData.push(docData);
            })

            setVendas(newData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }
    
    if(vendas.length != 0){
        vendas.forEach((item) => {
            console.log(item)
        })
    }
    if(pedidos.length != 0){
        vendas.forEach((item) => {
            console.log(item)
        })
    }

    return(
        <main>
            <h1>Pág de vendas</h1>
            <button onClick={carregaVendas}>Carregar Vendas</button>
            <button onClick={carregaPedidos}>Carregar Pedidos</button>
        </main>
       
    );
}