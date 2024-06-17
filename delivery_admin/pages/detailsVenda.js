import React, {useState, useEffect} from "react";
import { useRouter } from 'next/router'
import { getDoc, doc} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';
import styles from '../styles/detailsVenda.module.css'

export default function DetailsVenda(){
    const router = useRouter()
    const {docId} = router.query
    const [venda, setVenda] = useState({})
    const [loading, setLoading] = useState('load')

    useEffect(() => {
        carregaVenda()
    }, []);

    const carregaVenda = async () => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/owner/vendas`, docId));
            const snapData = querySnapshot.data()

            setVenda(snapData)
            setLoading('ok')
        } catch(error){
            setLoading('erro')
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    if(venda){
        console.log(venda)
    }

    const formatPrice = (price) => {
        var format = price
        return format.toFixed(2).replace('.', ',');
    }

    const calcPrice = (item) => {
        var total = 0
        total += item.produto.valor * item.qtd
        return total.toFixed(2).replace('.', ',');
    }

    const calcTotal = (carrinho) => {
        var total = 0
        carrinho.forEach((item) => {
            total += item.produto.valor * item.qtd
        })
        return total.toFixed(2).replace('.', ',');
    }

    return(
        <main className={styles.main}>
            {
                loading == 'load'
                ?
                <Load/>
                :
                loading == 'erro'
                ?
                <Error/>
                :
                <div className={styles.divContent}>
                    <h1>Detalhes do Pedido</h1>
                    <div className={styles.divConteudo}>
                        <div className={styles.divSessao}>
                            <h5>Cliente</h5>
                            <h6>{`${venda.cliente}`}</h6>
                        </div>
                        <div className={styles.divSessao}>
                            <h5>Data</h5>
                            <h6>{`${venda.data}`}</h6>
                        </div>
                        <div className={styles.divSessao}>
                            <h5>Forma de Pagamento</h5>
                            <h6>{`${venda.formaPag}`}</h6>
                        </div>
                        <div className={styles.divSessao}>
                            <h5>Carrinho</h5>
                            {venda.carrinho.map((item, index) => (
                                <div className={styles.contCarrinho}>
                                    <div className={styles.textLeft}>
                                        <h5>{item.produto.nome}</h5>
                                        <h6>{`qtd: ${item.qtd}`}</h6>
                                    </div>
                                    <div className={styles.textRigth}>
                                        <h5>{`Valor Unitário: R$${formatPrice(item.produto.valor)}`}</h5>
                                        <h6>{`SubTotal: R$${calcPrice(item)}`}</h6>
                                    </div>
                                </div>
                            ))}
                        </div>
                        <div className={styles.divTotal}>
                            <div>
                                <h5>TOTAL:</h5>
                                <h6>{`R$ ${calcTotal(venda.carrinho)}`}</h6>
                            </div>
                        </div>
                    </div>
                </div>
            }
            
        </main>
       
    )
}

function Error(){
    return(
        <h1>Error</h1>
    )
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