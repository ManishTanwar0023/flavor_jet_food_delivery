import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flavor_jet_food_delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height100,
        width: Dimensions.width100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10*5),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
