import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/prerimend.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class InboxState {}

class InboxInitials extends InboxState {}

class InboxLoading extends InboxState {}

class InboxError extends InboxState {}

class InboxSuccess extends InboxState {}

class InboxCubit extends Cubit<InboxState> {
  InboxCubit() : super(InboxInitials());
  PreRimend? preRimend = PreRimend();
  Future<void> getpreRimend() async {
    emit(InboxLoading());
    Decryption? data = await DioClient()
        .decryptDataGetMethod(ApiConstants.preExistingHolidays);
    if (data != null) {
      preRimend = await DioClient().getpreRimend(data.data!);
      if (preRimend != null && preRimend!.status!) {
        emit(InboxSuccess());
      } else {
        emit(InboxError());
      }
    } else {
      emit(InboxError());
    }
  }
}
