import 'package:diet/starting_pages/summary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'summary_page.dart';

class GenderPage extends StatefulWidget {
  final User user;
  final String name;
  final int age;
  final double height;
  final double weight;

  const GenderPage({Key? key, required this.user, required this.name, required this.age, required this.height, required this.weight}) : super(key: key);

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Gender')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                hint: Text('Select Gender'),
                value: selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                items: <String>['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedGender != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummaryPage(
                              user: widget.user,
                              name: widget.name,
                              age: widget.age,
                              height: widget.height,
                              weight: widget.weight,
                              gender: selectedGender!,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
