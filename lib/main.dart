import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/util/counseloInfo.dart';
import 'package:on_u_web/util/sign.dart';
import 'package:on_u_web/view/chat/chatView.dart';
import 'package:on_u_web/view/login/login.dart';
import 'package:on_u_web/view/mainPage/mainPage.dart';
import 'package:flutter/gestures.dart';
import 'package:on_u_web/view/profile/profileController.dart';
import 'package:on_u_web/view/reservationManagement/reservationManagementView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';




void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko', null);  // 'ko'는 한국어 로케일, 필요에 따라 변경

  if(FirebaseAuth.instance.currentUser != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? '';
    Get.put(ProfileController());
    var controller = Get.find<ProfileController>();
    controller.counselor = await CounselorInfo().getCounselorInfo(uid);

  }else{
    Get.put(ProfileController());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      locale: const Locale('ko', 'KR'),
      color: Colors.white,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: false,
          fontFamily: 'Pretendard',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ), elevation: 0
          )
      ),
      initialRoute:'/login',
      getPages: [
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/mainPage', page: () => const MainPage()),
        GetPage(name: '/reservationManagementView', page: () => const ReservationManagementView()),
        GetPage(name: '/chatView', page: () => const ChatView()),
        // GetPage(name: '/loginView', page: () => const LoginView()),
        // GetPage(name: '/signUpView', page: () => const SignUpView()),
        // GetPage(name: '/noticeView', page: () => const NoticeView()),
        // GetPage(name: '/userMainView', page: () => const UserMainView()),
        // GetPage(name: '/confirmView', page: () => const ConfirmView()),
        // GetPage(name: '/useNotifyView', page: () => const UseNotifyView()),
        // GetPage(name: '/usingDetailView', page: () => const UsingDetailView()),
        // GetPage(name: '/myPageView', page: () => const MyPageView()),
        // GetPage(name: '/contactUs', page: () => const ContactUs()),
        // GetPage(name: '/taxiSignUpView', page: () => const TaxiSignUpView()),
        // GetPage(
        //     name: '/taxiImageUpload', page: () => const TaxiImageUploadView()),
        // GetPage(name: '/taxiMainView', page: () => const TaxiMainView()),
        // GetPage(name: '/taxiCallList', page: () => const TaxiCallList()),
        // GetPage(name: '/taxiNotifyView', page: () => const TaxiNotifyView()),
        // GetPage(name: '/taxiAreaView', page: () => const TaxiAreaView()),
        // GetPage(name: '/taxiAccountView', page: () => const TaxiAccountView()),
        // GetPage(name: '/inquiryWrite', page: () => const InquiryWrite()),
        // GetPage(name:'/storeEdit',page:()=> const StoreEdit()),
        // GetPage(name:'/shoppingCartPage',page:()=> const ShoppingCartPage()),
        // GetPage(name:'/itemManagement',page:()=> const ItemManagement()),
        // GetPage(name:'/itemDetailPage',page:()=> const ItemDetailPage()),

        // GetPage(name:'/reportList',page:()=> const ReportList()),
        // GetPage(name:'/reportWrite',page:()=> const ReportWrite()),
        // GetPage(name:'/payPageDetail',page:()=> const PayPageDetail()),
        // GetPage(name: '/customerInfoDetail', page: () => const CustomerInfoDetail()),
        // GetPage(name: '/reportRegistration', page: () => const ReportRegistration()),
        // GetPage(name: '/reportList', page: () => const ReportList()),
        // GetPage(name: '/login', page: () => const LoginView()),
      ],

    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
