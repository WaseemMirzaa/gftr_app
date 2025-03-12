import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/folderview.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

import '../../../Helper/apiConstants.dart';

abstract class FolderViewDeleteState {}

class FolderViewDeleteInitials extends FolderViewDeleteState {}

class FolderViewDeleteLoading extends FolderViewDeleteState {}

class FolderViewDeleteError extends FolderViewDeleteState {}

class FolderViewDeleteSuccess extends FolderViewDeleteState {}

class FolderViewDeleteCubit extends Cubit<FolderViewDeleteState> {
  FolderViewDeleteCubit() : super(FolderViewDeleteInitials());
  FolderDelete? folderDelete=FolderDelete();
  Future<void> folderViewDeleteGift(
      {required String folderViewId,required String giftfolderId}) async {
    log("id : ${ApiConstants.deleteForm}/$folderViewId/");
    emit((FolderViewDeleteLoading()));
    Decryption? data =
    await DioClient().decryptDataDeleteMethod("${ApiConstants.deleteForm}/$folderViewId/$giftfolderId");
    if (data != null) {
      log('data : ${data.data}');
      folderDelete = await DioClient().folderviewDelete(data.data!);
      if (folderDelete != null&&folderDelete!.status!) {;
        // flutterToast(folderDelete!.message!, true);
        emit(FolderViewDeleteSuccess());
      } else {
        flutterToast(folderDelete?.message??'Delete Item', true);
        emit(FolderViewDeleteError());
      }
    } else {
      emit(FolderViewDeleteError());
      flutterToast("Something went wrong!", false);
    }
  }
}