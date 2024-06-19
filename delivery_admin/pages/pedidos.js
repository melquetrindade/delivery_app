import React, {useState, useEffect} from "react";
import { getDocs, collection, doc, deleteDoc} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';
import styles from '../styles/pedidos.module.css'

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

        setPedidos(newData)
    } catch(error){
        console.error('Erro ao adicionar dado:', error);
        //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
    }
  }

  useEffect(() => {
    carregaPedidos()
  }, []);

  if(pedidos.length != 0){
    pedidos.forEach((item) => {
        console.log(item)
    })
  }

  const showCarrinho = (idDropUp, idDropDown, idDiv) => {
    const arrowDropUp = document.getElementById(idDropUp);
    const arrowDropDown = document.getElementById(idDropDown);
    const divCarrinho = document.getElementById(idDiv);

    arrowDropUp.style.display = arrowDropUp.style.display === 'none' ? 'block' : 'none';
    arrowDropDown.style.display = arrowDropDown.style.display === 'none' ? 'block' : 'none';
    divCarrinho.style.display = arrowDropUp.style.display === 'none' ? 'none' : 'block';
  }

  const finalizeOrder = async (numPedido) => {
    console.log(`finalizar pedido: ${numPedido}`)
    try{
      await deleteDoc(doc(db, `loja/owner/pedidos`, numPedido));
      console.log('deletou')
      await carregaPedidos()
    } catch(error){
        console.error('Erro ao deletar o doc:', error);
        //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
    }
  }

  return(
      <main className={styles.main}>
          <div>
            <h1>Lista de pedidos ativos</h1>
            <div className={styles.containerPedidos}>
              {pedidos.map((pedido, index) => (
                <div key={index}>
                  <div className={styles.contDivider}>
                    <div>
                      <p>{pedido.numPedido}</p>
                      <p>{pedido.cliente}</p>
                      <p>{pedido.data}</p>
                    </div>
                    <span class="material-symbols-outlined" id={`arrowDropUp-${index}`} style={{display: 'none'}} onClick={() => showCarrinho(`arrowDropUp-${index}`, `arrowDropDown-${index}`, `carrinho-${index}`)}>arrow_drop_up</span>
                    <span className={`material-symbols-outlined ${styles.teste}`} id={`arrowDropDown-${index}`} onClick={() => showCarrinho(`arrowDropUp-${index}`, `arrowDropDown-${index}`, `carrinho-${index}`)}>arrow_drop_down</span>
                  </div>
                  <div className={styles.divCarrinho} id={`carrinho-${index}`}>
                    {pedido.carrinho.map((item, index) => (
                      <div key={index}>
                        <p>{item.produto.nome}</p>
                        <p>{`qtd: ${item.qtd}`}</p>
                      </div>
                    ))}
                  </div>
                  <div className={styles.divButton} onClick={() => finalizeOrder(pedido.numPedido)}><h5>Finalizar Pedido</h5></div>
                </div>
              ))}
            </div>
          </div>
      </main>
  );
}