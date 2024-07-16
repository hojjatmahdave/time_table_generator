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
      child: const ScheduleSmartApp(),
    ),
  );
}

class ScheduleSmartApp extends StatelessWidget {
  const ScheduleSmartApp({super.key});

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
        '/teachers_list': (context) => const TeachersList(),
        '/time_table': (context) => const TimeTableScreen(),
      },
    );
  }
}
