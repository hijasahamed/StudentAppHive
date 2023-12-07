import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_app/db/model/db_model.dart';

ValueNotifier<List<Studentmodel>> studentlistNotifier = ValueNotifier([]);



Future<void> addStudent(Studentmodel value) async{
  final studentDB= await Hive.openBox<Studentmodel>('student_db');
  final _id= await studentDB.add(value);
  value.id=_id;
  studentDB.put(_id, value);
  getAllStudents();

}

Future<void> getAllStudents() async{
  final studentDB= await Hive.openBox<Studentmodel>('student_db');
  studentlistNotifier.value.clear();
  studentlistNotifier.value.addAll(studentDB.values);
  studentlistNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async{
  final studentDB= await Hive.openBox<Studentmodel>('student_db');
  await studentDB.delete(id);
  getAllStudents();
}

Future<void> updateStudent(int id,Studentmodel value) async{
  final studentDB= await Hive.openBox<Studentmodel>('student_db');
  await studentDB.put(id, value);
  getAllStudents(); 
}
