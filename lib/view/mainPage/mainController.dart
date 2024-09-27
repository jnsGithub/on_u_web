import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/util/counseloInfo.dart';
import 'package:on_u_web/view/chat/chatView.dart';
import 'package:on_u_web/view/profile/profileController.dart';
import 'package:on_u_web/view/profile/profileView.dart';
import 'package:on_u_web/view/reservationManagement/reservationManagementView.dart';




class MainController extends GetxController {
  RxList menuItem = ['상담원 정보 관리','상담 예약 관리','회원 채팅 상담','로그아웃'].obs;
  List<IconData> icon = [Icons.person, Icons.check_box, Icons.chat, Icons.logout];
  RxList<Widget> menuWidget = [Profile(),ReservationManagementView(), ChatView(), Profile()].obs;

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
  changeMenu(i) async {
    if(i == 3){
      var controller = Get.find<ProfileController>();
      controller.counselor = await CounselorInfo().getCounselorInfo(uid);
    }
    menuIndex.value = i;
    update();
  }
}
