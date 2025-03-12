import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gftr/View/Screens/google.dart';
import 'package:gftr/ViewModel/Cubits/All_Giftss.dart';
import 'package:gftr/ViewModel/Cubits/Calendar_post.dart';
import 'package:gftr/ViewModel/Cubits/Delete_frds.dart';
import 'package:gftr/ViewModel/Cubits/Mutul_Friends.dart';
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
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'Helper/appConfig.dart';
import 'Model/Instant_data.dart';
import 'Model/Show_data_argument.dart';
import 'ViewModel/Cubits/groupscubit.dart';
import 'ViewModel/Cubits/inviteEmail_cubit.dart';
import 'ViewModel/Cubits/notification.dart';
import 'ViewModel/Cubits/pre-remiend.dart';
import 'ViewModel/Cubits/verifyforgott.dart';
import 'ViewModel/prefsService.dart';

const String homeRoute = "home";
const String showDataRoute = "showData";

Future<InitData> init() async {
  String sharedText = "";
  String routeName = homeRoute;
  //This shared intent work when application is closed
  //-------------------CLOSED BY ME----------------
  // String? sharedValue = await ReceiveSharingIntent.getInitialText();
  String? sharedValue = 'REMOVE THIS LINE PLEASE';
  //-------------------CLOSED BY ME----------------
  if (sharedValue != null) {
    sharedText = sharedValue;
    routeName = showDataRoute;
  }
  return InitData(sharedText, routeName);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    InitData initData = await init();
    runApp(MyApp(initData: initData));
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.initData}) : super(key: key);
  final InitData initData;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _navKey = GlobalKey<NavigatorState>();
  late StreamSubscription _intentDataStreamSubscription;
  SharedPrefsService prefsService = SharedPrefsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    //-------------------CLOSED BY ME----------------
    // _intentDataStreamSubscription =
    //     ReceiveSharingIntent.getTextStream().listen((String value) {
    //   print("memory : $value");
    //   _navKey.currentState!.pushNamed(
    //     showDataRoute,
    //     arguments: ShowDataArgument(value),
    //   );
    // });
    //-------------------CLOSED BY ME----------------

    //-------------------CLOSED BY ME----------------

    // For sharing or opening urls/text coming from outside the app while the app is closed
    // ReceiveSharingIntent.getInitialText().then((String? value) {
    //   print("closed : $value");
    //   _navKey.currentState!.pushNamed(
    //     showDataRoute,
    //     arguments: ShowDataArgument(value!),
    //   );
    // });

    //-------------------CLOSED BY ME----------------
  }

  @override
  void dispose() {
    super.dispose();
    _intentDataStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
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
          navigatorKey: _navKey,
          debugShowCheckedModeBanner: false,
          // home: SplashPage(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case homeRoute:
                return MaterialPageRoute(builder: (_) => SplashPage());
              case showDataRoute:
                {
                  if (settings.arguments != null) {
                    print("you are here");
                    final args = settings.arguments as ShowDataArgument;
                    RegExp urlRegExp = RegExp(r'https?://[^\s]+');
                    final match = urlRegExp.firstMatch(args.sharedText);
                    String dealText = '';
                    String? dealUrl = '';
                    if (match != null) {
                      // Extract the URL
                      dealUrl = match.group(0);

                      // Extract the deal text (excluding the URL)
                      dealText =
                          args.sharedText.substring(0, match.start).trim();
                    }
                    defauilUrl = dealUrl.toString();
                    return MaterialPageRoute(builder: (_) => GooglePage());
                  } else {
                    print("Now you are here");
                    defauilUrl = widget.initData.sharedText;
                    return MaterialPageRoute(builder: (_) => GooglePage());
                  }
                }
            }
            // print("condin :$_rought");
            // if(_rought == 'Google'){
            //   defauilUrl = _sharedText.toString();
            //   print({"else defurl :$defauilUrl"});
            //   return MaterialPageRoute(
            //       builder: (_) => GooglePage());
            // }else {
            //   print("hello");
            //   return MaterialPageRoute(builder: (_) => SplashPage());
            // }
          },
          initialRoute: widget.initData.routeName,
        ));
  }
}
