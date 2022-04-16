import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/widgets/widgets.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        cursorColor: secondary,
        decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: secondary,
            ),
            hintText: "Şifreniz",
            hintStyle: TextStyle(fontFamily: 'OpenSans'),
            suffixIcon: Icon(
              Icons.visibility,
              color: secondary,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
