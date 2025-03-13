import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Model/buildgroup.dart';


import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import '../../../Helper/apiConstants.dart';

abstract class BuildGroupState {}

class BuildGroupInitials extends BuildGroupState {}

class BuildGroupLoading extends BuildGroupState {}

class BuildGroupError extends BuildGroupState {}

class BuildGroupSuccess extends BuildGroupState {}

class BuildGroupCubit extends Cubit<BuildGroupState> {
  BuildGroupCubit() : super(BuildGroupInitials());

  Future<void> getBuilGrop(BuildContext context,
      {required List checkData}) async {
    emit(BuildGroupLoading());

    List list = [];
    checkData.forEach((element) {
      // String a=element.phoneNumber.replaceAll(' ','');
      // String b=a.replaceAll('-','');
      // String c=b.replaceAll('(','');
      // String d=c.replaceAll(')','');
      // String e=d.replaceAll('+','');
      list.add({
        "phoneNumber": element,
      });
    });

    Map<String, dynamic> body = {
      "decData": {"member": list}
    };
  log("Body : $body");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      log('encode : ${response.data}');
      Decryption? data = await DioClient()
          .decryptData(ApiConstants.buildGroup, response.data!);
      log('Decryption ${data?.data}');
      if (data != null) {
        BuildGroup? buildGroup = await DioClient().getBuilGroup(data.data!);
        if (buildGroup != null && buildGroup.status!) {
          // flutterToast(buildGroup.message!, true);
          emit(BuildGroupSuccess());
        } else {
          emit(BuildGroupError());
          flutterToast(buildGroup!.message!, false);
        }
      } else {
        emit(BuildGroupError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(BuildGroupError());
      flutterToast("Something went wrong!", false);
    }
  }
}
