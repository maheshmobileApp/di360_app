import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatelessWidget {
 ImageWidget({ Key? key, required this.imageUrl,this.height,this.width }) : super(key: key);
final String imageUrl;
double? height = 20;
double? width = 20;

  @override
  Widget build(BuildContext context){
    return  Image.asset(
      imageUrl,
    );
  }
}