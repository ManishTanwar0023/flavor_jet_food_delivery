import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/dimensions.dart';

class MyRatingBar extends StatefulWidget {
  const MyRatingBar({super.key});

  @override
  State<MyRatingBar> createState() => _MyRatingBarState();
}

class _MyRatingBarState extends State<MyRatingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height10,
      child: RatingBar.builder(
        maxRating: 5,
        itemSize: Dimensions.height20,
        initialRating: 5,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}
