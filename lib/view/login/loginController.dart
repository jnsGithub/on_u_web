import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_u_web/util/sign.dart';



class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Sign sign = Sign();

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

  isLogin() async {
    return await sign.signIn(idController.text, passwordController.text);
  }
}
