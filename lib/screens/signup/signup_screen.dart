import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/helpers/validators.dart';

class SignUpScreen extends StatelessWidget {
  final UserModel user = UserModel();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: 'Nome completo',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Campo obrigatório';
                        else if (name.trim().split(' ').length <= 1)
                          return 'Preencha seu nome completo';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (email) {
                        if (email.isEmpty)
                          return 'Campo obrigatório';
                        else if (!emailValid(email)) return 'E-mail inválido';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      autocorrect: false,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Campo obrigatório';
                        else if (pass.length < 6)
                          return 'Senha deve ter min. de 6 caractéres';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Repita a senha',
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      autocorrect: false,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Campo obrigatório';
                        else if (pass.length < 6)
                          return 'Senha deve ter min. de 6 caractéres';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      // borderOnForeground: true,
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: userManager.loading ? null : () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();

                            if (user.password != user.confirmPassword) {
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: const Text('Senhas não coincidem'),
                                  backgroundColor: Colors.black87,
                                ),
                              );
                              return;
                            }

                            userManager.signUp(
                              user: user,
                              onSuccess: () {
                                Navigator.of(context).pop();
                              },
                              onFail: (e) {
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao cadastrar, $e'),
                                    backgroundColor: Colors.red.shade800,
                                  ),
                                );
                              }
                            );
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ) : Text(
                          'Criar conta',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
