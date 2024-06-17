import React, {useState, useEffect} from "react";
import { getDocs, collection} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';
import styles from '../styles/vendas.module.css'
import DropdownButton from 'react-bootstrap/DropdownButton';
import Dropdown from 'react-bootstrap/Dropdown';
import { useRouter } from 'next/router'

export default function Vendas() {
    const router = useRouter()
    const [vendas, setVendas] = useState([])

    const carregaVendas = async () => {
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
        carregaVendas()
    }, []);

    const detailsOrder = (idVenda) => {
        router.push({
            pathname: './detailsVenda',
            query: {docId: idVenda}
        })
    }

    const calcPrice = (item) => {
        var total = 0
        
        item.carrinho.forEach((itemCarrinho) => {
            total += itemCarrinho.produto.valor * itemCarrinho.qtd
        })
        return total.toFixed(2).replace('.', ',');
    }

    const filterSales = (op) => {
        if(op == 1){
            ordenerMaisEMenos('mais')
        } else if(op == 2){
            ordenerMaisEMenos('menos')
        } else if(op == 3){
            ordenarMaiorEMenor('maior')
        } else {
            ordenarMaiorEMenor('menor')
        }
    }

    function parseDate(dateStr) {
        const [datePart, timePart] = dateStr.split(' - '); // Dividir a string da data e da hora
        const [day, month, year] = datePart.split('/').map(Number); // Dividir a parte da data em dia, mês e ano
        const [hours, minutes, seconds] = timePart.split(':').map(Number); // Dividir a parte do tempo em horas, minutos e segundos
        return new Date(year, month - 1, day, hours, minutes, seconds); // Criar e retornar um objeto Date
    }
    
    const ordenerMaisEMenos = (criterio) => {
        var newList = []
        var auxList = []
        newList = vendas.sort(function(a, b) {
            const date1 = parseDate(a.data);
            const date2 = parseDate(b.data);
        
            if (date1 > date2) {
                if(criterio == 'menos'){
                    return 1
                }
                return -1;
            } else if(date1 < date2) {
                if(criterio == 'menos'){
                    return -1
                }
                return 1;
            } else{
                return 0
            }
        })
        newList.forEach((item) => {
            auxList.push(item)
        })
        setVendas(auxList)
    }
    

    const ordenarMaiorEMenor = (criterio) => {
        var newList = []
        var auxList = []
        newList = vendas.sort(function(a, b) {
            var totalA = 0
            var totalB = 0
            
            a.carrinho.forEach((item) => {
                totalA += item.produto.valor * item.qtd
            })
            b.carrinho.forEach((item) => {
                totalB += item.produto.valor * item.qtd
            })
            // Retorna verdadeiro se 'a' deve vir antes de 'b'
            if (totalA > totalB) {
                if(criterio == 'menor'){
                    return 1
                }
                return -1;
            }
            // Retorna falso se 'a' deve vir depois de 'b'
            else if (totalA < totalB) {
                if(criterio == 'menor'){
                    return -1
                }
                return 1;
            } else {
                return 0;
            }
        });
        newList.forEach((item) => {
            auxList.push(item)
        })
        setVendas(auxList)
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
                                <td>{calcPrice(item)}</td>
                                <td>{item.numPedido}</td>
                                <td onClick={() => detailsOrder(item.id)} className={styles.buttonDetails}>detalhar</td>
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