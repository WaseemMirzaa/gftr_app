import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/addfolder.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/getgiftedview_dart.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GetGiftedState {}

class GetGiftedInitials extends GetGiftedState {}

class GetGiftedLoading extends GetGiftedState {}

class GetGiftedError extends GetGiftedState {}

class GetGiftedSuccess extends GetGiftedState {}

class GetGiftedCubit extends Cubit<GetGiftedState> {
  GetGiftedCubit() : super(GetGiftedInitials());

GetGiftedViewCubit getGiftedViewCubit =GetGiftedViewCubit();

  Future<void> getAddFolder(BuildContext context,
      {required String folderName,required bool isPublic}) async {
    emit(GetGiftedLoading());
    Map<String, dynamic> body = {
      "decData": {"folder_name": folderName,"isPublic":isPublic}
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data =
          await DioClient().decryptData(ApiConstants.addFolder, response.data!);
      if (data != null) {
        AddFolderModal? addFolderModal =
            await DioClient().addFolder(data.data!);
        if (addFolderModal != null && addFolderModal.status!) {
          flutterToast(addFolderModal.message!, true);
          emit(GetGiftedSuccess());
        } else {
          emit(GetGiftedError());
          flutterToast(addFolderModal!.message!, false);
        }
      } else {
        emit(GetGiftedError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(GetGiftedError());
      flutterToast("Something went wrong!", false);
    }
  }



}
