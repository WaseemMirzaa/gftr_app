import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/addform.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Screens/ManageBottom/getGiftedPublicView.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class AddToState {}

class AddToStateInitials extends AddToState {}

class AddToStateLoading extends AddToState {}

class AddToStateError extends AddToState {}

class AddToStateSuccess extends AddToState {}

class AddToCubit extends Cubit<AddToState> {
  AddToCubit() : super(AddToStateInitials());

  Future<void> getAddForm(BuildContext context,
      {required String title,
      required String price,
      required String notes,
      required String image,
       String? userId,
      required String webViewLink ,
      required bool starredGift,
      required String id}) async {
    emit(AddToStateLoading());
    Map<String, dynamic> body = {
      "decData": {
        "title": title,
        "price": price,
        "notes": notes,
        "image": image,
        "userIdView": userId,
        "starredGift": starredGift,
        "id": id,
        "webViewLink":webViewLink
      }
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      log('Id : $id');
      Decryption? data = await DioClient()
          .decryptData(ApiConstants.addtoForm, response.data!);
      if (data != null) {
        AddForm? addForm = await DioClient().addForm(data.data!);
        if (addForm?.addToData != null) {
          // flutterToast(addForm!.message!, true);
          emit(AddToStateSuccess());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetGiftedPublicViewPage(indexdata: 0)));
        } else {
          emit(AddToStateError());
          flutterToast("Something went wrong!" ?? 'Not Add Data', false);
        }
      } else {
        emit(AddToStateError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(AddToStateError());
      flutterToast("Something went wrong!", false);
    }
  }
}
