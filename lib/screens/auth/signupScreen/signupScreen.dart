import 'package:flutter/material.dart';
import '../widgets/valideEmailTextFormField.dart';
import '../widgets/valideNameTextFormField.dart';
import '../widgets/validePasswordTextFormField.dart';
import '../widgets/validePhoneNumberTextFormField.dart';
import 'siginLine.dart';
import 'signupButton.dart';
import '../../../core/myPhotos.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = '/SignupScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmPassword = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: signupAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Center(
                    heightFactor: size.height * 0.0017,
                    child: Image.asset(signupPath),
                  ),
                  ValideNameTextFormField(name: _name),
                  ValidePhoneNumberTextFormField(phoneNumber: _phoneNumber),
                  ValideEmailTextFormField(email: _email),
                  ValidePasswordTextFormField(password: _password),
                  ValidePasswordTextFormField(password: _confirmPassword),
                  const SizedBox(height: 10),
                  SignupButton(
                    formKey: _formKey,
                    name: _name,
                    phoneNumber: _phoneNumber,
                    email: _email,
                    password: _password,
                    confirmPassword: _confirmPassword,
                  ),
                  const SizedBox(height: 10),
                  SignInLine(),
                ],
              )),
        ),
      ),
    );
  }
}
