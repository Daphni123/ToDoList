import 'package:flutter/material.dart';
import 'package:todolist/ui/styles/taskStyles.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final String txt;

  MyIconButton({Key key, this.icon, this.onTap, this.txt = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          width: icon != null ? 44 : 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFF242934),
          ),
          child: Center(
              child: icon != null
                  ? Icon(icon, color: Colors.white)
                  : Text(
                txt,
                style: titleTextStyle.copyWith(fontSize: 18,color: Colors.white),
              )),
        ));
  }
}
