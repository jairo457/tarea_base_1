import 'package:flutter/material.dart';
import 'package:tarea_base_1/screens/AddCareer.dart';
import 'package:tarea_base_1/screens/AddProfesor.dart';
import 'package:tarea_base_1/screens/AddTask.dart';
import 'package:tarea_base_1/screens/CalendarScreen.dart';
import 'package:tarea_base_1/screens/CareerScreen.dart';
import 'package:tarea_base_1/screens/HomeScreen.dart';
import 'package:tarea_base_1/screens/ProfesorScreen.dart';
import 'package:tarea_base_1/screens/TaskScreen.dart';

Map<String, WidgetBuilder> GetRoutes() {
  return {
    '/home': (BuildContext context) => HomeScreen(),
    '/Task': (BuildContext context) => TaskScreen(),
    '/addCareer': (BuildContext context) => AddCareer(),
    '/Career': (BuildContext context) => CareerScreen(),
    '/Profesor': (BuildContext context) => ProfesorScreen(),
    '/Calendar': (BuildContext context) => CalendarScreen(),
    '/addProfesor': (BuildContext context) => AddProfesor(),
    '/addTask': (BuildContext context) => AddTask(),
  };
}
