import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/models/counselor.dart';
import 'package:on_u_web/models/reservationList.dart';
import 'package:on_u_web/util/counseloInfo.dart';
import 'package:on_u_web/util/reservationInfo.dart';

class ReservationManagementController extends GetxController {
  var selectedDay = DateTime.now().obs;
  RxBool isExpanded = false.obs;

  CounselorInfo counselorInfo = CounselorInfo();

  late RxList<ReservationList> reservationList = <ReservationList>[].obs;
  ReservationInfo reservationInfo = ReservationInfo();
  RxList<DateTime> holyday = <DateTime>[].obs;

  bool isReservationExist = true;

  late Counselor counselor;


  List<int> timeList = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18];

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    reservationList.value = await reservationInfo.getReservationList();
    counselor = await counselorInfo.getCounselorInfo(uid);
    holyday.value = counselor.holyDate;
    for(var i in reservationList){
      print(i.createDate);
    }
    update();
  }

  bool isHolyDay(DateTime date){
    for(var i in holyday){
      if(i.year == date.year && i.month == date.month && i.day == date.day){
        return true;
      }
    }
    return false;
  }
  bool isReservation(DateTime date){
    for(var i in reservationList){
      if(i.createDate.year == date.year && i.createDate.month == date.month && i.createDate.day == date.day){
        return true;
      }
    }
    return false;
  }

  void setHolyday(DateTime date) async{
    await counselorInfo.setHolyDate(uid, date);
    counselor = await counselorInfo.getCounselorInfo(uid);
    holyday.value = counselor.holyDate;
    update();
  }

  void deleteReservation(String documentId) async {
    await reservationInfo.deleteReservation(documentId);
    reservationList.value = await reservationInfo.getReservationList();
    update();
  }

  setExpanded(bool value){
    isExpanded.value = value;
  }

  void cancelReservationDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white, // 배경 흰색으로 설정
          child: Container(
            width: 442,
            height: 285,
            decoration: BoxDecoration(
              color: Colors.white, // 다이얼로그 내부 배경색 흰색으로 설정
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Column(
                  children: [
                    Text(
                      '예약을 취소하시겠습니까?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '(예약 취소 후 되돌릴 수 없습니다.)',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back(); // 취소 버튼 동작 후 다이얼로그 닫기
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  color: gray500,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 78,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              deleteReservation(documentId);
                              Get.back(); // 확인 버튼 동작 후 다이얼로그 닫기
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                '확인',
                                style: TextStyle(
                                  color: typoColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  void holydayDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white, // 배경 흰색으로 설정
          child: Container(
            width: 442,
            height: 285,
            decoration: BoxDecoration(
              color: Colors.white, // 다이얼로그 내부 배경색 흰색으로 설정
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                isReservationExist ? Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      '해당 일자를 휴무일로 지정하시겠습니까?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
                : Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      '기존 예약이 존재하면, 해당 일자를',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '휴무일로 지정할 수 없습니다.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),
                    isReservationExist ? Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back(); // 확인 버튼 동작 후 다이얼로그 닫기
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  color: gray500,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 78,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setHolyday(selectedDay.value);
                              Get.back(); // 확인 버튼 동작 후 다이얼로그 닫기
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                '확인',
                                style: TextStyle(
                                  color: typoColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) : GestureDetector(
                      onTap: () {
                        Get.back(); // 확인 버튼 동작 후 다이얼로그 닫기
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        height: 78,
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: typoColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
  }
}