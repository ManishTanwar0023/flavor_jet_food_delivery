

import 'package:flavor_jet_food_delivery/base/custom_loader.dart';
import 'package:flavor_jet_food_delivery/pages/auth/sign_up.dart';
import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flavor_jet_food_delivery/utils/dimensions.dart';
import 'package:flavor_jet_food_delivery/widgets/app_textField.dart';
import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackBar.dart';
import '../../controllers/auth_Controller.dart';
import '../../routes/route_helper.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in valid email address",title: "Enter Valid Email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("your password can't be less then 6 characters",title: "Enter Valid Password");
      }else{
        // print("SignupModel data: Name=$name, Email=$email, Password=$password, Phone=$phone");
        // showCustomSnackBar1("All is Well",title: "Sign Up Successfully");

        authController.login(email, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authCont){
        return !authCont.isLoading?
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.ScreenHeight*0.05,),
              Container(
                height: Dimensions.ScreenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage("assets/images/food_logo11.png"),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20+Dimensions.font20/2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",style: TextStyle(fontSize: Dimensions.font20*3,fontWeight: FontWeight.bold),),
                    Text("Welcome Back",style: TextStyle(fontSize: Dimensions.font20,color: Colors.grey[500],),)
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20*2,),
              AppTextField(controller: emailController, hintText: "Email", icon: Icons.email,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(controller: passwordController, hintText: "Password", icon: Icons.password, isPassword: true,),
              SizedBox(height: Dimensions.height20,),
              Padding(
                padding:  EdgeInsets.only(right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(text: TextSpan(
                      // recognizer: TapGestureRecognizer()..onTap = ()=>Get.back(),
                        text: "Log into your Account",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    )),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30*2,),
              InkWell(onTap: (){
                _login(authCont);
              },
                child: Container(
                  width: Dimensions.ScreenWidth/2,
                  height: Dimensions.ScreenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10*3),
                      color: AppColors.mainColor
                  ),
                  child: Center(child: BigText(text: "Log In",
                    color: Colors.white,
                    size: Dimensions.font20+Dimensions.font20/2,),),
                ),
              ),

              SizedBox(height: Dimensions.ScreenHeight*0.05,),
              RichText(text: TextSpan(
                // recognizer: TapGestureRecognizer()..onTap = ()=>Get.back(),
                  text: "Don't have an account? ",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap =()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                      text: " Sign Up",
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold
                      ),)
                  ]
              )),
            ],
          ),
        ): CustomLoader();
      },),
    );
  }
}
