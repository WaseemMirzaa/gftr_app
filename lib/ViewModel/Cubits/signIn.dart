import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/signIn.dart';
import 'package:gftr/View/Screens/LoginPage.dart';

import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import 'package:gftr/ViewModel/prefsService.dart';

abstract class SignInState {}

class SignInInitials extends SignInState {}

class SignInLoading extends SignInState {}

class SignInError extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitials());

  SharedPrefsService prefsService = SharedPrefsService();
  Future<void> signInService(String phoneNumber, String password, String token,
      BuildContext context) async {
    emit(SignInLoading());

    Map<String, dynamic> body = {
      "decData": {
        "phoneNumber": "$countryCodeSelect$phoneNumber",
        "password": password,
        "fcmToken": token
      }
    };

  
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data =
          await DioClient().decryptData(ApiConstants.signIn, response.data!);

      if (data != null) {
        SignIn? signInData = await DioClient().signIn(data.data!);
        print(data.data);
        print(signInData);

        if (signInData != null && signInData.status!) {
          emit(SignInSuccess());
          authorization = signInData.data!.token!;
          prefsService.setStringData('authToken', authorization);
          // flutterToast(signInData.message!, true);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => GfterStoryViewPage()),
              (route) => false);
          bottombarblack = true;
        } else {
          emit(SignInError());
          flutterToast(signInData!.message!, false);
        }
      } else {
        emit(SignInError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(SignInError());
      flutterToast("Something went wrong!", false);
    }
  }
}
