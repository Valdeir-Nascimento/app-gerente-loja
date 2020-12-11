import 'dart:async';

class LoginValidator {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Informe um e-mail válido");
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.isNotEmpty && password.length > 4) {
        sink.add(password);
      } else {
        sink.addError("Informe a sua senha");
      }
    }
  );

}
