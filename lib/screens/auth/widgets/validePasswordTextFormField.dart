import 'package:flutter/material.dart';
import '../../../core/myColors.dart';

class ValidePasswordTextFormField extends StatefulWidget {
  final TextEditingController _password;
  const ValidePasswordTextFormField(
      {Key key, @required TextEditingController password})
      : _password = password,
        super(key: key);
  @override
  _ValidePasswordTextFormFieldState createState() =>
      _ValidePasswordTextFormFieldState();
}

class _ValidePasswordTextFormFieldState
    extends State<ValidePasswordTextFormField> {
  onListener() => setState(() {});
  bool _showPassword = true;

  @override
  void initState() {
    _showPassword = true;
    widget._password.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._password.removeListener(onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: widget._password,
        obscureText: _showPassword,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        autofillHints: [AutofillHints.password],
        validator: (value) {
          if (value.length < 6)
            return 'Password should be greater then 6 digits';
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Password',
          prefix: Container(width: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: greenShade, width: 0.5),
          ),
          suffixIcon: (widget._password.text.isEmpty)
              ? Container(width: 0)
              : IconButton(
                  icon: (_showPassword)
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        _showPassword = !_showPassword;
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
