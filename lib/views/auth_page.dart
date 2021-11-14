import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { SingIn, Register }

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode _authMode = AuthMode.SingIn;

  var _register = false;
  var _viewPassword = false;
  var _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _authData = Map<String, Object>();

  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final _passwordFocus = FocusNode();

  bool isLogin() {
    return _authMode == AuthMode.SingIn;
  }

  bool isRegister() {
    return _authMode == AuthMode.Register;
  }

  void verifIsLogin() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.Register;
      } else {
        _authMode = AuthMode.SingIn;
      }
    });
  }

  Future<void> submitForm() async {
    

    final isValid = _formKey.currentState.validate() ?? false;
    if (!isValid) {
      return print('Formulário inválido');
    }
    _formKey.currentState?.save();

    

     final email = _authData['email'];
     final password = _authData['password'];

     if(isLogin()){
      setState(() {
         _isLoading = true;
      });
     
     }
     if(isRegister()){
      setState(() {
         _isLoading = true;
      });
     Provider.of<Auth>(context, listen: false).sigin(email, password).then((response){
      return setState(() {
          
         _isLoading = false;
      });
    
     },
     
     );

     }


    
  }

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
                    transform: Matrix4.rotationZ(-10 * pi / 180),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      child: Text(
                        'Minha loja',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(height: 15),
                Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 15,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                       height: isLogin() ? 130 : 270,
                      child: Form(
                          key: _formKey,
                          child: Column(
                          children: [
                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocus);
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'email', icon: Icon(Icons.email)),
                          validator: (value) {
                            if (_emailController.text.trim().isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            if (!_emailController.text.contains('@') ||
                                !_emailController.text.contains('.com')) {
                              return 'Email inválido!';
                            }
                            return null;
                          },
                          onSaved: (email) {
                            _authData['email'] = email ?? '';
                          },
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          textInputAction: _register
                              ? TextInputAction.next
                              : TextInputAction.done,
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: _viewPassword ? false : true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: 'senha', icon: Icon(Icons.lock)),
                          validator: (value) {
                            if (_passwordController.text.trim().isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            if (_passwordController.text.trim().length <
                                8) {
                              return 'Minímo de 8 caracteres!';
                            }
                            return null;
                          },
                          onSaved: (password) {
                            _authData['password'] = password ?? '';
                          },
                        ),
                    ),
                        !isLogin() ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (_confirmPasswordController.text ==
                                    _passwordController.text) {
                                  return null;
                                } else {
                                  return 'Senha precisa ser a mesma';
                                }
                              },
                              controller: _confirmPasswordController,
                              obscureText: _viewPassword ? false : true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: 'Confirmar senha',
                                  icon: Icon(Icons.lock)),
                              onSaved: (confirmPassword) {
                                _authData['confirmPassword'] =
                                    confirmPassword ?? '';
                              },
                            ),
                        ) : Container(),
                          ]
                        ),
                      )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 140),
                            child: TextButton(
                              onPressed: submitForm,
                              child: _isLoading ? CircularProgressIndicator() : Text(isLogin() ? 'Entrar' : 'Registrar-se'),
                            )),
                        Container(
                          margin: isRegister() ? EdgeInsets.only(left: 60) : EdgeInsets.only(left: 90),
                          child: IconButton(
                              icon: Icon(Icons.remove_red_eye_sharp),
                              onPressed: () {
                                setState(() {
                                  _viewPassword = !_viewPassword;
                                });
                              }),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          verifIsLogin();
                        },
                        child: isLogin()
                            ? Text('Registrar-se')
                            : Text('Já possuo conta'))
                  ],
                ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
