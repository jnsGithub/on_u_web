import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_web/global.dart';
import 'mainController.dart';





class MainPage extends GetView<MainController> {
  const MainPage ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.lazyPut(() => MainController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:

        Container(
          width: size.width,
          height: size.height,
          child: Row(
            children: [
              Container(
                width: 292,
                height: size.height,
                decoration: BoxDecoration(
                  color: bgColor,
                ),
                child:  Column(
                  children: [
                    SizedBox(height: 60,),
                    Container(
                      width: 146,
                      height: 75,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.fitWidth
                          )
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('상담원 전용 웹', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: typoColor),),
                    SizedBox(height: 40,),
                    SizedBox(
                      width: 300,
                      height: 500,
                      child:
                        ListView.builder(
                            itemCount: controller.menuItem.length,
                            itemBuilder: (context, index) {
                              return Obx(()=>
                                GestureDetector(
                                  onTap: (){
                                    controller.changeMenu(index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 40),
                                    decoration: BoxDecoration(
                                        color: controller.menuIndex.value == index? mainColor:null
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(controller.icon[index], size: 25, color: controller.menuIndex.value == index? Colors.white : null,),
                                        SizedBox(width: 20,),
                                        Text('${controller.menuItem[index]}',style:
                                        TextStyle(
                                            color: controller.menuIndex.value == index? Colors.white : null,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                    TextButton(
                        onPressed: (){
                          // storage.deleteAll();
                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         MyHomePage(title: '')), (route) => false);
                        },
                        child: const Text('로그아웃',style: TextStyle(color: Colors.white),)
                    )
                  ],
                ),
              ),
              Expanded(
                child: controller.menuWidget[controller.menuIndex.value],
              )
            ],
          ),
        ),
      ),
    );
  }
}
