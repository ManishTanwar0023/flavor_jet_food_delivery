import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flavor_jet_food_delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({super.key, required this.text, this.imgPath='assets/images/empty_cart.png'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // SizedBox(height: Dimensions.height40,),
        Image.asset(imgPath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        SizedBox(height: Dimensions.height20,),
        Text(text,style: TextStyle(
          fontSize: MediaQuery.of(context).size.height*0.0175,
          fontWeight: FontWeight.bold,
          color: AppColors.titleColor
        ),textAlign: TextAlign.center,),
      ],
    );
  }
}
