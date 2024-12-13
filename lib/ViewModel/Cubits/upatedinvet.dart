import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/updateinvite.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class UpadetInviteState {}

class UpadetInviteInitials extends UpadetInviteState {}

class UpadetInviteLoading extends UpadetInviteState {}

class UpadetInviteError extends UpadetInviteState {}

class UpadetInviteSuccess extends UpadetInviteState {}

class UpadetInviteCubit extends Cubit<UpadetInviteState> {
  UpadetInviteCubit() : super(UpadetInviteInitials());

  Future<void> getUpdateInvite(BuildContext context,
      {required bool invite, required String id}) async {
    emit(UpadetInviteLoading());
    Map<String, dynamic> body = {
      "decData": {"invite": invite}
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData("${ApiConstants.updateInvite}/$id", response.data!);
      if (data != null) {
        UpadateInvite? upadateInvite =
            await DioClient().updateInvite(data.data!);
        if (upadateInvite != null && upadateInvite.status!) {
          // flutterToast(upadateInvite.message!, true);
          emit(UpadetInviteSuccess());
        } else {
          emit(UpadetInviteError());
          flutterToast(upadateInvite!.message!, false);
        }
      } else {
        emit(UpadetInviteError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(UpadetInviteError());
      flutterToast("Something went wrong!", false);
    }
  }
}
