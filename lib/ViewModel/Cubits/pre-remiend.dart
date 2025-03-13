import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/prerimend.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class PreRemiendState {}

class PreRemiendInitials extends PreRemiendState {}

class PreRemiendLoading extends PreRemiendState {}

class PreRemiendError extends PreRemiendState {}

class PreRemiendSuccess extends PreRemiendState {}

class PreRimendCubit extends Cubit<PreRemiendState> {
  PreRimendCubit() : super(PreRemiendInitials());
  PreRimend? preRimend = PreRimend();

  Future<void> getpreRimend() async {
    emit(PreRemiendLoading());
    Decryption? data = await DioClient()
        .decryptDataGetMethod(ApiConstants.preExistingHolidays);
    if (data != null) {
      preRimend = await DioClient().getpreRimend(data.data!);
      print("preRimend :$preRimend");
      if (preRimend != null && preRimend!.status!) {
        emit(PreRemiendSuccess());
      } else {
        emit(PreRemiendError());
      }
    } else {
      emit(PreRemiendError());
    }
  }
}
