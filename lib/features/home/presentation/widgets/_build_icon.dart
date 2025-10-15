import 'package:flutter/material.dart';

class buildicon extends StatelessWidget {
  const buildicon({super.key, required this.icon, this.color, this.iconcolor,});
  final IconData icon;
  final Color ?color;
  final Color ?iconcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      //  width: 40,
      decoration: BoxDecoration(
        //  borderRadius: BorderRadius.circular(230),
        color: color ?? Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: iconcolor ?? Colors.white, size: 20,),
    );
  }
}
