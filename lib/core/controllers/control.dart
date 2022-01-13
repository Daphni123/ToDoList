

import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:todolist/core/modul/module.dart';

import 'db/dbHelper.dart';

class NoteController extends GetxController {
  final taskList = [].obs;

  @override
  void onReady() {
    getNotes();
    super.onReady();
  }

  Future<void> addNote({@required Task note}) async {
    await DBHelper.insert(note);
    getNotes();
  }

  Future<void> getNotes() async {
    List<Map<String, dynamic>> notes = await DBHelper.query();
    taskList.assignAll(notes.map((data) => Task.fromJson(data)).toList());
  }

  Future<void> deleteNote({@required Task note}) async {
    await DBHelper.delete(note);
    getNotes();
  }

  Future<void> updateNote({@required Task note}) async {
    await DBHelper.update(note);
    getNotes();
  }
}
