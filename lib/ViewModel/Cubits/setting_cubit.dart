import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/setting.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class SettingState {}

class SettingInitials extends SettingState {}

class SettingLoading extends SettingState {}

class SettingError extends SettingState {}

class SettingSuccess extends SettingState {}

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitials());

  Future<void> getSetting(
      {String? phoneNumber,
      String? isPrivate,
      String? birthdayRemind,
      String? holidayRemind,
      String? preferThrough,
      String? birthday,
      String? email,
      String? typenotify,
      String? sendnotify,
      String? street,
      String? unit,
      String? city,
      String? zipcode,
      String? state,
      String? country,
      List? remindMe,
      List? checkholidaystatus,
      required BuildContext context}) async {
    log(birthday.toString());
    emit(SettingLoading());
    // if(preferThrough == null){
    //   preferThrough = "Email";
    // }
    Map<String, dynamic> body = {
      "decData": {
        "phoneNumber": phoneNumber,
        "isPrivate": isPrivate,
        "birthdayRemind": birthdayRemind,
        "birthday": birthday,
        "typenotify": preferThrough,
        "email": email,
        "street": street,
        "unit": unit,
        "city": city,
        "zipcode": zipcode,
        "state": state,
        "country": country,
        "remindMe": remindMe,
        "holidayRemind" :  holidayRemind,
        "preferThrough" :  preferThrough,
        "checkholidaystatus" :  checkholidaystatus,
        //"preferThrough" :  "Email",
      }
    };
    print("====>data $body");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data =
          await DioClient().decryptData(ApiConstants.settting, response.data!);
      if (data != null) {
        Setting? setting = await DioClient().setting(data.data!);
        if (setting != null && setting.status!) {
          emit(SettingSuccess());
          // flutterToast(setting.message!, true);
          // ViewSettingCubit viewSettingCubit =
          //     BlocProvider.of<ViewSettingCubit>(context);
          // viewSettingCubit.getviewSetting().then((value) =>
          //     // (isPrivate == null && birthday == null)
          //     //     ? Navigator.pop(context)
          //     //     :
          //     null);
        } else {
          emit(SettingError());
          flutterToast(setting?.message ?? '', false);
        }
      } else {
        emit(SettingError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(SettingError());
      flutterToast("Something went wrong!", false);
    }
  }
}
