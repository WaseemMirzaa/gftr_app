
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/resend.dart';
import 'package:gftr/Model/verfyforgotOtp.dart';
import 'package:gftr/Model/verifyOtp.dart';
import 'package:gftr/View/Screens/LoginPage.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class ResendOtpState{}

class ResendOtpInitials extends ResendOtpState{}
class ResendOtpLoading extends ResendOtpState{}
class ResendOtpError extends ResendOtpState{}
class ResendOtpSuccess extends ResendOtpState{}

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit() : super(ResendOtpInitials());
  bool isButtonClicked = false;
  Future<void> resendOtpService(String phoneNumber,BuildContext context) async {
    emit(ResendOtpLoading());
    isButtonClicked = true;
    Map<String,dynamic> body = {
      "decData": {
        "phoneNumber":"$countryCodeSelect$phoneNumber"
      }
    };
    log(body.toString());
    Encryption? response = await DioClient().encryptData(body);
    if(response!=null && response.status!){
      Decryption? data = await DioClient().decryptData(ApiConstants.resendOtp,response.data!);
      if(data!=null){
        ResendModal? resendModal  = await DioClient().resendOtp(data.data!);
        if(resendModal!=null && resendModal.status!){
          emit(ResendOtpSuccess());
          // flutterToast(resendModal.message!, true);
        }else{
          emit(ResendOtpError());
          flutterToast(resendModal?.message??'', false);
        }
      }else{
        emit(ResendOtpError());
        flutterToast("Something went wrong!", false);
      }
    }else{
      emit(ResendOtpError());
      flutterToast("Something went wrong!", false);
    }
    isButtonClicked = false;
  }

}