import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/folderSetting.dart';
import 'package:gftr/Model/renameFolder.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class FolderSettingState {}

class FolderSettingInitials extends FolderSettingState {}

class FolderSettingLoading extends FolderSettingState {}

class FolderSettingError extends FolderSettingState {}

class FolderSettingSuccess extends FolderSettingState {}

class FolderSettingCubit extends Cubit<FolderSettingState> {
  FolderSettingCubit() : super(FolderSettingInitials());


  Future<void> getFolderSetting(BuildContext context,
      {required bool troggle, required String id}) async {
    emit(FolderSettingLoading());
    Map<String, dynamic> body = {
      "decData": {"isPublic": troggle}
    };
    log(body.toString());
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData("${ApiConstants.folderSetting}/$id", response.data!);
      if (data != null) {
        FolderSetting? folderSetting = await DioClient().folderSetting(data.data!);
        if (folderSetting != null && folderSetting.status!) {
          // flutterToast(folderSetting.message!, true);
          emit(FolderSettingSuccess());
        } else {
          emit(FolderSettingError());
          flutterToast(folderSetting!.message!, false);
        }
      } else {
        emit(FolderSettingError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(FolderSettingError());
      flutterToast("Something went wrong!", false);
    }
  }
}
