import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    passwordController.dispose();
    idController.dispose();
    super.onClose();
  }
}
