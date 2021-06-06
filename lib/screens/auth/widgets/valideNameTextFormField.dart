import 'package:flutter/material.dart';
import '../../../core/myColors.dart';

class ValideNameTextFormField extends StatefulWidget {
  final TextEditingController _name;
  ValideNameTextFormField({
    Key key,
    @required TextEditingController name,
  })  : _name = name,
        super(key: key);
  @override
  _ValideNameTextFormFieldState createState() =>
      _ValideNameTextFormFieldState();
}

class _ValideNameTextFormFieldState extends State<ValideNameTextFormField> {
  onListener() => setState(() {});
  @override
  void initState() {
    widget._name.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._name.removeListener(onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: widget._name,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        autofillHints: [AutofillHints.name],
        validator: (value) {
          if (value.length < 3) return 'Enter Correct Name';
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Name',
          prefix: Container(width: 10),
          suffixIcon: IconButton(
            icon: (widget._name.text.isEmpty)
                ? Container(width: 0)
                : Icon(Icons.clear),
            onPressed: () => widget._name.clear(),
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
