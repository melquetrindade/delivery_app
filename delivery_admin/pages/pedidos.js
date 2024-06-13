import React from "react";
import { messaging } from '../utils/firebase/firebaseService';

export default function Pedidos() {
    const sendPushNotification = async () => {
        
        const notificationPayload = {
            to: 'cp-KxxNlQNeReDkDuc8XiK:APA91bF7kic65Z2Jg-wTCt4ywFpZY4VTCDrUXjTNb3_xyrHAOUBMSeJJogmCTaemzVgHpi7-s0mlnz16bkCbqVnOzxin1cR-MRv0w7CY9vG00K0uE-4flLU3G3H2D_xdcEusXBBXq_bA', // Substitua pelo token real do dispositivo
            notification: {
              title: 'Título da Minha Notificação Push',
              body: 'Corpo da Minha Notificação Push',
            },
        };
      
        messaging.send(notificationPayload).then((response) => {
            console.log('Notificação enviada com sucesso:', response);
          }).catch((error) => {
            console.error('Erro ao enviar notificação:', error);
          });
      }
      
    // Exemplo de uso
    const deviceToken = "cp-KxxNlQNeReDkDuc8XiK:APA91bF7kic65Z2Jg-wTCt4ywFpZY4VTCDrUXjTNb3_xyrHAOUBMSeJJogmCTaemzVgHpi7-s0mlnz16bkCbqVnOzxin1cR-MRv0w7CY9vG00K0uE-4flLU3G3H2D_xdcEusXBBXq_bA";
    //sendPushNotification(deviceToken);

    return(
        <main>
            <h1>Pág de pedidos</h1>
            <button onClick={sendPushNotification}>enviar mensagem</button>
        </main>
    );
}