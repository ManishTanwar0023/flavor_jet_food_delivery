import 'dart:convert';

import 'package:get/get.dart';

import '../data/repository/user_repository.dart';
import '../model/response_model.dart';
import '../model/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;

  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    try {
      Response response = await userRepo.getUserInfo();
      late ResponseModel responseModel;

      if (response.statusCode == 200) {

          _userModel = UserModel.fromJson(response.body);
          _isLoading = true;
          responseModel = ResponseModel(true, "successful");

      } else {
        // Handle unexpected status code
        String errorMessage = 'Server error: ${response.statusCode}';
        responseModel = ResponseModel(false, errorMessage);

        print(errorMessage);
      }


      update();

      return responseModel;
    } catch (e) {
      // Handle any exceptions that might occur
      _isLoading = false;
      update(); // Update the loading state

      print('Exception: $e');
      return ResponseModel(false, 'An error occurred. Please try again.');
    }
  }
}