import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/viewdelete.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

import '../../../Helper/apiConstants.dart';

abstract class GetGiftedDeleteState {}

class GetGiftedDeleteInitials extends GetGiftedDeleteState {}

class GetGiftedDeleteLoading extends GetGiftedDeleteState {}

class GetGiftedDeleteError extends GetGiftedDeleteState {}

class GetGiftedDeleteSuccess extends GetGiftedDeleteState {}

class GetGiftedDeleteCubit extends Cubit<GetGiftedDeleteState> {
  GetGiftedDeleteCubit() : super(GetGiftedDeleteInitials());
  ViewGiftDelete? viewGiftDelete=ViewGiftDelete();
  Future<void> getDeleteGift(String id) async {
    emit(GetGiftedDeleteLoading());
    Decryption? data =
    await DioClient().decryptDataDeleteMethod("${ApiConstants.deleteGift}/$id");
    if (data != null) {
      viewGiftDelete = await DioClient().viewDeleteGift(data.data!);
      if (viewGiftDelete != null && viewGiftDelete!.status!) {
   flutterToast(viewGiftDelete!.message!, true);
        emit(GetGiftedDeleteSuccess());
      } else {
        flutterToast(viewGiftDelete!.message!, true);
        emit(GetGiftedDeleteError());
      }
    } else {
      emit(GetGiftedDeleteError());
      flutterToast("Something went wrong!", false);
    }
  }
}