import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/pages/loginPage/loginPage.dart';
import 'package:movies/pages/perfilPage/perfil_page_bloc.dart';
import 'package:movies/pages/splashPage/splash_bloc.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/components/loginBotao_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customSharedPreferences.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  PerfilBloc bloc = PerfilBloc();
  SplashBloc splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Perfil"),
      body: Container(
        color: DARK_BLUE,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 170, 60, 40),
                child: GestureDetector(
                  onTap: () {
                    CustomSharedPreferences.saveUsuario(false);
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: LoginBotao(
                    title: "SAIR",
                    botaoColor: SALMON,
                    textColor: DARK_BLUE,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
