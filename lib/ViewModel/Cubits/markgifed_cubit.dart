import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/markgift.dart';
import 'package:gftr/View/Screens/ManageBottom/getGiftedPublicView.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class MarkGiftState {}

class MarkGiftInitials extends MarkGiftState {}

class MarkGiftLoading extends MarkGiftState {}

class MarkGiftError extends MarkGiftState {}

class MarkGiftSuccess extends MarkGiftState {}

class MarkGiftCubit extends Cubit<MarkGiftState> {
  MarkGiftCubit() : super(MarkGiftInitials());

  Future<void> getMarkGift(BuildContext context,
      {required String markGift, required String id}) async {
    emit(MarkGiftLoading());
    Map<String, dynamic> body = {
      "decData": {"markGift": markGift}
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData("${ApiConstants.markGift}/$id", response.data!);
      if (data != null) {
        MarkGift? markGift = await DioClient().getmarkGifted(data.data!);
        if (markGift != null && markGift.status!) {
          // flutterToast(markGift.message!, true);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetGiftedPublicViewPage(indexdata: 3),
              ));
          emit(MarkGiftSuccess());
        } else {
          emit(MarkGiftError());
          flutterToast(markGift!.message!, false);
        }
      } else {
        emit(MarkGiftError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(MarkGiftError());
      flutterToast("Something went wrong!", false);
    }
  }
}
