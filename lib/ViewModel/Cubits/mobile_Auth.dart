import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/mobile_auth.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/verfiyEmail.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class Mobile_AuthState {}

class Mobile_AuthInitials extends Mobile_AuthState {}

class Mobile_AuthLoading extends Mobile_AuthState {}

class Mobile_AuthError extends Mobile_AuthState {}

class Mobile_AuthSuccess extends Mobile_AuthState {}

class Mobile_AuthCubit extends Cubit<Mobile_AuthState> {
  Mobile_AuthCubit() : super(Mobile_AuthInitials());
  Future events_views(BuildContext context,
      {
        required String number,
        required String G_id,
      }) async {
    emit(Mobile_AuthLoading());
    Map<String, dynamic> body = {
      "decData": {
        "phoneNumber": "$countryCodeSelect$number",
        "email": G_id,
      }
    };
    print("That is my Calendar Events body:${body}");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.Mobileauth, response.data!);
      if (data != null) {
        MobileAuth? mobileAuth = await DioClient().Mobile_auth(data.data!);
        if (mobileAuth != null && mobileAuth.status!) {
          flutterToast(mobileAuth.message!, true);
          emit(Mobile_AuthSuccess());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyPhone(screenIndex: 1, phoneNumber: number)));
          //flutterToast("your data success fully add", false);
        } else {
          emit(Mobile_AuthError());
        }
      } else {
        emit(Mobile_AuthError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(Mobile_AuthError());
      flutterToast("Something went wrong!", false);
    }
  }
}