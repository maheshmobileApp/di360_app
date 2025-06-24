import 'package:flutter/material.dart';

mixin BaseContextHelpers {
  Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  Widget addHorizontal(double width) {
    return SizedBox(width: width);
  }

  Widget addVertical(double height) {
    return SizedBox(height: height);
  }
  
}
