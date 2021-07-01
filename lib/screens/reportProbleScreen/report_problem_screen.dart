import 'package:dummy_project/database/report_problem_methods.dart';
import 'package:dummy_project/screens/widgets/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportProblemScreen extends StatelessWidget {
  static const routeName = '/ReportProblemScreen';
  final TextEditingController _problem = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please explain your problem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '''We'll try to resolve your problems as soon as possible''',
              maxLines: 2,
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _problem,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Write your Problem ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_problem.text.isNotEmpty) {
                    ReportProblemMethods().submitReport(_problem.text);
                    Fluttertoast.showToast(
                        msg: 'Problem submitted',
                        backgroundColor: Colors.green);
                    Navigator.of(context).pop();
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Write a problem', backgroundColor: Colors.red);
                  }
                },
                child: Text('Submit Problem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
