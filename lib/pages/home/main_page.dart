
import 'package:flavor_jet_food_delivery/pages/home/page_body.dart';
import 'package:flutter/material.dart';

import '../../utils/appColor.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
     // print("Current Width is "+MediaQuery.of(context).size.width.toString());
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Column(
        children: [
          Container(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height40,bottom: Dimensions.height15),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  BigText(text: "India",color: AppColors.mainColor,),
                  Row(
                    children: [
                      SmallText(text: "Delhi",color: Colors.black54,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down))
                    ],
                  )
                ],),
                Container(
                  height: Dimensions.height40,
                  width: Dimensions.width40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.mainColor
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.search,color: Colors.white,
                          size: Dimensions.icon24,
                        )),),
                )
              ],
            ),
          ),
          ),
          Expanded(child: SingleChildScrollView(
            child: PageBody(),
          ))
        ],
      ),
    );
  }
}
