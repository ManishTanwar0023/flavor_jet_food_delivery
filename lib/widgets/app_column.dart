
import 'package:flavor_jet_food_delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/appColor.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String bigText;
  final String smallText;
  const AppColumn({
    required this.bigText,
    required this.smallText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: Dimensions.height5),
        BigText(text: bigText,size: Dimensions.font20,),
        SizedBox(height: Dimensions.height5),
        SmallText(text: smallText,size: Dimensions.font15,),
        SizedBox(height: Dimensions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon_Text(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            Icon_Text(
              icon: Icons.location_on,
              text: '1.7km',
              iconColor: AppColors.mainColor,
            ),
            Icon_Text(
              icon: Icons.access_time_rounded,
              text: '35 min',
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
