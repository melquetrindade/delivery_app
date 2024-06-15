import React, {useState, useEffect} from "react";
import { getDocs, doc, collection} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';
import Table from 'react-bootstrap/Table';
import styles from '../styles/vendas.module.css'
import Button from 'react-bootstrap/Button';
import DropdownButton from 'react-bootstrap/DropdownButton';
import Dropdown from 'react-bootstrap/Dropdown';

export default function Vendas() {
    const [vendas, setVendas] = useState([])
    console.log('atualizou a página')
    console.log(vendas)

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

    /*
    if(vendas.length != 0){
        vendas.forEach((item) => {
            console.log(item.cliente)
        })
    }*/

    const detailsOrder = () => {
        console.log('detalhar pedido')
    }

    const calcPrice = (item, index) => {
        var total = 0
        //console.log(`item: ${index}`)
        item.carrinho.forEach((itemCarrinho) => {
            //console.log(`preço: ${itemCarrinho.produto.valor} - qtd: ${itemCarrinho.qtd}`)
            total += itemCarrinho.produto.valor * itemCarrinho.qtd
        })
        return total.toFixed(2).replace('.', ',');
    }

    const filterSales = (op) => {
        if(op == 1){
            console.log('mais recente')
        } else if(op == 2){
            console.log('menos recente')
        } else if(op == 3){
            console.log('maior valor')
            ordenarNumeros()
        } else {
            console.log('menor valor')
        }
    }

    const ordenarNumeros = () => {
        var newList = []
        var testeList = []
        newList = vendas.sort(function(a, b) {
            var totalA = 0
            var totalB = 0
            
            a.carrinho.forEach((item) => {
                totalA += item.produto.valor * item.qtd
            })
            b.carrinho.forEach((item) => {
                totalB += item.produto.valor * item.qtd
            })
            console.log(`total a: ${totalA}`)
            console.log(`total b: ${totalB}`)
            // Retorna verdadeiro se 'a' deve vir antes de 'b'
            if (totalA > totalB) {
                console.log('entrou no if')
                return -1;
            }
            // Retorna falso se 'a' deve vir depois de 'b'
            else if (totalA < totalB) {
                console.log('entrou no elseif')
                return 1;
            } else {
                console.log('entrou no else')
                return 0;
            }
        });
        newList.forEach((item) => {
            testeList.push(item)
        })
        setVendas(testeList)
    }

    return(
        <main className={styles.main}>
            <div>
                <div className={styles.contTitle}>
                    <h3>Tabela de Vendas</h3>
                        <DropdownButton title="Filter" id="bg-nested-dropdown">
                            <Dropdown.Item eventKey="1" onClick={() => filterSales(1)}>Mais Recente</Dropdown.Item>
                            <Dropdown.Item eventKey="2" onClick={() => filterSales(2)}>Menos Recente</Dropdown.Item>
                            <Dropdown.Item eventKey="3" onClick={() => filterSales(3)}>Maior Valor</Dropdown.Item>
                            <Dropdown.Item eventKey="4" onClick={() => filterSales(4)}>Menor Valor</Dropdown.Item>
                        </DropdownButton>
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