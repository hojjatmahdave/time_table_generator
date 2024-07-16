import 'package:flutter/material.dart';
import '../models/teacher.dart';

class TeachersProvider with ChangeNotifier {
  final List<Teacher> _teachers = [];

  List<Teacher> get teachers => _teachers;

  void addTeacher(Teacher teacher) {
    _teachers.add(teacher);
    notifyListeners();
  }
}
