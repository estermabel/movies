import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:movies/pages/controllerPage/controllerPage.dart';
import 'package:movies/pages/loginPage/login_page_bloc.dart';
import 'package:movies/pages/onBoardingPage/onboarding_page.dart';
import 'package:movies/utils/components/loginBotao_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customSharedPreferences.dart';
import 'package:movies/utils/helpers.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = LoginBloc();

  final LocalAuthentication auth = LocalAuthentication();

  final _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();
    bloc.getUsuarioBiometria();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    return canCheckBiometrics;
  }

  Future<bool> authenticateUser() async {
    bool authorized;
    try {
      authorized = await auth.authenticateWithBiometrics(
        localizedReason: "por favor toque no sensor para se autenticar",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print("esse erro é: $e");
    }
    return authorized;
  }

  _fazerLogin() async {
    if (Helpers.validateEmail(_emailController.text) &&
        Helpers.validatePassword(_senhaController.text)) {
      await _checkBiometrics().then((value) {
        if (value) {
          _showModal();
        } else {
          CustomSharedPreferences.saveUsuario(true);
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => ControllerPage(),
              ),
              (route) => false);
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          var text = Helpers.loginAlertDialogMessage(
              _emailController, _senhaController);

          return AlertDialog(
            title: Text(
              "Campos inválidos",
              textAlign: TextAlign.center,
            ),
            content: Text(text),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  _showModal() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Text(
                      "Deseja fazer login com biometria?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: DARK_BLUE,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: DARK_BLUE,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.check_circle,
                      color: Colors.green[900],
                    ),
                    title: new Text(
                      'Sim',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: DARK_BLUE,
                      ),
                    ),
                    onTap: () async {
                      await authenticateUser().then((value) async {
                        if (value) {
                          await CustomSharedPreferences.saveUsuarioBiometria(
                              true);
                          await CustomSharedPreferences.saveUsuario(true);

                          await CustomSharedPreferences.readUsuarioOnBoarding()
                              .then((value) async {
                            debugPrint(value.toString());
                            if (value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                    builder: (context) => ControllerPage(),
                                  ),
                                  (route) => false);
                            } else {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                    builder: (context) => OnBoardingPage(),
                                  ),
                                  (route) => false);
                            }
                          });
                        } else {
                          debugPrint("algo de errado aconteceu!");
                        }
                      });
                    }),
                ListTile(
                  leading: new Icon(
                    Icons.cancel_rounded,
                    color: Colors.red[900],
                  ),
                  title: new Text(
                    'Não',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: DARK_BLUE,
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await CustomSharedPreferences.saveUsuarioBiometria(false);
                    await CustomSharedPreferences.saveUsuario(true);
                    await CustomSharedPreferences.readUsuarioOnBoarding()
                        .then((value) async {
                      if (value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (context) => ControllerPage(),
                            ),
                            (route) => false);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                              builder: (context) => OnBoardingPage(),
                            ),
                            (route) => false);
                      }
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

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
                  StreamBuilder<bool>(
                      stream: bloc.loginStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data) {
                            return Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.5),
                                  highlightColor: Colors.white,
                                  direction: ShimmerDirection.ltr,
                                  period: Duration(seconds: 2),
                                  child: Column(
                                    children: [
                                      SizedBox(height: height * 0.07),
                                      Icon(
                                        Icons.fingerprint_rounded,
                                        size: 150,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      Text(
                                        "Faça login usando\na biometria",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.06),
                                FlatButton(
                                  onPressed: () async {
                                    bloc.loginSink.add(false);
                                    await CustomSharedPreferences
                                        .saveUsuarioBiometria(false);
                                  },
                                  child: Text(
                                    "Acessar com e-mail e senha?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.08),
                              ],
                            );
                          } else {
                            return loginUI();
                          }
                        } else {
                          return loginUI();
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () async {
                        await CustomSharedPreferences.readUsuarioBiometria()
                            .then((value) async {
                          if (value) {
                            await authenticateUser().then((value) async {
                              if (value) {
                                await CustomSharedPreferences
                                    .saveUsuarioBiometria(true);
                                await CustomSharedPreferences.saveUsuario(true);

                                await CustomSharedPreferences
                                        .readUsuarioOnBoarding()
                                    .then((value) async {
                                  debugPrint(value.toString());
                                  if (value) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              ControllerPage(),
                                        ),
                                        (route) => false);
                                  } else {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              OnBoardingPage(),
                                        ),
                                        (route) => false);
                                  }
                                });
                              } else {
                                debugPrint("algo de errado aconteceu!");
                              }
                            });
                          } else {
                            await _fazerLogin();
                          }
                        });
                      },
                      child: LoginBotao(
                        title: "LOGIN",
                        botaoColor: BLUE,
                        textColor: Colors.white.withOpacity(0.9),
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

  Column loginUI() {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
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
      ],
    );
  }
}
