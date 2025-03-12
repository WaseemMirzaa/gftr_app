// import 'dart:async';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gftr/View/Screens/spalsh.dart';
// import 'package:gftr/ViewModel/Cubits/GetGifted/getGiftedDelete_dart.dart';
// import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_rename.dart';
// import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
// import 'package:gftr/ViewModel/Cubits/addform_cubit.dart';
// import 'package:gftr/ViewModel/Cubits/builGroup.dart';
// import 'package:gftr/ViewModel/Cubits/contactGftr.dart';
// import 'package:gftr/ViewModel/Cubits/contactVerfy.dart';
// import 'package:gftr/ViewModel/Cubits/folderSetting.dart';
// import 'package:gftr/ViewModel/Cubits/folderview_cubit.dart';
// import 'package:gftr/ViewModel/Cubits/forgotPassword.dart';
// import 'package:gftr/ViewModel/Cubits/getContact.dart';
// import 'package:gftr/ViewModel/Cubits/getGifting.dart';
// import 'package:gftr/ViewModel/Cubits/gftrStories.dart';
// import 'package:gftr/View/Screens/addTo.dart';
// import 'package:gftr/ViewModel/Cubits/GetGifted/getgifted_cubit.dart';
// import 'package:gftr/ViewModel/Cubits/groupscubit.dart';
// import 'package:gftr/ViewModel/Cubits/newPassword.dart';
// import 'package:gftr/ViewModel/Cubits/resend_cubit.dart';
// import 'package:gftr/ViewModel/Cubits/signIn.dart';
// import 'package:gftr/ViewModel/Cubits/signUp.dart';
// import 'package:gftr/ViewModel/Cubits/upatedinvet.dart';
// import 'package:gftr/ViewModel/Cubits/verifyOtp.dart';
// import 'package:metadata_extract/metadata_extract.dart';
// import 'package:http/http.dart' as http;
// import 'package:receive_sharing_intent/receive_sharing_intent.dart';
// import 'ViewModel/Cubits/notification.dart';
// import 'ViewModel/Cubits/verifyforgott.dart';
//
// int shareTextIndex = 0;
// String shareImage = '';
// File? imageFile;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   String? sharedText;
//   late StreamSubscription _intentDataStreamSubscription;
//
//   fetchData({required String url}) async {
//     print('uri : ${url}');
//     var response = await http.get(Uri.parse(url));
//     var document = responseToDocument(response);
//
//     var data = MetadataParser.parse(document);
//     shareImage = data.image.toString();
//     print('ShareImage : $shareImage');
//     print(data.toString());
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//    super.initState();
//     _intentDataStreamSubscription =
//         ReceiveSharingIntent.getTextStream().listen((String value) {
//           setState(() {
//             sharedText = value;
//             print("Shared: $sharedText");
//           });
//         }, onError: (err) {
//           print("getLinkStream error: $err");
//         });
//
//     ReceiveSharingIntent.getInitialText().then((String? value) {
//       setState(() {
//         sharedText = value;
//         print("Shared: $sharedText");
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.resumed) {
//       setState(() {
//         print("Resume B :  $sharedText");
//         print("ResumeIndex B :  $shareTextIndex");
//         sharedText == null ? shareTextIndex = 0 : shareTextIndex = 1;
//         fetchData(url: sharedText ?? '');
//         print("Resume A :  $sharedText");
//         print("ResumeIndex A :  $shareTextIndex");
//       });
//     } else if (state == AppLifecycleState.paused) {
//       print("PausedIndex B :  $shareTextIndex");
//       print("paused B : $sharedText");
//       setState(() {
//         shareTextIndex = 0;
//         sharedText = null;
//         print("paused A : $sharedText");
//         print("PausedIndex A :  $shareTextIndex");
//       });
//     } else if (state == AppLifecycleState.inactive) {
//       print('inactive');
//       setState(() {});
//     } else if (state == AppLifecycleState.detached) {
//       print('detached');
//       setState(() {
//         shareTextIndex = 0;
//         sharedText = null;
//       });
//     } else {
//       print('Else : $state');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => SignUpCubit()),
//           BlocProvider(create: (context) => SignInCubit()),
//           BlocProvider(create: (context) => VerifyOtpCubit()),
//           BlocProvider(create: (context) => NewPasswordCubit()),
//           BlocProvider(create: (context) => ForgotPassCubit()),
//           BlocProvider(create: (context) => ContactGftrCubit()),
//           BlocProvider(create: (context) => GftrStoriesCubit()),
//           BlocProvider(create: (context) => GetGiftedCubit()),
//           BlocProvider(create: (context) => AddToCubit()),
//           BlocProvider(create: (context) => GetGiftedViewCubit()),
//           BlocProvider(create: (context) => GetGiftedDeleteCubit()),
//           BlocProvider(create: (context) => FolderViewDeleteCubit()),
//           BlocProvider(create: (context) => ContactVierfyCubit()),
//           BlocProvider(create: (context) => VerifyForgotOtpCubit()),
//           BlocProvider(create: (context) => ResendOtpCubit()),
//           BlocProvider(create: (context) => FolderRenameCubit()),
//           BlocProvider(create: (context) => FolderSettingCubit()),
//           BlocProvider(create: (context) => BuildGroupCubit()),
//           BlocProvider(create: (context) => NotificationViewCubit()),
//           BlocProvider(create: (context) => UpadetInviteCubit()),
//           BlocProvider(create: (context) => GetgifingCubit()),
//           BlocProvider(create: (context) => GetContactViewCubit()),
//           BlocProvider(create: (context) => GroupViewCubit()),
//         ],
//         child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: sharedText == null ? SplashPage() : AddTo()));
//   }
// }

// class SAMPLEXAMPLE extends StatefulWidget {
//   const SAMPLEXAMPLE({Key? key}) : super(key: key);
//
//   @override
//   State<SAMPLEXAMPLE> createState() => _SAMPLEXAMPLEState();
// }
//
// class _SAMPLEXAMPLEState extends State<SAMPLEXAMPLE> {
//   List color = [
//     Colors.red,
//     Colors.amber,
//     Colors.purple,
//     Colors.green,
//     Colors.teal,
//     Colors.orange,
//   ];
//   int item = 4;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: item,
//         itemBuilder: (context, index) {
//           return Container(
//           height: 100,
//           margin: EdgeInsets.all(10),
//           color: color[index % color.length],
//         );
//         },
//       ),
//     );
//   }
// }
