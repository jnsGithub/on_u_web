import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_u_web/view/profile/profileView.dart';




class MainController extends GetxController {
  RxList menuItem = ['상담원 정보 관리','상담 예약 관리','회원 채팅 상담','로그아웃'].obs;
  List<IconData> icon = [Icons.person, Icons.check_box, Icons.chat, Icons.logout];
  RxList menuWidget = [Profile(),Profile(),Profile(),Profile()].obs;

  //[UserPage(),StorePage(),PaymentPage(),CalculatePage()];
  RxInt menuIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose(){
    super.onClose();
  }
  changeMenu(i) {
    menuIndex.value = i;
    update();
  }
}
