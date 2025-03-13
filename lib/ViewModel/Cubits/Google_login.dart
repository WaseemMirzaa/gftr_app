import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Model/GooglelLogin.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/Mobile_Number.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import '../prefsService.dart';

abstract class findingEmailsState {}

class findingEmailsInitials extends findingEmailsState {}

class findingEmailsLoading extends findingEmailsState {}

class findingEmailsError extends findingEmailsState {}

class findingEmailsSuccess extends findingEmailsState {}

class findingEmailsCubit extends Cubit<findingEmailsState> {
  findingEmailsCubit() : super(findingEmailsInitials());
  SharedPrefsService prefsService = SharedPrefsService();
  final Dio _dio = Dio();

  // ViewEventsCubit viewEventsCubit =ViewEventsCubit();

  Future<void> Delete_frdss(BuildContext context,String email,String name,String number) async {
    emit(findingEmailsLoading());
    Map<String, dynamic> body = {
      "decData": {
        "email":email,
        "name":name,
        "number":number,
      }
    };
    print("google friends:${body}");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.find_Email, response.data!);
      if (data != null) {
        log("google is :$data");
        Glogin? glogin = await DioClient().Goole_Login(data.data!);
        if (glogin != null && glogin.status == true) {
          flutterToast(glogin.message.toString(), true);
          if(glogin.message.toString() == "user saved"){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Mobile_number(email: email,);
              },));
          }else if (glogin.message == "You have Google signed-in successfully."){
            authorization = glogin.data?.token ?? '';
            prefsService.setStringData('authToken', authorization);
            // flutterToast(signInData.message!, true);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GfterStoryViewPage()),
                    (route) => false);
            bottombarblack = true;
          }
          emit(findingEmailsSuccess());
          // flutterToast("your data success fully add", false);
        } else {
          emit(findingEmailsError());
          flutterToast(glogin?.message ?? 'he1llo', false);
        }
      } else {
        emit(findingEmailsError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(findingEmailsError());
      flutterToast("Something went wrong!", false);
    }
  }
}