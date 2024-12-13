
// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/verfyforgotOtp.dart';
import 'package:gftr/Model/verifyOtp.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/createNewPassword.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class VerifyForgotOtpState{}

class VerifyForgotOtpInitials extends VerifyForgotOtpState{}
class VerifyForgotOtpLoading extends VerifyForgotOtpState{}
class VerifyForgotOtpError extends VerifyForgotOtpState{}
class VerifyForgotOtpSuccess extends VerifyForgotOtpState{}


class VerifyForgotOtpCubit extends Cubit<VerifyForgotOtpState> {
  VerifyForgotOtpCubit() : super(VerifyForgotOtpInitials());

  bool isButtonClicked = false;

  Future<void> verifyForgotOtpService(String phone,String otp,BuildContext context) async {
    emit(VerifyForgotOtpLoading());
    isButtonClicked = true;
    Map<String,dynamic> body = {
      "decData": {
        "phoneNumber":"$countryCodeSelect$phone",
        "otp":otp
      }
    };
    Encryption? response = await DioClient().encryptData(body);
    if(response!=null && response.status!){
      Decryption? data = await DioClient().decryptData(ApiConstants.verifyForgotOtp,response.data!);
      if(data!=null){
        VerifyForgotOtp? verifyForgotOtp  = await DioClient().verifyForgotOtp(data.data!);
        if(VerifyForgotOtp!=null && verifyForgotOtp!.status!){
          emit(VerifyForgotOtpSuccess());
          // flutterToast(verifyForgotOtp.message!, true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> NewPasswordPage(phoneNumber: phone)));
        }else{
          emit(VerifyForgotOtpError());
          flutterToast(verifyForgotOtp!.message!, false);
        }
      }else{
        emit(VerifyForgotOtpError());
        flutterToast("Something went wrong!", false);
      }
    }else{
      emit(VerifyForgotOtpError());
      flutterToast("Something went wrong!", false);
    }
    isButtonClicked = false;
  }

}