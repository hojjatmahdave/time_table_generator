import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/teachers_provider.dart';
import '../models/timetable.dart';
import '../models/teacher.dart'; // Add this import

class TimeTableScreen extends StatelessWidget {
  List<TimeTableEntry> generateTimeTable(List<Teacher> teachers) {
    // Basic algorithm to generate a timetable
    List<TimeTableEntry> timetable = [];
    List<String> days = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];

    int teacherIndex = 0;
    for (String day in days) {
      for (int session = 1; session <= 3; session++) {
        if (teacherIndex >= teachers.length) {
          teacherIndex = 0;
        }
        timetable.add(TimeTableEntry(
          teacher: teachers[teacherIndex].name,
          subject: teachers[teacherIndex].subject,
          day: day,
          time: 'Session $session',
        ));
        teacherIndex++;
      }
    }

    return timetable;
  }

  @override
  Widget build(BuildContext context) {
    final teachersProvider = Provider.of<TeachersProvider>(context);

    List<TimeTableEntry> timetable =
        generateTimeTable(teachersProvider.teachers);

    return Scaffold(
      appBar: AppBar(
        title: Text('Time Table'),
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
          ElevatedButton(
            onPressed: () {
              timetable = generateTimeTable(teachersProvider.teachers);
            },
            child: Text('Regenerate'),
          ),
        ],
      ),
    );
  }
}
