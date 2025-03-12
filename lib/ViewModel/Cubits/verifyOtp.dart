
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/verifyOtp.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/welcome.dart';
import 'package:gftr/View/Widgets/bottomNavigationBar.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import 'package:gftr/ViewModel/prefsService.dart';

abstract class VerifyOtpState{}

class VerifyOtpInitials extends VerifyOtpState{}
class VerifyOtpLoading extends VerifyOtpState{}
class VerifyOtpError extends VerifyOtpState{}
class VerifyOtpSuccess extends VerifyOtpState{}


class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitials());



  Future<void> verifyOtpService(String phoneNumber,String otp,BuildContext context) async {
    emit(VerifyOtpLoading());

    SharedPrefsService prefsService = SharedPrefsService();
    Map<String,dynamic> body = {
      "decData": {
        "phoneNumber":"$countryCodeSelect$phoneNumber",
        "otp":otp
      }
    };
    log(body.toString());
    Encryption? response = await DioClient().encryptData(body);
    if(response!=null && response.status!){
      Decryption? data = await DioClient().decryptData(ApiConstants.verifyOtp,response.data!);
      if(data!=null){
        VerifyOtp? verifyOtp = await DioClient().verifyOtp(data.data!);
        if(verifyOtp!=null && verifyOtp.status!){
          emit(VerifyOtpSuccess());
          authorization=verifyOtp.data!.token!;
          prefsService.setStringData('authToken', authorization);
          // flutterToast(verifyOtp.message!, true);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Welcome()),(route) => false);
        }else{
          emit(VerifyOtpError());
          flutterToast(verifyOtp!.message!, false);
        }
      }else{
        emit(VerifyOtpError());
        flutterToast("Something went wrong!", false);
      }
    }else{
      emit(VerifyOtpError());
      flutterToast("Something went wrong!", false);
    }

  }

}