

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/newPassword.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class NewPasswordState{}

class NewPasswordInitials extends NewPasswordState{}
class NewPasswordLoading extends NewPasswordState{}
class NewPasswordError extends NewPasswordState{}
class NewPasswordSuccess extends NewPasswordState{}


class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit() : super(NewPasswordInitials());

  bool isButtonClicked = false;

  Future<void> newPasswordService(
 BuildContext context,{required String phoneNumber,required String password,required String confirmPassword}) async {
    emit(NewPasswordLoading());
    NewPassword? newPassword=NewPassword();
    isButtonClicked = true;
    Map<String,dynamic> body = {
      "decData": {
        "phoneNumber":"$countryCodeSelect$phoneNumber",
        "password":password,
        "cpassword":confirmPassword
      }
    };
    log("Body : $body");
    Encryption? response = await DioClient().encryptData(body);
    if(response!=null && response.status!){
      Decryption? data = await DioClient().decryptData(ApiConstants.newPassword,response.data!);
      if(data!=null){
       newPassword = await DioClient().newPassword(data.data!);
        if(newPassword!=null && newPassword.status!){
          emit(NewPasswordSuccess());
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
          // flutterToast(newPassword.message!, true);
        }else{
          emit(NewPasswordError());
          flutterToast(newPassword!.message!, false);
        }
      }else{
        emit(NewPasswordError());
        flutterToast(newPassword.message!, false);
      }
    }else{
      emit(NewPasswordError());
      flutterToast(newPassword.message!, false);
    }
    isButtonClicked = false;
  }

}