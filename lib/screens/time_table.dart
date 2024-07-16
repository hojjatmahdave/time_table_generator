import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teachers_provider.dart';
import '../models/timetable.dart';
import '../models/teacher.dart';
import 'dart:math';

class TimeTableScreen extends StatelessWidget {
  const TimeTableScreen({super.key});

  List<TimeTableEntry> generateTimeTable(List<Teacher> teachers) {
    List<TimeTableEntry> timetable = [];
    List<String> days = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday'
    ];

    // Keep track of assigned hours for each teacher
    Map<String, int> teacherHours = {
      for (var teacher in teachers) teacher.name: 0
    };
    Random random = Random();

    for (String day in days) {
      for (int session = 1; session <= 2; session++) {
        if (teachers.isEmpty) {
          break;
        }

        // Select a teacher randomly
        Teacher selectedTeacher;
        do {
          selectedTeacher = teachers[random.nextInt(teachers.length)];
        } while (teacherHours[selectedTeacher.name]! >= 24);

        // Add the session to the timetable
        timetable.add(TimeTableEntry(
          teacher: selectedTeacher.name,
          subject: selectedTeacher.subject,
          day: day,
          time: 'Session $session',
        ));

        // Update the teacher's assigned hours
        teacherHours[selectedTeacher.name] =
            teacherHours[selectedTeacher.name]! + 2;

        // Remove teacher if they have reached 24 hours
        if (teacherHours[selectedTeacher.name]! >= 24) {
          teachers.remove(selectedTeacher);
        }
      }
    }

    return timetable;
  }

  @override
  Widget build(BuildContext context) {
    final teachersProvider = Provider.of<TeachersProvider>(context);

    List<TimeTableEntry> timetable =
        generateTimeTable(teachersProvider.teachers.toList());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Table'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Day')),
                  DataColumn(label: Text('Session')),
                  DataColumn(label: Text('Teacher')),
                  DataColumn(label: Text('Subject')),
                ],
                rows: timetable.map((entry) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(entry.day)),
                      DataCell(Text(entry.time)),
                      DataCell(Text(entry.teacher)),
                      DataCell(Text(entry.subject)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  timetable =
                      generateTimeTable(teachersProvider.teachers.toList());
                  (context as Element).reassemble();
                },
                child: const Text('Regenerate'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
