import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/models/user_model.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child) {
                if (userManager.loadingFace) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    ),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: emailController,
                      enabled: !userManager.loading,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email)) return 'E-mail inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                      obscureText: true,
                      autocorrect: false,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                    ),
                    child,
                    const SizedBox(height: 16),
                    RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState.validate()) {
                                userManager.signIn(
                                  user: UserModel(
                                      email: emailController.text,
                                      password: passController.text),
                                  onFail: (e) {
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao entrar, $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                      color: Theme.of(context).primaryColor,
                      disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      text: 'Entrar com Facebook',
                      onPressed: () {
                        userManager.facebookLogin(
                          onFail: (e) {
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                duration: Duration(milliseconds: 5000),
                                content: Text('Falha ao entrar, $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          onSuccess: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        padding: EdgeInsets.zero,
                        child: Text('Criar conta'),
                      ),
                    ),
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Text('Esqueci minha senha'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
