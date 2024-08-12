import 'package:flavor_jet_food_delivery/base/custom_loader.dart';
import 'package:flavor_jet_food_delivery/base/show_custom_snackBar.dart';
import 'package:flavor_jet_food_delivery/controllers/auth_Controller.dart';
import 'package:flavor_jet_food_delivery/model/signup_model.dart';
import 'package:flavor_jet_food_delivery/pages/auth/log_in.dart';
import 'package:flavor_jet_food_delivery/routes/route_helper.dart';
import 'package:flavor_jet_food_delivery/utils/appColor.dart';
import 'package:flavor_jet_food_delivery/utils/dimensions.dart';
import 'package:flavor_jet_food_delivery/widgets/app_textField.dart';
import 'package:flavor_jet_food_delivery/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_snackBar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var SignUpImage = ["t.png","f.png","c.png"];


    void _registration(AuthController authController){

      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title: "Name");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in valid email address",title: "Enter Valid Email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("your password can't be less then 6 characters",title: "Enter Valid Password");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: "Phone number");
      }else{
        print("SignupModel data: Name=$name, Email=$email, Password=$password, Phone=$phone");
        // showCustomSnackBar1("All is Well",title: "Sign Up Successfully");
        SignupModel signupModel= SignupModel(
            name: name,
            email: email,
            password: password,
            phone: phone
        );
        authController.registration(signupModel).then((status){
          if(status.isSuccess){
            print("Success Registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authCount){
        return !_authCount.isLoading? SingleChildScrollView(
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
              AppTextField(controller: nameController, hintText: "Name", icon: Icons.person,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(controller: emailController, hintText: "Email", icon: Icons.email,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(controller: passwordController, hintText: "Password", icon: Icons.password, isPassword: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(controller: phoneController , hintText: "Phone", icon: Icons.phone,),
              SizedBox(height: Dimensions.height20,),
              InkWell(onTap: (){
                _registration(_authCount);
                // Get.to(()=>LogInPage());
              },
                child: Container(
                  width: Dimensions.ScreenWidth/2,
                  height: Dimensions.ScreenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius10*3),
                      color: AppColors.mainColor
                  ),
                  child: Center(child: BigText(text: "Sign Up",
                    color: Colors.white,
                    size: Dimensions.font20+Dimensions.font20/2,),),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(text: TextSpan(
                // recognizer: TapGestureRecognizer()..onTap = ()=>Get.back(),
                  text: "Have an Account?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap =()=>Get.to(()=>LogInPage(),transition: Transition.fade),
                        text: " Log In",
                        style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: Dimensions.font20
                        )
                    )
                  ]
              )),
              SizedBox(height: Dimensions.ScreenHeight*0.01,),
              RichText(text: TextSpan(
                //  recognizer: TapGestureRecognizer()..onTap = ()=>Get.back(),
                  text: "Sign Up Using One of the Following Options",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font15
                  )
              )),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius15+Dimensions.radius10,
                    backgroundImage: AssetImage("assets/images/"+SignUpImage[index]),
                  ),
                )),
              )
            ],
          ),
        ):CustomLoader();
      },),
    );
  }
}
