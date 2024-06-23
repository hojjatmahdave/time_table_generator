import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/cs_time_taker.dart';
import 'screens/teachers_list.dart';
import 'screens/time_table.dart';
import 'providers/teachers_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeachersProvider()),
      ],
      child: ScheduleSmartApp(),
    ),
  );
}

class ScheduleSmartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScheduleSmart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CsTimeTaker(),
        '/teachers_list': (context) => TeachersList(),
        '/time_table': (context) => TimeTableScreen(),
      },
    );
  }
}
