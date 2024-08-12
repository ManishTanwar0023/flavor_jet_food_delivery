import 'package:flavor_jet_food_delivery/base/custom_loader.dart';
import 'package:flavor_jet_food_delivery/controllers/auth_Controller.dart';
import 'package:flavor_jet_food_delivery/controllers/cartController.dart';
import 'package:flavor_jet_food_delivery/routes/route_helper.dart';
import 'package:flavor_jet_food_delivery/widgets/account_widget.dart';
import 'package:flavor_jet_food_delivery/widgets/appbar_icons.dart';
import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/user_Controller.dart';
import '../../utils/appColor.dart';
import '../../utils/dimensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("User Has Logged In");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText(text: "Profile",size: Dimensions.font24,color: Colors.white,)),
      ),
      body: GetBuilder<UserController>(builder: (userCont){
        return _userLoggedIn?
        (userCont.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              // Profile Icon
              AppBarIcons(icon: Icons.person,
                backgroundColor: AppColors.yellowColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height40,
                size: Dimensions.height15*Dimensions.height10,),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Name
                      AccountWidget(
                          appIcons: AppBarIcons(icon: Icons.person,
                            backgroundColor: Colors.green,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          text: BigText(text: userCont.userModel.name)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      // Phone
                      AccountWidget(
                          appIcons: AppBarIcons(icon: Icons.phone,
                            backgroundColor: Colors.lime,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          text: BigText(text: userCont.userModel.phone)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      // Email
                      AccountWidget(
                          appIcons: AppBarIcons(icon: Icons.email_outlined,
                            backgroundColor: Colors.orange,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          text: BigText(text: userCont.userModel.email)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      // Address
                      AccountWidget(
                          appIcons: AppBarIcons(icon: Icons.location_city,
                            backgroundColor: Colors.blue,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          text: BigText(text: "Fill your Address")
                      ),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                          appIcons: AppBarIcons(icon: Icons.message,
                            backgroundColor: Colors.purple,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          text: BigText(text: "Message")
                      ),
                      SizedBox(height: Dimensions.height20,),
                      InkWell(onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()){
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.offNamed(RouteHelper.getLogIn());
                        }else{
                          print("you logged Out ");
                        }

                      },
                        child: AccountWidget(
                            appIcons: AppBarIcons(icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,),
                            text: BigText(text: "Log Out")
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):
        CustomLoader()):
        Container(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height120*2,
                margin: EdgeInsets.only(left: Dimensions.width20,right:Dimensions.width20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage("assets/images/signConti.png"))
                ),
              ),
              InkWell(onTap: (){
                Get.offNamed(RouteHelper.getLogIn());
              },
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*5,
                  margin: EdgeInsets.only(left: Dimensions.width20,right:Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: Center(child: BigText(text: "Sign In",color: Colors.white,size: Dimensions.font26,)),
                ),
              ),

            ],
          ),
        ),);
      },),
    );
  }
}