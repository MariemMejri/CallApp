import 'package:flutter/material.dart';
import 'package:tp1/constant/myColors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(text,style: TextStyle(color: myGrey),),
        ),
      ),
    );
  }
}
