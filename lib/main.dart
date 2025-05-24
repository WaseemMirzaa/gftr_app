import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gftr/NotificationService/notification_service.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/ViewModel/Cubits/All_Giftss.dart';
import 'package:gftr/ViewModel/Cubits/Calendar_post.dart';
import 'package:gftr/ViewModel/Cubits/Delete_frds.dart';
import 'package:gftr/ViewModel/Cubits/Mutul_Friends.dart';
import 'package:gftr/ViewModel/Cubits/fcm_token_cubit.dart';
import 'package:gftr/ViewModel/Cubits/mobile_Auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/View/Screens/spalsh.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getGiftedDelete_dart.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_rename.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/Cubits/Msgnotifications.dart';
import 'package:gftr/ViewModel/Cubits/addform_cubit.dart';
import 'package:gftr/ViewModel/Cubits/builGroup.dart';
import 'package:gftr/ViewModel/Cubits/contactGftr.dart';
import 'package:gftr/ViewModel/Cubits/contactVerfy.dart';
import 'package:gftr/ViewModel/Cubits/events_view.dart';
import 'package:gftr/ViewModel/Cubits/folderSetting.dart';
import 'package:gftr/ViewModel/Cubits/folderview_cubit.dart';
import 'package:gftr/ViewModel/Cubits/forgotPassword.dart';
import 'package:gftr/ViewModel/Cubits/getContact.dart';
import 'package:gftr/ViewModel/Cubits/getGifting.dart';
import 'package:gftr/ViewModel/Cubits/gftrStories.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_cubit.dart';
import 'package:gftr/ViewModel/Cubits/groupnotificationreply.dart';
import 'package:gftr/ViewModel/Cubits/markgifed_cubit.dart';
import 'package:gftr/ViewModel/Cubits/newPassword.dart';
import 'package:gftr/ViewModel/Cubits/resend_cubit.dart';
import 'package:gftr/ViewModel/Cubits/setting_cubit.dart';
import 'package:gftr/ViewModel/Cubits/signIn.dart';
import 'package:gftr/ViewModel/Cubits/signUp.dart';
import 'package:gftr/ViewModel/Cubits/upatedinvet.dart';
import 'package:gftr/ViewModel/Cubits/verifyOtp.dart';
import 'package:gftr/ViewModel/Cubits/view_users.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'Model/Instant_data.dart';
import 'ViewModel/Cubits/groupscubit.dart';
import 'ViewModel/Cubits/inviteEmail_cubit.dart';
import 'ViewModel/Cubits/notification.dart';
import 'ViewModel/Cubits/pre-remiend.dart';
import 'ViewModel/Cubits/verifyforgott.dart';
import 'ViewModel/prefsService.dart';
import 'firebase_options.dart';

const String homeRoute = "home";
const String showDataRoute = "showData";
final notificationRouteKey = GlobalKey<NavigatorState>();

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;

  // Remove or comment out the shared value assignment since it's causing issues
  // String? sharedValue = 'REMOVE THIS LINE PLEASE';
  // if (sharedValue != null) {
  //   sharedText = sharedValue;
  //   routeName = showDataRoute;
  // }

  return InitData(sharedText, routeName);
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices sp = NotificationServices();

  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  // 3️⃣  Instantiate services / cubits
  final notificationServices = NotificationServices();  // singleton
  final fcmCubit = FcmTokenCubit();

  // 4️⃣  Retrieve the token (can be null on first launch)
  final String fcmToken = await notificationServices.messaging.getToken() ?? '';
  print('🔑 FCM token (main): $fcmToken');
  fcmCubit.setFcmToken(fcmToken);
  print("fcmToken from main page $fcmToken");

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    InitData initData = await init();
    runApp(MyApp(
      initData: initData,
      fcmCubit: fcmCubit,
    ));
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.initData, required this.fcmCubit})
      : super(key: key);
  final InitData initData;
  final FcmTokenCubit fcmCubit;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _navKey = GlobalKey<NavigatorState>();
  SharedPrefsService prefsService = SharedPrefsService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initNotificationForeGround();
  }


    initNotificationForeGround()async{
      await NotificationServices().initialise(context);
    }

  

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: widget.fcmCubit),
          BlocProvider(create: (context) => MutualFrdsCubit()),
          BlocProvider(create: (context) => SignUpCubit()),
          BlocProvider(create: (context) => SignInCubit()),
          BlocProvider(create: (context) => VerifyOtpCubit()),
          BlocProvider(create: (context) => NewPasswordCubit()),
          BlocProvider(create: (context) => ForgotPassCubit()),
          BlocProvider(create: (context) => ContactGftrCubit()),
          BlocProvider(create: (context) => GftrStoriesCubit()),
          BlocProvider(create: (context) => GetGiftedCubit()),
          BlocProvider(create: (context) => AddToCubit()),
          BlocProvider(create: (context) => GetGiftedViewCubit()),
          BlocProvider(create: (context) => GetGiftedDeleteCubit()),
          BlocProvider(create: (context) => FolderViewDeleteCubit()),
          BlocProvider(create: (context) => ContactVierfyCubit()),
          BlocProvider(create: (context) => VerifyForgotOtpCubit()),
          BlocProvider(create: (context) => ResendOtpCubit()),
          BlocProvider(create: (context) => FolderRenameCubit()),
          BlocProvider(create: (context) => FolderSettingCubit()),
          BlocProvider(create: (context) => BuildGroupCubit()),
          BlocProvider(create: (context) => NotificationViewCubit()),
          BlocProvider(create: (context) => UpadetInviteCubit()),
          BlocProvider(create: (context) => GetgifingCubit()),
          BlocProvider(create: (context) => GetContactViewCubit()),
          BlocProvider(create: (context) => GroupViewCubit()),
          BlocProvider(create: (context) => GroupReplyNotificationCubit()),
          BlocProvider(create: (context) => MarkGiftCubit()),
          BlocProvider(create: (context) => SettingCubit()),
          BlocProvider(create: (context) => PreRimendCubit()),
          BlocProvider(create: (context) => ViewSettingCubit()),
          BlocProvider(create: (context) => UsersviewsCubit()),
          BlocProvider(create: (context) => ViewEventsCubit()),
          BlocProvider(create: (context) => MessagnotiCubit()),
          BlocProvider(create: (context) => InviteEmialCubit()),
          BlocProvider(create: (context) => DeleteFriendsCubit()),
          BlocProvider(create: (context) => CalendarPostsCubit()),
          BlocProvider(create: (context) => Mobile_AuthCubit()),
          BlocProvider(create: (context) => Fetch_All_GiftsCubit()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            canvasColor: Colors.white,
            colorScheme: ColorScheme.light(
              background: Colors.white,
            ),

            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
            ),
            // Add this to ensure the background is white
            // : Colors.white,
          ),
          navigatorKey: _navKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case homeRoute:
                return MaterialPageRoute(builder: (_) => SplashPage());
              case showDataRoute:
                if (widget.initData.sharedText.isNotEmpty) {
                  defauilUrl = widget.initData.sharedText;
                  return MaterialPageRoute(builder: (_) => GooglePage());
                }
                return MaterialPageRoute(builder: (_) => SplashPage());
              default:
                return MaterialPageRoute(builder: (_) => SplashPage());
            }
          },
          initialRoute: homeRoute, // Always start with homeRoute
        ));
  }
}
