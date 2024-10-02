import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/models/chatRoom.dart';
import 'package:on_u_web/models/users.dart';
import 'package:on_u_web/view/chat/chatController.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatController());
    return Center(
      child: Container(
        width: 854,
        height: 757,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('채팅 상담',style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(height: 21,),
              Container(
                padding: EdgeInsets.only(right: 10),
                width: 296,
                height: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xfffafaff),
                    border: Border.all(width: 1.5, color: gray200
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      height: 40,
                      child: TextField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                            hintText: '이름을 입력하여 검색하세요.',
                            hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: gray400),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10,bottom: 5)
                        ),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 174,
                    child: Column(
                      children: [
                        // TODO : Obx 안쓸거면 지워야함.
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('chatRoom').where('counselorId', isEqualTo: uid).orderBy('lastChatDate', descending: true).snapshots(),
                          builder: (context, snapshot) {
                            // Map<String, dynamic> data = snapshot.data!.docs[0].data();
                            // print(data);
                            // data['documentId'] = snapshot.data!.docs[0].id;
                            // controller.chatRoom = ChatRoom.fromJson(data);
                            if (!snapshot.hasData) {
                              // 로딩 중일 때
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            // print(snapshot.data!.docs
                            //     .where((element) => element.data()['userName'].toString().contains(controller.searchController.text))
                            //     .map((element) => element.data())
                            //     .toList().length);


                            // if(controller.isExist.value){
                            //   controller.item.value = snapshot.data!.docs.where((element) => element.data()['userName'].toString().contains(controller.searchController.text)).toList();
                            // }

                            return Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.isExist.value ?  snapshot.data!.docs.where((element) => element.data()['userName'].toString().contains(controller.searchController.text)).toList().length : snapshot.data!.docs.length < controller.selectedIndex.value * 5 + 5 ? snapshot.data!.docs.length % 5 : 5,
                              itemBuilder: (context, index) {
                                // print(snapshot.data!.docs.where((element) => element.data()['name'].toString().contains(controller.searchController.text)).length);
                                String name = '';
                                String companyName = '';
                                // controller.a(name, companyName, snapshot.data!.docs[index + controller.selectedIndex.value * 5]['userId']);
                                // controller.length = controller.item.length;
                                // controller.item.value = snapshot.data!.docs;
                                // if(controller.isExist.value){
                                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                                //     controller.item.value = snapshot.data!.docs.where((element) => element.data()['userName'].toString().contains(controller.searchController.text)).toList();
                                //   });
                                // }

                                return FutureBuilder(
                                  // future: controller.userInfo.getUserInfo(snapshot.data!.docs[index + controller.selectedIndex.value * 5]['userId']),
                                  future: controller.userInfo.getUserInfo(controller.isExist.value ? snapshot.data!.docs.where((element) => element.data()['userName'].toString().contains(controller.searchController.text)).toList()[index]['userId'] : snapshot.data!.docs[index + controller.selectedIndex.value * 5]['userId']),
                                  builder: (context, snapshot2) {
                                    if (!snapshot2.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    name = snapshot2.data!.name;
                                    companyName = snapshot2.data!.companyName;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Obx(() => GestureDetector(
                                        onTap: (){
                                          controller.chatController.clear();
                                          // controller.chatRoomId = snapshot.data!.docs[index].id;
                                          // controller.chatRoomName = snapshot2.data!.name;
                                          // controller.chatRoomCompany = snapshot2.data!.companyName;
                                          // controller.chatRoomPhotoUrl = snapshot2.data!.photoURL;
                                          if(controller.isExist.value){
                                            controller.selectValue.value = index;
                                            controller.name.value = snapshot.data!.docs.where((element) => element.data()['userName'].toString().contains(controller.searchController.text)).toList()[index]['userId'];
                                            controller.chatRoomId.value = snapshot.data!.docs.where((element) => element.data()['userName'].toString().contains(controller.searchController.text)).toList()[index].id;
                                          }
                                          else{
                                            controller.name.value = snapshot2.data!.name;
                                            controller.selectValue.value = index;
                                            controller.chatRoomId.value = snapshot.data!.docs[index + controller.selectedIndex.value * 5].id;
                                          }
                                          print('채팅방 아이디 : ${controller.chatRoomId.value}');
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                            width: 174,
                                            height: 94,
                                            decoration: BoxDecoration(
                                                color: controller.selectValue.value == index ? mainColor : Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(width: 1.5, color: gray200)
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(name, style: TextStyle(fontSize: 18, color: controller.selectValue.value == index ? Colors.white : Colors.black, fontWeight: FontWeight.w500),),
                                                    Container()
                                                  ],
                                                ),
                                                SizedBox(height: 24,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(companyName, style: TextStyle(fontSize: 15, color: controller.selectValue.value == index ? Colors.white : Colors.black, fontWeight: FontWeight.w500),),
                                                    companyName == '탈퇴한 회원입니다.' ? Container() : Text('1분전')
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.selectValue.value = -1;
                                if(controller.selectedIndex.value == 0){
                                  return;
                                }
                                controller.selectedIndex.value--;
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: bgColor
                                ),
                                child: Icon(Icons.chevron_left),
                              ),
                            ),
                            Obx(() => Text('${controller.selectedIndex.value + 1}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: gray400),)),
                            GestureDetector(
                              onTap: () {
                                controller.selectValue.value = -1;
                                if(controller.length < controller.selectedIndex.value * 5 + 5){
                                  return;
                                }
                                controller.selectedIndex.value++;
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: bgColor
                                ),
                                child: Icon(Icons.chevron_right),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: 665,
                    height: 644,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: const Color(0xffd9d9d9)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: 20,
                        title: Text('새로운 메세지가 도착했습니다.', style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: gray400
                        )),
                      ),
                      body: Obx(() => StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('chat')
                              .where('chatRoomId', isEqualTo: controller.chatRoomId.value)
                              .orderBy('createDate', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (controller.scrollController.hasClients) {
                                  // 데이터를 다 렌더링한 후에 스크롤을 맨 아래로 이동
                                  Future.delayed(Duration(milliseconds: 100), () {
                                    controller.scrollToBottom();
                                  });
                                }
                              });
                            }


                            return ListView.builder(
                              physics: BouncingScrollPhysics(),

                              // padding: EdgeInsets.only(bottom: 70),
                              controller: controller.scrollController,
                              itemCount: snapshot.data?.docs.length ?? 0,
                              itemBuilder: (context, index) {
                                print(controller.name.value);
                                Duration difference = snapshot.data!.docs[index]
                                    .data()['createDate']
                                    .toDate()
                                    .difference(DateTime.now()); // 시간, 분, 초를 나눠서 출력
                                int hours = difference.inHours < 0
                                    ? difference.inHours.abs()
                                    : difference.inHours; // 24시간을 넘는 부분은 나머지로 처리
                                int minutes = difference.inMinutes.remainder(60) < 0
                                    ? difference.inMinutes.remainder(60).abs()
                                    : difference.inMinutes.remainder(60); // 60분을 넘는 부분은 나머지로 처리
                                int seconds = difference.inSeconds.remainder(60) < 0
                                    ? difference.inSeconds.remainder(60).abs()
                                    : difference.inMinutes.remainder(60); // 60초를 넘는 부분은 나머지로 처리
                                return Padding(
                                  padding: snapshot.data!.docs[index].data()['senderId'] != uid
                                      ? EdgeInsets.only(left: 10, bottom: 20)
                                      : EdgeInsets.only(right: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // snapshot.data!.docs[index].data()['senderId'] != uid
                                      //     ? Row(
                                      //   children: [
                                      //   ],
                                      // )
                                      //     : Container(),
                                      SizedBox(width: 8,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: snapshot.data!.docs[index]
                                              .data()['senderId'] != uid ? CrossAxisAlignment
                                              .start : CrossAxisAlignment.end,
                                          children: [
                                            snapshot.data!.docs[index].data()['senderId'] != uid
                                                ? Text(controller.name.value,
                                              style: TextStyle(fontSize: 14,
                                                  color: gray700,
                                                  fontWeight: FontWeight.w400),)
                                                : Container(),
                                            SizedBox(height: 8,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: snapshot.data!.docs[index]
                                                  .data()['senderId'] != uid ? MainAxisAlignment
                                                  .start : MainAxisAlignment.end,
                                              children: [
                                                !snapshot.data!.docs[index].data()['chat'].contains('https://firebasestorage.googleapis.com/')
                                                    ? ChatBubble(
                                                  clipper: ChatBubbleClipper5(
                                                      type: snapshot.data!.docs[index]
                                                          .data()['senderId'] != uid ? BubbleType
                                                          .receiverBubble : BubbleType.sendBubble),
                                                  alignment: snapshot.data!.docs[index]
                                                      .data()['senderId'] != uid
                                                      ? Alignment.topLeft
                                                      : Alignment.topRight,
                                                  backGroundColor: snapshot.data!.docs[index]
                                                      .data()['senderId'] != uid ? bgColor : Color(
                                                      0xffE8F9F4),
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth: MediaQuery.of(context).size.width * 0.5, // 최대 너비 70% 설정
                                                    ),
                                                    child: SelectableLinkify(
                                                      enableInteractiveSelection: true,
                                                      onOpen: (link) async {
                                                        if (await canLaunch(link.url)) {
                                                          await launch(link.url);
                                                        } else {
                                                          throw 'Could not launch $link';
                                                        }
                                                      },
                                                      text: snapshot.data!.docs[index].data()['chat'],
                                                    ),
                                                  ),
                                                )
                                                    : Container(
                                                  height: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    color: snapshot.data!.docs[index].data()['senderId'] != uid ? bgColor : Color(0xffE8F9F4),
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(snapshot.data!.docs[index].data()['chat']),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                snapshot.data!.docs[index]
                                                    .data()['senderId'] != uid ? Text(
                                                  hours > 24
                                                      ? '${(hours / 24).toInt()}일 전'
                                                      : hours > 0 && hours < 24
                                                      ? '${hours}시간 전'
                                                      : minutes > 0 ? '${minutes}분 전'
                                                      : seconds > 0 ? '${seconds}초 전'
                                                      : '방금',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: gray300,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ) : Container(),
                                              ],
                                            ),
                                            SizedBox(width: 8,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                      ),
                      ),
                      bottomNavigationBar: Container(
                          height: 98,
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border.all(width: 4.0, color: const Color(0xffF2F2F7)),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 625,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 500,
                                    child: TextField(
                                      controller: controller.chatController,
                                      decoration: InputDecoration(
                                        hintText: '메세지를 입력하세요.',
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: gray400,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 10),
                                      ),
                                      onSubmitted: (String value) {
                                        if(controller.chatController.text != '') {
                                          controller.sendChat(
                                              controller.chatRoomId.value,
                                              controller.chatController.text,
                                              uid);
                                          controller.chatController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        if(controller.chatController.text != '') {
                                          controller.sendChat(
                                              controller.chatRoomId.value,
                                              controller.chatController.text,
                                              uid);
                                          controller.chatController.clear();
                                        }
                                        controller.selectValue.value = 0;
                                      },
                                      icon: Icon(Icons.send)),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
