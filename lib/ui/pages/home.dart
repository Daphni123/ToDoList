// TODO Implement this library.

import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:todolist/core/controllers/control.dart';
import 'package:todolist/ui/styles/taskColors.dart';
import 'package:todolist/ui/styles/taskStyles.dart';
import 'package:todolist/ui/widgets/taskTitle.dart';

import 'addTask.dart';

class HomePage extends StatelessWidget {
  final _notesController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF002A44),
          onPressed: () {
            Get.to(
              AddNotePage(note: null,),
              transition: Transition.downToUp,
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            const SizedBox(
              height: 16,
            ),
            _body(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "TODO Notes",
            style: titleTextStyle.copyWith(fontSize: 40),
          ),

        ],
      ),
    );
  }

  _body() {
    return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 20),

          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Obx(() {
            print("######## " + _notesController.taskList.length.toString());
            if (_notesController.taskList.isNotEmpty) {
              return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemCount: _notesController.taskList.length,
                  itemBuilder: (context, index) {
                    return NoteTile(
                      tileType: TileType.Square,
                      note: _notesController.taskList[index],
                    );
                  },
                  staggeredTileBuilder: (int index) => StaggeredTile.count(4, 2));

            } else {
              return Center(
                child: Text("Empty", style: titleTextStyle),
              );
            }
          }),
        ));
  }
}
