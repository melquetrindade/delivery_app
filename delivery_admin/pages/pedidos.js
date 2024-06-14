import React, {useState, useEffect} from "react";
import { getDocs, collection} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';

export default function Pedidos() {
  const [pedidos, setPedidos] = useState([])

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

    useEffect(() => {
      carregaPedidos()
    }, []);

    if(pedidos.length != 0){
      vendas.forEach((item) => {
          console.log(item)
    })
  }

    return(
        <main>
            <h1>Pág de pedidos</h1>
        </main>
    );
}