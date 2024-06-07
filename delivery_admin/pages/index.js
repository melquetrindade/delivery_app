import React from "react";
import { auth } from '../utils/firebase/firebaseService';

export default function Home() {
  console.log(`uid: ${auth.currentUser.uid}`)
  return (
    <h1>Tela inicial</h1>
  );
}
