
import 'package:flavor_jet_food_delivery/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/appColor.dart';
import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({required this.text});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool  HiddenText = true;
  double textHeight = Dimensions.ScreenHeight/7.84;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length> textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,size: Dimensions.font16,):Column(
        children: [
          SmallText(text: HiddenText?(firstHalf+"..."):(firstHalf+secondHalf),size: Dimensions.font16,height: 1.5,),
          InkWell(
            onTap: (){
              setState(() {
                HiddenText = !HiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: "Show more",color: AppColors.mainColor,),
                Icon(HiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
