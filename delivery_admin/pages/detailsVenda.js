import React, {useState, useEffect} from "react";
import { useRouter } from 'next/router'
import { getDoc, doc} from 'firebase/firestore';
import { db } from '../utils/firebase/firebaseService';
import styles from '../styles/detailsVenda.module.css'

export default function DetailsVenda(){
    const router = useRouter()
    const {docId} = router.query
    const [venda, setVenda] = useState({})

    useEffect(() => {
        carregaVenda()
    }, []);

    const carregaVenda = async () => {
        try{
            const querySnapshot = await getDoc(doc(db, `loja/owner/vendas`, docId));
            const snapData = querySnapshot.data()

            setVenda(snapData)
        } catch(error){
            console.error('Erro ao adicionar dado:', error);
            //openNotification({placement: 'topRight', title: 'ERRO', descricao: 'NÃO FOI POSSÍVEL CONTINUAR, TENTE NOVAMENTE!'})
        }
    }

    if(venda){
        console.log(venda)
    }

    return(
        <main className={styles.main}>
            <div className={styles.divContent}>
                <h1>Detalhes do Pedido</h1>
                <div className={styles.divConteudo}>
                    <div className={styles.divSessao}>
                        <h5>Cliente</h5>
                        <h6>Melque Rodrigues</h6>
                    </div>
                    <div className={styles.divSessao}>
                        <h5>Data</h5>
                        <h6>12/06/2024 - 10:33:20</h6>
                    </div>
                    <div className={styles.divSessao}>
                        <h5>Forma de Pagamento</h5>
                        <h6>Pix</h6>
                    </div>
                    <div className={styles.divSessao}>
                        <h5>Carrinho</h5>
                        <div className={styles.contCarrinho}>
                            <div className={styles.textLeft}>
                                <h5>produto 1</h5>
                                <h6>{`qtd: ${docId}`}</h6>
                            </div>
                            <div className={styles.textRigth}>
                                <h5>Valor Unitário: R$6,00</h5>
                                <h6>SubTotal: R$18,00</h6>
                            </div>
                        </div>
                        <div className={styles.contCarrinho}>
                            <div className={styles.textLeft}>
                                <h5>produto 1</h5>
                                <h6>{`qtd: ${docId}`}</h6>
                            </div>
                            <div className={styles.textRigth}>
                                <h5>Valor Unitário: R$6,00</h5>
                                <h6>SubTotal: R$18,00</h6>
                            </div>
                        </div>
                    </div>
                    <div className={styles.divTotal}>
                        <div>
                            <h5>TOTAL:</h5>
                            <h6>R$ 20,00</h6>
                        </div>
                    </div>
                </div>
            </div>
        </main>
       
    )
}