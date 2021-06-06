import 'package:flutter/material.dart';
import '../../../core/myColors.dart';

class ValideEmailTextFormField extends StatefulWidget {
  final TextEditingController _email;
  ValideEmailTextFormField({
    Key key,
    @required TextEditingController email,
  })  : _email = email,
        super(key: key);
  @override
  _ValideEmailTextFormFieldState createState() =>
      _ValideEmailTextFormFieldState();
}

class _ValideEmailTextFormFieldState extends State<ValideEmailTextFormField> {
  onListener() => setState(() {});
  @override
  void initState() {
    widget._email.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._email.removeListener(onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: widget._email,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autofillHints: [AutofillHints.email],
        validator: (value) {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Email is Invalide';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Email',
          prefix: Container(width: 10),
          suffixIcon: IconButton(
            icon: (widget._email.text.isEmpty)
                ? Container(width: 0)
                : Icon(Icons.clear),
            onPressed: () => widget._email.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: greenShade, width: 0.5),
          ),
        ),
      ),
    );
  }
}
