import 'package:flutter/material.dart';

class JobTimeChip extends StatelessWidget {
  final String time;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;

  const JobTimeChip({
    Key? key,
    required this.time,
    this.height = 19,
    this.borderRadius = 5,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.centerRight,
      child: Text(
        time,
        textAlign: TextAlign.right,
        style: textStyle ??
            const TextStyle(
              fontSize:8,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(255, 112, 0, 1),
            ),
      ),
    );
  }
}
