import 'package:flutter/material.dart';
import 'signupLine.dart';
import 'loginWithGoogle.dart';
import 'forgetPassword.dart';
import 'loginButton.dart';
import 'loginOrLine.dart';
import '../widgets/valideEmailTextFormField.dart';
import '../widgets/validePasswordTextFormField.dart';
import '../../../core/myPhotos.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _loginFormkey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    SizedBox(height: size.height / 6),
                    Center(
                      child: Container(
                        width: size.width / 2,
                        child: Image.asset(safarKarUrdu),
                      ),
                    ),
                    SizedBox(height: 30),
                    ValideEmailTextFormField(email: _email),
                    SizedBox(height: 10),
                    ValidePasswordTextFormField(password: _password),
                    ForgetPassword(),
                    LoginButton(
                      loginFormkey: _loginFormkey,
                      email: _email,
                      password: _password,
                    )
                  ],
                ),
              ),
            ),
            LoginOrLine(size: size),
            Column(
              children: [
                LoginWithGoogle(),
                SizedBox(height: 10),
                SignUpLine(),
                SizedBox(height: 16),
              ],
            )
          ],
        ),
      ),
    );
  }
}
