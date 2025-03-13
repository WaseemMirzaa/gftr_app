import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/inviteemail.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class InviteEmialState {}

class InviteEmialInitials extends InviteEmialState {}

class InviteEmialLoading extends InviteEmialState {}

class InviteEmialError extends InviteEmialState {}

class InviteEmialSuccess extends InviteEmialState {}

class InviteEmialCubit extends Cubit<InviteEmialState> {
  InviteEmialCubit() : super(InviteEmialInitials());
  InviteEmail? inviteEmail=InviteEmail();
  Future<void> getInviteEmail(BuildContext context,
      {required String email}) async {
    emit(InviteEmialLoading());
    Map<String, dynamic> body = {
      "decData": {"email": email}
    };
    log("Body : $body");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData(ApiConstants.inviteNewGftr, response.data!);
      if (data != null) {
        inviteEmail = await DioClient().inviteEmailSend(data.data!);
        if (inviteEmail != null && inviteEmail!.status!) {
          emit(InviteEmialSuccess());
          flutterToast(inviteEmail!.message!, true);
        } else {
          emit(InviteEmialError());
          flutterToast(inviteEmail!.message!, false);
        }
      } else {
        emit(InviteEmialError());
        flutterToast(inviteEmail!.message!, false);
      }
    } else {
      emit(InviteEmialError());
      flutterToast(inviteEmail!.message!, false);
    }
  }
}
