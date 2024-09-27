
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/models/counselor.dart';
import 'package:on_u_web/util/counseloInfo.dart';




class ProfileController extends GetxController with GetTickerProviderStateMixin {
  CounselorInfo counselorInfo = CounselorInfo();

  late Counselor counselor;

  TextEditingController nameContoller = TextEditingController();
  TextEditingController infoController = TextEditingController();

  List<String?> possibleMorningTime = [];
  List<String?> possibleAfternoonTime = [];

  List<String> reservationMorning = ['08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30'];
  List<String> reservationAfternoon = ['12:00', '12:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00', '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00'];

  List<String> totalReservationTime = [
    '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
    '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00'
  ];

  RxList<bool> reservationMorningTimeCheck = RxList<bool>([false, false, false, false, false, false, false, false]);
  RxList<bool> reservationAfternoonTimeCheck = RxList<bool>([false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]);

  late RxList<bool> totalReservationTimeCheck = RxList<bool>([...reservationMorningTimeCheck, ...reservationAfternoonTimeCheck]);


  Rx<Uint8List?> image = Rx<Uint8List?>(null);

  void pickImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files?.isNotEmpty ?? false) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files![0]);
        reader.onLoadEnd.listen((e) {
          image.value = reader.result as Uint8List?;
        });
      }
    });
  }

  void updateCounselorInfo(List<String?> morning, List<String?> after) async {
    String? photoURL = await counselorInfo.uploadImageAndGetUrl(image, uid);
    await counselorInfo.updateCounselorInfo(uid, nameContoller.text, infoController.text, image.value != null ? photoURL : null, after, morning);
    counselor = await counselorInfo.getCounselorInfo(uid);
    Get.snackbar('알림', '상담원 정보가 수정되었습니다.');
  }



  @override
  void onInit() async {
    super.onInit();
    init();
  }
  @override
  void onClose(){

    super.onClose();
  }

  init() async {
    counselor = await counselorInfo.getCounselorInfo(uid);
    nameContoller.text = counselor.name;
    infoController.text = counselor.body;
    print(counselor.name);
    print(nameContoller.text);

    print(counselor.photoURL);
    possibleMorningTime = counselorInfo.convertList(List<String>.from(counselor.possibleTime['morning']), reservationMorning);
    possibleAfternoonTime = counselorInfo.convertList(List<String>.from(counselor.possibleTime['afternoon']), reservationAfternoon);
    for(int i = 0; i < reservationMorning.length; i++){
      for(int j = 0; j < possibleMorningTime.length; j++){
        if(reservationMorning[i] == possibleMorningTime[j]){
          reservationMorningTimeCheck[i] = true;
        }
      }
    }
    for(int i = 0; i < reservationAfternoon.length; i++){
      for(int j = 0; j < possibleAfternoonTime.length; j++){
        if(reservationAfternoon[i] == possibleAfternoonTime[j]){
          reservationAfternoonTimeCheck[i] = true;
        }
      }
    }
    print(possibleMorningTime);
    print(possibleAfternoonTime);
  }

  timeSettingDialog() {
    try {
      // 상태 초기화
      RxList<bool> morningTimeCheck = RxList<bool>([...reservationMorningTimeCheck]);
      RxList<bool> afternoonTimeCheck = RxList<bool>([...reservationAfternoonTimeCheck]);

      List<String?> selectPossibleMorningTime = possibleMorningTime.isNotEmpty ? List<String?>.from(possibleMorningTime) : [];
      List<String?> selectPossibleAfternoonTime = possibleAfternoonTime.isNotEmpty ? List<String?>.from(possibleAfternoonTime) : [];

      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Container(
              padding: EdgeInsets.only(left: 46, top: 55, right: 46),
              width: 851,
              height: 523,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('상담 가능 시간 설정', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(mainColor),
                          minimumSize: WidgetStatePropertyAll(Size(58, 39)),
                        ),
                        onPressed: () {
                          // 최종적으로 변경된 상태를 할당
                          reservationMorningTimeCheck.assignAll(morningTimeCheck);
                          reservationAfternoonTimeCheck.assignAll(afternoonTimeCheck);
                          possibleMorningTime = sorting(selectPossibleMorningTime);
                          possibleAfternoonTime = sorting(selectPossibleAfternoonTime);
                          print(selectPossibleAfternoonTime);
                          print('가능한 시간대임 : ${possibleMorningTime}');
                          print('오전 전체 시간대임 : ${reservationMorning}');
                          // counselorInfo.convertList(possibleAfternoonTime, reservationAfternoon);
                          Get.back();
                        },
                        child: Text('저장', style: TextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text('상담 가능 시간을 선택하고,', style: TextStyle(fontSize: 17, color: gray600, fontWeight: FontWeight.w500)),
                      Text('저장 버튼', style: TextStyle(fontSize: 17, color: mainColor, fontWeight: FontWeight.w500)),
                      Text('을 눌러주세요.', style: TextStyle(fontSize: 17, color: gray600, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(height: 47),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('오전'),
                      SizedBox(height: 18),
                      SizedBox(
                        width: 700,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 8,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.5,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                morningTimeCheck[index] = !morningTimeCheck[index];
                                if (morningTimeCheck[index]) {
                                  selectPossibleMorningTime.add(reservationMorning[index]);
                                } else {
                                  selectPossibleMorningTime.remove(reservationMorning[index]);
                                }
                              },
                              child: Obx(
                                    () => Container(
                                  alignment: Alignment.center,
                                  width: 76,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: morningTimeCheck[index] ? mainColor : Color(0xffF6F6F9),
                                    border: Border.all(width: 1.5, color: gray100),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    reservationMorning[index],
                                    style: TextStyle(color: morningTimeCheck[index] ? Colors.white : Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('오후'),
                      SizedBox(height: 18),
                      SizedBox(
                        width: 700,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 21,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.5,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                afternoonTimeCheck[index] = !afternoonTimeCheck[index];
                                if (afternoonTimeCheck[index]) {
                                  selectPossibleAfternoonTime.add(reservationAfternoon[index]);
                                } else {
                                  selectPossibleAfternoonTime.remove(reservationAfternoon[index]);
                                }
                              },
                              child: Obx(
                                    () => Container(
                                  alignment: Alignment.center,
                                  width: 76,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: afternoonTimeCheck[index] ? mainColor : Color(0xffF6F6F9),
                                    border: Border.all(width: 1.5, color: afternoonTimeCheck[index] ? Colors.white : gray100),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    reservationAfternoon[index],
                                    style: TextStyle(color: afternoonTimeCheck[index] ? Colors.white : Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  List<String?> sorting(List<String?> b){
    int n = b.length;
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (int.parse(b[j]!.split(':')[0] + b[j]!.split(':')[1]) > int.parse(b[j + 1]!.split(':')[0] + b[j + 1]!.split(':')[1])) {
          String temp = b[j]!;
          b[j] = b[j + 1];
          b[j + 1] = temp;
        }
      }
    }
    return b;
  }
}
