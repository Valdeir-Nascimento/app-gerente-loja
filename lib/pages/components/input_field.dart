import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool obscure;
  final IconData icon;
  final String hint;
  final Stream<String> stream;
  final  Function(String) onChanged;

  InputField({this.hint, this.icon, this.obscure, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.green),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.green),
            contentPadding: const EdgeInsets.only(left: 5, right: 30, bottom: 30, top: 30),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            errorText: snapshot.hasError ? snapshot.error : null,
          ),
          style: TextStyle(color: Colors.white),
          obscureText: obscure,
        );
      }
    );
  }
}
