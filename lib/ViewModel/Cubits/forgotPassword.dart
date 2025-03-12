import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/forgotPassword.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/verfiyEmail.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class ForgotPassState {}

class ForgotPassInitials extends ForgotPassState {}

class ForgotPassLoading extends ForgotPassState {}

class ForgotPassError extends ForgotPassState {}

class ForgotPassSuccess extends ForgotPassState {}

class ForgotPassCubit extends Cubit<ForgotPassState> {
  ForgotPassCubit() : super(ForgotPassInitials());
  bool isButtonClicked = false;
  Future<void> forgotPassService(BuildContext context,
      {required String phoneNumber}) async {
    emit(ForgotPassLoading());
    isButtonClicked = true;
    ForgotPassword? forgotPass = ForgotPassword();
    Map<String, dynamic> body = {
      "decData": {"phoneNumber": "$countryCodeSelect$phoneNumber"}
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData(ApiConstants.forgotPassword, response.data!);
      if (data != null) {
        forgotPass = await DioClient().forgotPass(data.data!);
        if (forgotPass != null && forgotPass.status!) {
          emit(ForgotPassSuccess());
          // flutterToast(forgotPass.message!, true);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyPhone(phoneNumber: phoneNumber, screenIndex: 2)));
        } else {
          emit(ForgotPassError());
          flutterToast(forgotPass!.message!, false);
        }
      } else {
        flutterToast(forgotPass.message!, false);
        emit(ForgotPassError());
      }
    } else {
      flutterToast(forgotPass.message!, false);
      emit(ForgotPassError());
    }
    isButtonClicked = false;
  }
}
