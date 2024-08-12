import 'dart:convert';

import 'package:flavor_jet_food_delivery/data/repository/auth_repository.dart';
import 'package:flavor_jet_food_delivery/model/response_model.dart';
import 'package:flavor_jet_food_delivery/model/signup_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
final AuthRepository authRepo;

AuthController({required this.authRepo});

bool _isLoading = false;
bool get isLoading => _isLoading;

Future<ResponseModel> registration(SignupModel signupModel) async {


  try{
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signupModel);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      if (responseBody['status'] == 'success') {
        // Access the token correctly from responseBody
        String token = responseBody['token'];

        authRepo.saveUserToken(token); // Save the token
        responseModel = ResponseModel(true, token);

        print('Registration successful. Token: $token');
      } else {
        // Handle case where registration was not successful
        String errorMessage = responseBody['message'];
        responseModel = ResponseModel(false, errorMessage);

        print('Error: $errorMessage');
      }
    } else {
      // Handle unexpected status code
      String errorMessage = 'Server error: ${response.statusCode}';
      responseModel = ResponseModel(false, errorMessage);

      print(errorMessage);
    }

    _isLoading = false;
    update();

    return responseModel;
  }catch(e){
    // Handle any exceptions that might occur
    _isLoading = false;
    update(); // Update the loading state

    print('Exception: $e');
    return ResponseModel(false, 'An error occurred. Please try again.');
  }
}

Future<ResponseModel> login(String email, String password) async {
  try{

    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      if (responseBody['status'] == 'success') {

        // Access the token correctly from responseBody
        String token = responseBody['token'];

        authRepo.saveUserToken(token); // Save the token
        responseModel = ResponseModel(true, token);

      } else {
        // Handle case where login was not successful
        String errorMessage = responseBody['message'];
        responseModel = ResponseModel(false, response.statusText!);

       // print('Error: $errorMessage');
      }
    } else {
      // Handle unexpected status code
      String errorMessage = 'Server error: ${response.statusCode}';
      responseModel = ResponseModel(false, errorMessage);

      print(errorMessage);
    }

    _isLoading = false;
    update();

    return responseModel;
  }catch(e){
    // Handle any exceptions that might occur
    _isLoading = false;
    update(); // Update the loading state

    print('Exception: $e');
    return ResponseModel(false, 'An error occurred. Please try again.');
  }
}

void saveUserNumberAndPassword(String number, String password) async {
  authRepo.saveUserNumberAndPassword(number, password);
}

bool userLoggedIn(){
  return authRepo.userLoggedIn();
}

bool clearSharedData(){
  return authRepo.clearSharedData();
}

}