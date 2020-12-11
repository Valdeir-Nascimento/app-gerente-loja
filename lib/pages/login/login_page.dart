import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenteloja/blocs/login_bloc.dart';
import 'package:gerenteloja/enums/login_state_enum.dart';
import 'package:gerenteloja/pages/components/input_field.dart';
import 'package:gerenteloja/pages/home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) { 
      switch(state) {
        case LoginStateEnum.SUCCESS:
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
          break;
        case LoginStateEnum.FAIL:
          showDialog(
            context: context,
            builder: (contex) => AlertDialog(
              title: Text("Erro"),
              content: Text("Você não possui os privilegios necessários"),
            ));
          break;
        case LoginStateEnum.LOADING:
        case LoginStateEnum.IDLE:
        
        
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<Object>(
        stream: _loginBloc.outState,
        initialData: LoginStateEnum.LOADING,
        builder: (context, snapshot) {
          print("Snapshot ${snapshot.data}");  
          switch(snapshot.data) {
            case LoginStateEnum.LOADING:
              return Center(child: CircularProgressIndicator());
            case LoginStateEnum.FAIL:
            case LoginStateEnum.SUCCESS:
            case LoginStateEnum.IDLE:
            default: 
              return Stack(
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
                                onPressed: snapshot.hasData ? _loginBloc.submit : null,
                              ),
                            );
                          }
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
            
          }
          
        }
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }
}
