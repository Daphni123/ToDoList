import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/core/modul/module.dart';
import 'package:todolist/ui/pages/taskDatails.dart';
import 'package:todolist/ui/styles/taskColors.dart';
import 'package:todolist/ui/styles/taskStyles.dart';

enum TileType {
  Square,
  VerRect,
  HorRect,
}

class NoteTile extends StatelessWidget {
  final Task note;
  final TileType tileType;
  NoteTile({
    this.note,
    this.tileType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => NoteDetailPage(note: note),
          transition: Transition.leftToRight,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: tileColors[note.id % 4],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: tileType == TileType.HorRect
                  ? const EdgeInsets.only(right: 100)
                  : null,
              child: Text(
                note.title,
                maxLines: 3,
                style: noteTitleTextStyle.copyWith(
                  fontSize: 30,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: tileType == TileType.HorRect
                  ? const EdgeInsets.only(right: 100)
                  : null,
              child: Text(
                note.task,
                maxLines: 3,
                style: noteTitleTextStyle.copyWith(
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(note.date,
                    style: dateTextStyle.copyWith(
                        color: Colors.black.withOpacity(0.7))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
