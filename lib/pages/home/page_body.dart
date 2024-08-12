import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flavor_jet_food_delivery/routes/route_helper.dart';
import 'package:flavor_jet_food_delivery/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controllers/productController.dart';
import '../../controllers/recommended_productController.dart';
import '../../model/product_model.dart';
import '../../utils/appColor.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/rating_bar.dart';
import '../../widgets/small_text.dart';

class PageBody extends StatefulWidget {
  const PageBody({Key? key}) : super(key: key);

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  // List<String> foodList = [
  //   'assets/images/food.jpeg',
  //   'assets/images/burgur.jpeg',
  //   'assets/images/non_veg.png',
  //   'assets/images/ice_cream.jpg',
  //   'assets/images/Pizza.jpeg',
  // ];

  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Slider Section...
        GetBuilder<ProductController>(builder: (PC) {
          // print('Product list length: ${PC.productList.length}'); // Debug print
          return PC.isLoaded
              ? Container(
                  height: Dimensions.page_body_imageSliderContainer,
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    itemCount: PC.productList.length,
                    itemBuilder: (context, index, realIndex) {
                      if (index < 0 || index >= PC.productList.length) {
                        // Handle invalid index gracefully
                        return Center(child: Text('Invalid index: $index'));
                      }
                      // print("API Image URL: https://manishtanwar.online/" + PC.productList[realIndex].img!);
                      return _buildPageItem2(index, PC.productList[index]);
                    },
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      padEnds: true,
                      pauseAutoPlayOnTouch: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),

        SizedBox(height: Dimensions.height2),
        // Indicator...
        GetBuilder<ProductController>(builder: (PC) {
          return _buildIndicator(PC);
        }),
        SizedBox(height: Dimensions.height20),
        // Recommended...
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"),
              ),
            ],
          ),
        ),
        // Recommended Food...
        GetBuilder<Recommended_ProductController>(builder: (RPC) {
          return RPC.isLoaded?
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: RPC.recommended_productList.length,
            itemBuilder: (context, index) =>
                InkWell(onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index,"Home"));
                },
                  child: Container(
                                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  child: Row(
                    children: [
                      Container(
                        height: Dimensions.listViewImgSize,
                        width: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1,color: Colors.deepOrange),
                            top: BorderSide(width: 1,color: Colors.deepOrange),
                            bottom: BorderSide(width: 1,color: Colors.deepOrange),
                          ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            // border: Border.all(width: 1, color: Colors.black26),
                            image: DecorationImage(
                                image: NetworkImage(
                                    AppConstants.BASE_URL+"/"+RPC.recommended_productList[index].image!),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContSize,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1,color: Colors.deepOrange),
                              top: BorderSide(width: 1,color: Colors.deepOrange),
                              bottom: BorderSide(width: 1,color: Colors.deepOrange),
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius10),
                              bottomRight: Radius.circular(Dimensions.radius10),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10),
                            child: AppColumn(
                              bigText:RPC.recommended_productList[index].name!,
                              smallText: "With Chinese Characteristics",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                                ),
                              ),
                ),
          ):
          Center(child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ));
        }),
      ],
    );
  }

  Widget _buildPageItem2(int index, ProductModel productList) {
    return Stack(
      children: [
        InkWell(onTap: (){
          Get.toNamed(RouteHelper.getPopularFood(index,"Home"));
        },
          child: Container(
            height: Dimensions.page_body_imageContainer,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.deepOrange),
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.BASE_URL+"/"+productList.image!)
              ),
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
          ),
        ),
        Align(alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
            height: Dimensions.page_body_text_on_image_Container,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius10),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: productList.name!),
                  SizedBox(height: Dimensions.height2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyRatingBar(),
                      SmallText(text: '4.5'),
                      SmallText(text: '2341 comments'),
                    ],
                  ),
                  SizedBox(height: Dimensions.height18),
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(ProductController PC) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DotsIndicator(
          dotsCount: PC.productList.isEmpty ? 1 : PC.productList.length,
          position: _current,
          decorator: DotsDecorator(
            size: Size.square(Dimensions.height9),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeColor: Colors.deepOrange,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
