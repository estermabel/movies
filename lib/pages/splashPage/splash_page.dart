import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/pages/controllerPage/controllerPage.dart';
import 'package:movies/pages/homePage/home_page.dart';
import 'package:movies/pages/loginPage/loginPage.dart';
import 'package:movies/pages/splashPage/splash_bloc.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customSharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc bloc = SplashBloc();

  SharedPreferences loginData;

  @override
  void initState() {
    super.initState();
    bloc.getUsuarioLogin();
    bloc.splashStream.listen((event) {
      debugPrint(event.toString());
      if (event) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => ControllerPage(),
          ),
        );
      } else {
        _loadData();
      }
    });

    //_loadData();
  }

  _loadData() async {
    await Future.delayed(new Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DARK_BLUE,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Movies",
                style: TextStyle(
                  fontSize: 80,
                  color: SALMON,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
