import 'package:flavor_jet_food_delivery/widgets/appbar_icons.dart';
import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AccountWidget extends StatelessWidget {
  AppBarIcons appIcons;
  BigText text;
  AccountWidget({super.key,required this.appIcons,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:Dimensions.width20,
      top: Dimensions.height10,
      bottom: Dimensions.height10),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 2,
              offset: Offset(0, 5
              ),
          color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      child: Row(
        children: [
          appIcons,
          SizedBox(width: Dimensions.width20,),
          text
        ],
      ),
    );
  }
}
