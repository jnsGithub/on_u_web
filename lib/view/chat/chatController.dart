import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_u_web/models/chatRoom.dart';
import 'package:on_u_web/models/users.dart';
import 'package:on_u_web/util/chatInfo.dart';
import 'package:on_u_web/util/userInfo.dart';

class ChatController extends GetxController {
  var selectedDay = DateTime.now().obs;
  RxBool isExpanded = false.obs;

  RxInt selectedIndex = 0.obs;

  late int length;

  final ScrollController scrollController = ScrollController();

  RxInt selectValue = (-1).obs;
  RxString chatRoomId = ''.obs;

  late List<Users> userList;
  late List<ChatRoom> chatRoomList;
  RxList item = [].obs;
  late ChatRoom chatRoom;

  UserInfo userInfo = UserInfo();
  ChatInfo chatInfo = ChatInfo();

  late Users selectedUser;

  TextEditingController searchController = TextEditingController();
  TextEditingController chatController = TextEditingController();

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
  RxString name = ''.obs;

  RxBool isExist = false.obs;
  changeExist(){
    isExist.value = false;
    isExist.value = searchController.text.isNotEmpty;
    print(isExist.value);
    if(searchController.text.isEmpty){
      update();
    }
  }
  @override
  void onInit() {
    searchController.addListener(changeExist);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
  }

  void sendChat(String chatRoomId, String chat, String uid) async {
    await chatInfo.sendChat(chatRoomId, chat, uid);
  }

  setExpanded(bool value){
    isExpanded.value = value;
  }

  void a (String a, String b, String uid) async {
    var users = await userInfo.getUserInfo(uid);
    a = users.name;
    b = users.companyName;
    name.value = a;
  }

  void selectUser(String uid)async{
    selectedUser = await userInfo.getUserInfo(uid);
  }
}