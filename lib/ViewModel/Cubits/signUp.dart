import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/signUp.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/verfiyEmail.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class SignUpState {}

class SignUpInitials extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitials());

  Future<void> signUpService(
      {required String email,
      //required String firstName,
      required String firstname,
     // required String lastName,
      required String lastname,
      required String phoneNumber,
      required String password,
      required String confirmPassword,
      required String fcmToken,
      required BuildContext context}) async {
    emit(SignUpLoading());

    Map<String, dynamic> body = {
     "decData": {
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "phoneNumber": "$countryCodeSelect$phoneNumber",
        "confirmPassword": confirmPassword, 
        "fcmToken" : fcmToken
     }
    };
    print("Body is $body");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.signUp, response.data!);
      if (data != null) {
        SignUp? signUpData = await DioClient().signUp(data.data!);
        log('message : ${signUpData?.status}');
        if (signUpData != null && signUpData.status!) {
          emit(SignUpSuccess());
          flutterToast(signUpData.message!, true);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyPhone(screenIndex: 1, phoneNumber: phoneNumber)));
        }
        else {
          emit(SignUpError());
          flutterToast(signUpData!.message!, false);
        }
      } else {
        emit(SignUpError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(SignUpError());
      flutterToast("Something went wrong!", false);
    }
  }
}
