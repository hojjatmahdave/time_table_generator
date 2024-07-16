import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/teacher.dart';
import '../providers/teachers_provider.dart';

class CsTimeTaker extends StatefulWidget {
  @override
  _CsTimeTakerState createState() => _CsTimeTakerState();
}

class _CsTimeTakerState extends State<CsTimeTaker> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  String? _selectedTime;

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _subjectController.clear();
    setState(() {
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CS Time Taker',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.blue[400]),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(labelText: 'Subject'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedTime,
                      items: [
                        '2 hours',
                        '4 hours',
                        '6 hours',
                        '8 hours',
                        '10 hours',
                        '12 hours'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedTime = newValue!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Time Selector'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Provider.of<TeachersProvider>(context, listen: false)
                        .addTeacher(
                      Teacher(
                        name: _nameController.text,
                        subject: _subjectController.text,
                        availableTime: _selectedTime!,
                      ),
                    );

                    // Reset the form
                    _resetForm();

                    // Show dialog to check if there are enough teachers
                    Provider.of<TeachersProvider>(context, listen: false)
                        .addListener(() {
                      if (Provider.of<TeachersProvider>(context, listen: false)
                              .teachers
                              .length >
                          3) {
                        Navigator.pushNamed(context, '/teachers_list');
                      }
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ),
            SizedBox(height: 10),
            Consumer<TeachersProvider>(
              builder: (context, teachersProvider, child) {
                return Column(
                  children: [
                    if (teachersProvider.teachers.length < 4)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Please enter more teachers to create time table by them',
                          style: TextStyle(
                              color: Colors.purple[400], fontSize: 12),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submitted teachers: ${teachersProvider.teachers.length}',
                          style: TextStyle(color: Colors.black),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/teachers_list');
                          },
                          child: Text('Check Teachers'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
