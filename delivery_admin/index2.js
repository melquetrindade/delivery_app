//var admin = require("firebase-admin");
import {initializeApp, applicationDefault} from "firebase-admin/app"
import {getMessaging} from 'firebase-admin/messaging'
import express, {json} from "express"

process.env.GOOGLE_APPLICATION_CREDENTIALS

const app = express();
app.use(express.json())

app.use(
    cors({
      origin: "*",
    })
);
  
app.use(
    cors({
        methods: ["GET", "POST", "DELETE", "UPDATE", "PUT", "PATCH"],
    })
);

app.use(function(req, res, next) {
    res.setHeader("Content-Type", "application/json");
    next();
});

initializeApp({
    credential: applicationDefault(),
    projectId: 'delivery-app-12b3e'
})

app.post("/send", function (req, res) {
    const receivedToken = req.body.fcmToken;
    
    const message = {
      notification: {
        title: "Notif",
        body: 'This is a Test Notification'
      },
      token: "cp-KxxNlQNeReDkDuc8XiK:APA91bF7kic65Z2Jg-wTCt4ywFpZY4VTCDrUXjTNb3_xyrHAOUBMSeJJogmCTaemzVgHpi7-s0mlnz16bkCbqVnOzxin1cR-MRv0w7CY9vG00K0uE-4flLU3G3H2D_xdcEusXBBXq_bA",
    };
    
    getMessaging()
      .send(message)
      .then((response) => {
        res.status(200).json({
          message: "Successfully sent message",
          token: receivedToken,
        });
        console.log("Successfully sent message:", response);
      })
      .catch((error) => {
        res.status(400);
        res.send(error);
        console.log("Error sending message:", error);
      });
    
    
});

app.listen(3000, function(){
    console.log("server started on port 3000")
})

/*
var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});*/


