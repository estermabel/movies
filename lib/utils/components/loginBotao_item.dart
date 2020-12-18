import 'package:flutter/material.dart';

import '../constants.dart';

class LoginBotao extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color botaoColor;
  const LoginBotao({
    Key key,
    this.title,
    this.textColor,
    this.botaoColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: botaoColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
