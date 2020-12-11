import 'package:flutter/material.dart';
import 'package:gerenteloja/blocs/login_bloc.dart';
import 'package:gerenteloja/pages/components/input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.store_mall_directory, color: Colors.green, size: 160),
                  
                  InputField(
                    icon: Icons.person_outline, 
                    hint: "Usuário", 
                    obscure: false, 
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
                  ),

                  InputField(
                    icon: Icons.mail_outline,
                    hint: "Senha",
                    obscure: true,
                    stream: _loginBloc.outPassword,
                    onChanged: _loginBloc.changePassword,
                  ),
                  
                  SizedBox(height: 30),
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot) {
                      return Container(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.green,
                          disabledColor: Colors.green.withAlpha(120),
                          textColor: Colors.white,
                          child: Text("Entrar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          onPressed: snapshot.hasData ? () {} : null,
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
