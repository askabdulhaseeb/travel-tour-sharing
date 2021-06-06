import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../auth/authorisation.dart';
import '../../../core/myColors.dart';
import '../../auth/loginScreen/loginScreen.dart';
import '../../widgets/showLoadingDialog.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController name,
    @required TextEditingController phoneNumber,
    @required TextEditingController email,
    @required TextEditingController password,
    @required TextEditingController confirmPassword,
  })  : _formKey = formKey,
        _name = name,
        _phoneNumber = phoneNumber,
        _email = email,
        _password = password,
        _confirmPassword = confirmPassword,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _name;
  final TextEditingController _phoneNumber;
  final TextEditingController _email;
  final TextEditingController _password;
  final TextEditingController _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          if (_password.text.trim() == _confirmPassword.text.trim()) {
            showLoadingDislog(context, 'Saving Data');
            User _user = await AuthMethods().signupWithEmailAndPassword(
              name: _name.text.trim(),
              email: _email.text.trim(),
              password: _password.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
            );
            Navigator.of(context).pop();
            if (_user != null) {
              Fluttertoast.showToast(
                msg: 'Signup successful',
                backgroundColor: Colors.green,
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (route) => false);
            }
          } else {
            Fluttertoast.showToast(
              msg: 'Password and Confirm Password should be same',
              backgroundColor: Colors.red,
            );
          }
        }
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [greenShade, greenShade],
          ),
        ),
        child: Center(
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
