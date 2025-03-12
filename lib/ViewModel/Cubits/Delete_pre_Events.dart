import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/Delete_frd.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

import '../../Model/DeletePre_Events.dart';

abstract class DeletePreEventsState {}

class DeletePreEventsInitials extends DeletePreEventsState {}

class DeletePreEventsLoading extends DeletePreEventsState {}

class DeletePreEventsError extends DeletePreEventsState {}

class DeletePreEventsSuccess extends DeletePreEventsState {}

class DeletePreEventsCubit extends Cubit<DeletePreEventsState> {
  DeletePreEventsCubit() : super(DeletePreEventsInitials());

  // ViewEventsCubit viewEventsCubit =ViewEventsCubit();

  Future<void> Delete_frdss(BuildContext context,
      {required String c_id
      }) async {
    emit(DeletePreEventsLoading());
    Map<String, dynamic> body = {
      "decData": {
        "id":c_id
      }
    };
    print("Delete friends:${body}");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.Delete_Preevent, response.data!);
      if (data != null) {
        Deleteeventes? _delteevent = await DioClient().DeletePreremainder(data.data!);
        if (_delteevent != null && _delteevent.status == true) {
          flutterToast(_delteevent.message.toString(), true);
          emit(DeletePreEventsSuccess());

          // flutterToast("your data success fully add", false);
        } else {
          emit(DeletePreEventsError());
          flutterToast(_delteevent!.message.toString(), false);
        }
      } else {
        emit(DeletePreEventsError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(DeletePreEventsError());
      flutterToast("Something went wrong!", false);
    }
  }
}