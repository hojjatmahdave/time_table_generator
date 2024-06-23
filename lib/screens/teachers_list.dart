import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teachers_provider.dart';

class TeachersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers List'),
      ),
      body: Consumer<TeachersProvider>(
        builder: (context, teachersProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: teachersProvider.teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachersProvider.teachers[index];
                    return Card(
                      child: ListTile(
                        title: Text(teacher.name),
                        subtitle: Text(
                            '${teacher.subject} - ${teacher.availableTime}'),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: teachersProvider.teachers.length >= 4
                    ? () => Navigator.pushNamed(context, '/time_table')
                    : null,
                child: Text('Generate'),
              ),
            ],
          );
        },
      ),
    );
  }
}
