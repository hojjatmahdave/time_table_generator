import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/teacher.dart';
import '../providers/teachers_provider.dart';

class CsTimeTaker extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CS Time Taker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                  _selectedTime = newValue!;
                },
                decoration: InputDecoration(labelText: 'Time Selector'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a time';
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
              SizedBox(height: 20),
              ElevatedButton(
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
                    Navigator.pushNamed(context, '/teachers_list');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
