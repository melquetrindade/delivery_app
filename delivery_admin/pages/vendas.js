import React, {useState, useEffect} from "react";
import { getDocs, doc, collection} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';
import Table from 'react-bootstrap/Table';
import styles from '../styles/vendas.module.css'

export default function Vendas() {
    const [vendas, setVendas] = useState([])

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

    useEffect(() => {
        carregaVendas()
    }, []);
    
    if(vendas.length != 0){
        vendas.forEach((item) => {
            console.log(item.cliente)
        })
    }

    const detailsOrder = () => {
        console.log('detalhar pedido')
    }

    const calcPrice = (item, index) => {
        var total = 0
        console.log(`item: ${index}`)
        item.carrinho.forEach((itemCarrinho) => {
            console.log(`preço: ${itemCarrinho.produto.valor} - qtd: ${itemCarrinho.qtd}`)
            total += itemCarrinho.produto.valor * itemCarrinho.qtd
        })
        return total.toFixed(2).replace('.', ',');
    }

    return(
        <main className={styles.main}>
            <div>
                <div className={styles.contTitle}>
                    <h3>Tabela de Vendas</h3>
                    <span class="material-symbols-outlined">filter_list</span>
                </div>
                <table responsive="sm" className={styles.table}>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Cliente</th>
                            <th>Data</th>
                            <th>Forma de Pagamento</th>
                            <th>Total</th>
                            <th>Nº Pedido</th>
                        </tr>
                    </thead>
                    <tbody className={styles.tBody}>
                        {vendas.map((item, index) => (
                            <tr key={index}>
                                <td>{index + 1}</td>
                                <td>{item.cliente}</td>
                                <td>{item.data}</td>
                                <td>{item.formaPag}</td>
                                <td>{calcPrice(item, index)}</td>
                                <td>{item.numPedido}</td>
                                <td onClick={detailsOrder} className={styles.buttonDetails}>detalhar</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </main>
       
    );
}

/*
<tr>
        <td>1</td>
        <td>Table cell</td>
        <td>Table cell</td>
        <td>Table cell</td>
        <td>Table cell</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Table cell</td>
        <td>Table cell</td>
        <td>Table cell</td>
        <td>Table cell</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Table cell</td>
        <td>Table cell</td>
        <td>Table cell</td>
        <td>Table cell</td>
    </tr>
*/