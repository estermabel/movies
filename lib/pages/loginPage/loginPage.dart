import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/pages/controllerPage/controllerPage.dart';
import 'package:movies/pages/loginPage/login_page_bloc.dart';
import 'package:movies/utils/components/loginBotao_item.dart';
import 'package:movies/utils/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = LoginBloc();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: SALMON,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
              color: DARK_BLUE,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 100, 10, 30),
              child: Column(
                children: [
                  Text(
                    "Movies",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 80,
                      color: SALMON,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 150, 20, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Preencha o campo!";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _emailController.text = value;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          border: InputBorder.none,
                          labelText: "E-mail",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: BLUE,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Preencha o campo!";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _senhaController.text = value;
                        },
                        controller: _senhaController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          border: InputBorder.none,
                          labelText: "Senha",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: BLUE,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: LIGHT_BLUE,
                            ),
                          ),
                        ),
                        obscureText: _showPassword,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 170, 20, 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (context) => ControllerPage(),
                            ),
                            (route) => false);
                      },
                      child: LoginBotao(
                        title: "LOGIN",
                        botaoColor: BLUE,
                        textColor: SALMON,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
