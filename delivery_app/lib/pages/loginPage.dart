import 'package:flutter/material.dart';
import '../my_flutter_app_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String title;
  late String actionButton;
  late String toggleButton;
  late String loginWithGoogle;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(
      () {
        isLogin = acao;
        if (isLogin) {
          title = 'Bem Vindo';
          actionButton = 'Login';
          toggleButton = 'Ainda não tem conta? Cadastre-se agora!';
          loginWithGoogle = 'Login com o Google';
        } else {
          title = 'Crie sua conta';
          actionButton = 'Cadastrar';
          toggleButton = 'Voltar ao login';
          loginWithGoogle = 'Cadastre-se com o Google';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${title}',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o email corretamente!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: TextFormField(
                            controller: senha,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Senha'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe sua senha!';
                              } else if (value.length < 8) {
                                return 'Sua senha deve ter no mínimo 8 caracteres!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // Raio dos cantos
                                    side: BorderSide.none, // Remove a borda
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      '${actionButton}',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.shade50),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5),
                                    side: BorderSide.none,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    MyFlutterApp.google,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      '${loginWithGoogle}',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        TextButton(
                            onPressed: () => setFormAction(!isLogin),
                            child: Text(toggleButton))
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
