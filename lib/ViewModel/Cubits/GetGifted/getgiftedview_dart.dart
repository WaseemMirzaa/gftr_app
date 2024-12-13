import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/viewgift.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GetGiftedViewState {}

class GetGiftedViewInitials extends GetGiftedViewState {}

class GetGiftedViewLoading extends GetGiftedViewState {}

class GetGiftedViewError extends GetGiftedViewState {}

class GetGiftedViewSuccess extends GetGiftedViewState {}

class GetGiftedViewCubit extends Cubit<GetGiftedViewState> {
  GetGiftedViewCubit() : super(GetGiftedViewInitials());
  ViewGift? viewGift = ViewGift();

  Future<void> getViewGift() async {
    emit(GetGiftedViewLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.viewgift);
    if (data != null) {
      viewGift = await DioClient().viewGift(data.data!);
      if (viewGift != null && viewGift!.status!) {

        emit(GetGiftedViewSuccess());
      } else {
        emit(GetGiftedViewError());
      }
    } else {
      emit(GetGiftedViewError());
    }
  }

}