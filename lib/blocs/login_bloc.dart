import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gerenteloja/enums/login_state_enum.dart';
import 'package:gerenteloja/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginStateEnum>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<LoginStateEnum> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Rx.combineLatest2(outEmail, outPassword, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  StreamSubscription _streamSubscription;

  LoginBloc() {

    // FirebaseAuth.instance.signOut();
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if(user != null) {  
        if(await verifyPrivileges(user)){
          _stateController.add(LoginStateEnum.SUCCESS);
        } else {
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginStateEnum.FAIL);
        }
      } else {
        _stateController.add(LoginStateEnum.IDLE);
      }
    });
  
  }

  Future<bool> verifyPrivileges(User user) async {

   return await FirebaseFirestore.instance.collection("admins").doc(user.uid).get().then((doc) {
      if(doc.data != null) {
        print("TRUE");
        return true;
      } else {
        print("FALSE");
        return false;
      }
    }).catchError((error) {
        print("EXCEP FALSE");
      //Não e adminitrador
      return false;
    });
  }

  void submit() {
    final email = _emailController.value;
    final senha = _passwordController.value;

    _stateController.add(LoginStateEnum.LOADING);
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: senha,
    ).catchError((e) {
      _stateController.add(LoginStateEnum.FAIL);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
    _passwordController.close();
    _streamSubscription.cancel();
  }
}
