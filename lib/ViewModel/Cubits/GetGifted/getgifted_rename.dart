import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/renameFolder.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class FolderRenameState {}

class FolderRenameInitials extends FolderRenameState {}

class FolderRenameLoading extends FolderRenameState {}

class FolderRenameError extends FolderRenameState {}

class FolderRenameSuccess extends FolderRenameState {}

class FolderRenameCubit extends Cubit<FolderRenameState> {
  FolderRenameCubit() : super(FolderRenameInitials());


  Future<void> getFolderRename(BuildContext context,
      {required String folderName, required String id}) async {
    emit(FolderRenameLoading());
    Map<String, dynamic> body = {
      "decData": {"folder_name": folderName}
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData("${ApiConstants.renameFolder}/$id", response.data!);
      if (data != null) {
        RenameFolder? renameFolder = await DioClient().renameFolder(data.data!);
        if (renameFolder != null && renameFolder.status!) {
          flutterToast(renameFolder.message!, true);
          emit(FolderRenameSuccess());
        } else {
          emit(FolderRenameError());
          flutterToast(renameFolder!.message!, false);
        }
      } else {
        emit(FolderRenameError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(FolderRenameError());
      flutterToast("Something went wrong!", false);
    }
  }
}
