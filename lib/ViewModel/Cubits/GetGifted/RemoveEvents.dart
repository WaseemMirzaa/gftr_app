import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/RemoveEvents.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class DeleteEventState {}

class DeleteEventInitials extends DeleteEventState {}

class DeleteEventLoading extends DeleteEventState {}

class DeleteEventError extends DeleteEventState {}

class DeleteEventSuccess extends DeleteEventState {}

class DeleteEventCubit extends Cubit<DeleteEventState> {
  DeleteEventCubit() : super(DeleteEventInitials());

  // ViewEventsCubit viewEventsCubit =ViewEventsCubit();

  Future<void> Delete_Events(BuildContext context,
      {required String Numbers,
      }) async {
    emit(DeleteEventLoading());
    Map<String, dynamic> body = {
      "decData": {
        "id": Numbers,
      }
    };
    print("Delete friends:${body}");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.delete_event, response.data!);
      if (data != null) {
        RemoveEvent? removeEvent = await DioClient().DeleteEvent(data.data!);
        if (removeEvent != null && removeEvent.status!) {
          flutterToast(removeEvent.message!, true);
          emit(DeleteEventSuccess());
          // flutterToast("your data success fully add", false);
        } else {
          emit(DeleteEventError());
          flutterToast(removeEvent!.message!, false);
        }
      } else {
        emit(DeleteEventError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(DeleteEventError());
      flutterToast("Something went wrong!", false);
    }
  }
}