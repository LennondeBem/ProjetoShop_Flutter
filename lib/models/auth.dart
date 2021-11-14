
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Auth with ChangeNotifier{

  static const _urlRegister = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCD2l4XnTmOpiNbwke4xVabE97AaUCXhKc';


   
   Future<bool> userExist(bool resp) async {
     return resp;
   }

   

  Future<void> sigin(String email, String password) async{
    final response = await http.post(Uri.parse(_urlRegister),
    body: jsonEncode({
      'email' : email,
      'password': password,
      'returnSecureToken' : true,
    })
    );
    if(response.statusCode == 400){
      userExist(true);
      print('Email Existente');
    }
    userExist(false);
  }

  notifyListeners();
}