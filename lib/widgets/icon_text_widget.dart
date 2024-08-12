
import 'package:flavor_jet_food_delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class Icon_Text extends StatelessWidget {
  final  IconData icon;
  final String text;
  final Color iconColor;
  double size;


   Icon_Text({
    this.size = 0,
    required this.icon,
    required this.text,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon,color: iconColor,size: size ==0? Dimensions.height15:size,),
        SizedBox(width: Dimensions.width5,),
        SmallText(text: text,)
      ],
    );
  }
}
