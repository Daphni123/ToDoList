import 'package:todolist/core/modul/module.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/controllers/control.dart';

import 'package:todolist/ui/pages/home.dart';
import 'package:todolist/ui/styles/taskColors.dart';
import 'package:todolist/ui/styles/taskStyles.dart';
import 'package:todolist/ui/widgets/taskButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist/core/modul/module.dart';

class AddNotePage extends StatefulWidget {
  final bool isUpdate;
  final Task note;
  AddNotePage({this.isUpdate = false, this.note});

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  final NoteController _noteController = Get.find<NoteController>();
  final DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleTextController.text = widget.note.title;
      _noteTextController.text = widget.note.task;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _body(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIconButton(
            onTap: () {
              Get.back();
            },
            icon: Icons.keyboard_arrow_left,

          ),
          MyIconButton(
            onTap: () {
              _validateInput();
            },
            txt: widget.isUpdate ? "Update" : "Save",

          ),
        ],
      ),
    );
  }

  _body() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Add\nNote",
              style: titleTextStyle.copyWith(fontSize: 60),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            controller: _titleTextController,
            style: titleTextStyle,
            cursorColor: Colors.white,
            maxLines: 3,
            minLines: 1,
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: titleTextStyle.copyWith(color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bgColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bgColor),
              ),
            ),
          ),
          const SizedBox(
                height: 12,
          ),
          TextFormField(
            controller: _noteTextController,
            style: bodyTextStyle,
            cursorColor: Colors.white,
            minLines: 3,
            maxLines: 12,
            decoration: InputDecoration(
              hintText: "Type something...",
              hintStyle: noteTitleTextStyle.copyWith(color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bgColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: bgColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _validateInput() async {
    bool isNotEmpty = _titleTextController.text.isNotEmpty &&
        _noteTextController.text.isNotEmpty;
    if (isNotEmpty && !widget.isUpdate) {
      _addNoteToDB();
      Get.back();
    } else if (widget.isUpdate &&
        _titleTextController.text != widget.note.title ||
        _noteTextController.text != widget.note.task) {
      _updateNote();
      Get.offAll(() => HomePage());
    } else {
      Get.snackbar(
        widget.isUpdate ? "Not Updated" : "Required*",
        widget.isUpdate
            ? "Fields are not updated yet."
            : "All fields are required.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }

  _addNoteToDB() async {
    await _noteController.addNote(
      note: Task(
        task: _noteTextController.text,
        title: _titleTextController.text,
        date: DateFormat.yMMMd().format(_currentDate).toString(),
      ),
    );
  }

  _updateNote() async {
    await _noteController.updateNote(
      note: Task(
        id: widget.note.id,
        task: _noteTextController.text,
        title: _titleTextController.text,
        date: DateFormat.yMMMd().format(_currentDate).toString(),
      ),
    );
  }
}
