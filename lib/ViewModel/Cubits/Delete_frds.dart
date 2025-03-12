import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/Delete_frd.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class DeleteFriendsState {}

class DeleteFriendsInitials extends DeleteFriendsState {}

class DeleteFriendsLoading extends DeleteFriendsState {}

class DeleteFriendsError extends DeleteFriendsState {}

class DeleteFriendsSuccess extends DeleteFriendsState {}

class DeleteFriendsCubit extends Cubit<DeleteFriendsState> {
  DeleteFriendsCubit() : super(DeleteFriendsInitials());

  // ViewEventsCubit viewEventsCubit =ViewEventsCubit();

  Future<void> Delete_frdss(BuildContext context,
      {required String Numbers,c_id
      }) async {
    emit(DeleteFriendsLoading());
    Map<String, dynamic> body = {
      "decData": {
        "phoneNumber": Numbers,
        "id":c_id
      }
    };
    print("Delete friends:${body}");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.Delete_frd, response.data!);
      if (data != null) {
        DeleteFrd? deleteFrd = await DioClient().DeleteFrds(data.data!);
        if (deleteFrd != null && deleteFrd.status) {
          flutterToast(deleteFrd.message, true);
          emit(DeleteFriendsSuccess());
         // flutterToast("your data success fully add", false);
        } else {
          emit(DeleteFriendsError());
          flutterToast(deleteFrd!.message, false);
        }
      } else {
        emit(DeleteFriendsError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(DeleteFriendsError());
      flutterToast("Something went wrong!", false);
    }
  }
}