import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/view/profile/profileController.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => ProfileController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 400, right: 400),
        child: Container(
          width: 780,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(mainColor),
                      minimumSize: WidgetStatePropertyAll(Size(58, 37)),
                    ),
                      onPressed: (){
                        var a = controller.possibleMorningTime;
                        var b = controller.reservationMorning;
                        var c = controller.possibleAfternoonTime;
                        var d = controller.reservationAfternoon;
                        controller.updateCounselorInfo(controller.counselorInfo.convertList(a, b), controller.counselorInfo.convertList(c, d));
                      },
                      child: Text('저장', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),),
                ),
                Obx(() =>  Container(
                    width: 94,
                    height: 94,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(47)),
                      image: DecorationImage(
                        image: controller.image.value != null
                            ? MemoryImage(controller.image.value!)
                            : controller.counselor.photoURL != ''
                            ? NetworkImage(controller.counselor.photoURL)
                            : AssetImage('images/profile.png') as ImageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(BorderSide(color: gray100)),
                    backgroundColor: WidgetStatePropertyAll(Color(0xffF2F2F2)),
                    minimumSize: WidgetStatePropertyAll(Size(142, 40)),
                  ),
                    onPressed: () async {
                      controller.pickImage();
                      if(!Get.isSnackbarOpen){
                        Get.snackbar('경고', '저장 버튼을 누르지 않으면 기입한 내용이 사라집니다.', duration: Duration(seconds: 3), backgroundColor: Colors.red, colorText: Colors.white, );
                      }
                    },
                    child: Text('프로필 사진 편집', style: TextStyle(fontSize: 17, color: gray500, fontWeight: FontWeight.w500),)
      
                ),
                SizedBox(height: 55,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이름', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gray500),),
                    SizedBox(height: 17,),
                    Container(
                      width: 800,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: gray400),
                          borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        maxLines: 1,
                        controller: controller.nameContoller,
                        decoration: InputDecoration(
                          hintText: '상담원 이름입니다.',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('상담원 소개', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gray500),),
                    SizedBox(height: 17,),
                    Container(
                      width: 800,
                      height: 139,
                      decoration: BoxDecoration(
                        border: Border.all(color: gray400),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        maxLines: 10,
                        controller: controller.infoController,
                        decoration: InputDecoration(
                            hintText: '소개입니다.',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                SizedBox(
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('상담 가능 시간 설정', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gray500),),
                      ElevatedButton(
                        style: ButtonStyle(
                          side: WidgetStatePropertyAll(BorderSide(color: gray100)),
                          backgroundColor: WidgetStatePropertyAll(Color(0xffF6F6F9)),
                          minimumSize: WidgetStatePropertyAll(Size(86, 36)),
                        ),
                        onPressed: (){
                          controller.timeSettingDialog();
                        },
                        child: Text('시간 편집', style: TextStyle(fontSize: 15, color: typoColor, fontWeight: FontWeight.w600),)
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('오전'),
                    SizedBox(height: 12,),
                    SizedBox(
                      width: 800,
                      height: 50,
                      child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.reservationMorningTimeCheck.where((value) => value == true).length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container(
                                    width: 76,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF6F6F9),
                                      border: Border.all(color: gray100),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text(controller.possibleMorningTime[index] ?? '', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gray500),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('오후'),
                    SizedBox(height: 12,),
                    SizedBox(
                      width: 800,
                      height: 50,
                      child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.reservationAfternoonTimeCheck.where((value) => value == true).length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Container(
                                  width: 76,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6F6F9),
                                    border: Border.all(color: gray100),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(controller.possibleAfternoonTime[index] ?? '', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: gray500),),
                                  ),
                                ),
                                SizedBox(width: 10,),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
