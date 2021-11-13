import 'package:flutter/material.dart';
import 'dart:math';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromRGBO(255, 128, 0, 10),
                  Color.fromRGBO(102, 0, 102, 10),
                ])),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                 transform: Matrix4.rotationZ(-10 * pi /180 ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      child: Text(
                        'Minha loja',
                        style: TextStyle(color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
