import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teachers_provider.dart';

class TeachersList extends StatelessWidget {
  const TeachersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers List'),
      ),
      body: Consumer<TeachersProvider>(
        builder: (context, teachersProvider, child) {
          return Column(
            children: [
              Expanded(
                child: teachersProvider.teachers.isEmpty
                    ? Center(
                        child: Text(
                          'There is no teacher in the list, please add some',
                          style:
                              TextStyle(fontSize: 16, color: Colors.red[400]),
                        ),
                      )
                    : ListView.builder(
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
              if (teachersProvider.teachers.isNotEmpty &&
                  teachersProvider.teachers.length < 4)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Please add more teacher's info to the list, min 4",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (teachersProvider.teachers.length < 4)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          child: const Text('Back to Time Taker'),
                        ),
                      ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: teachersProvider.teachers.length >= 4
                            ? () => Navigator.pushNamed(context, '/time_table')
                            : null,
                        child: const Text('Generate'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
