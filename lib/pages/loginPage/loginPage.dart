import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/pages/controllerPage/controllerPage.dart';
import 'package:movies/pages/loginPage/login_page_bloc.dart';
import 'package:movies/utils/components/loginBotao_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customSharedPreferences.dart';
import 'package:movies/utils/helpers.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = LoginBloc();

  final _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/utils/assets/images/login_bg.png'),
            ),
          ),
          child: Form(
            key: _formKey,
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: height * 0.1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        onSaved: (value) {
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
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        onSaved: (value) {
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
                  SizedBox(height: height * 0.15),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        if (Helpers.validateEmail(_emailController.text) &&
                            Helpers.validatePassword(_senhaController.text)) {
                          CustomSharedPreferences.saveUsuario(true);
                          Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => ControllerPage(),
                              ),
                              (route) => false);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Campos inválidos",
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                    "Campos de e-mail ou senha inválidos ou incorretos! Insira-os novamente."),
                                actions: [
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            },
                          );
                        }
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
        ),
      ),
    );
  }
}

/*

*/
