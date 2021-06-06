import 'package:flutter/material.dart';

class ValidePlanName extends StatefulWidget {
  final TextEditingController _planName;
  const ValidePlanName({Key key, @required TextEditingController planName})
      : this._planName = planName,
        super(key: key);
  @override
  _ValidePlanNameState createState() => _ValidePlanNameState();
}

class _ValidePlanNameState extends State<ValidePlanName> {
  onListener() => setState(() {});
  @override
  void initState() {
    widget._planName.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._planName.removeListener(onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._planName,
      autofocus: true,
      keyboardType: TextInputType.name,
      maxLines: 1,
      validator: (value) {
        return (value.isEmpty)
            ? 'Enter your Planner Name'
            : (value.length < 3)
                ? 'Plan name should be more than 3 charecters'
                : null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.library_books_outlined),
        suffixIcon: IconButton(
          icon: (widget._planName.text.isEmpty)
              ? Container(width: 0)
              : Icon(Icons.clear),
          onPressed: () => widget._planName.clear(),
        ),
        hintText: 'Enter Plan Name',
        labelText: 'Plan Name',
      ),
    );
  }
}
