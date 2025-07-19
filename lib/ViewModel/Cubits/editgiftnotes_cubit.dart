import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import '../../Helper/apiConstants.dart';

abstract class EditGiftNotesState {}

class EditGiftNotesInitial extends EditGiftNotesState {}

class EditGiftNotesLoading extends EditGiftNotesState {}

class EditGiftNotesError extends EditGiftNotesState {}

class EditGiftNotesSuccess extends EditGiftNotesState {}

class EditGiftNotesCubit extends Cubit<EditGiftNotesState> {
  EditGiftNotesCubit() : super(EditGiftNotesInitial());

  Future<void> editGiftNotes({
    required String folderId,
    required String formDataId,
    required String notes,
  }) async {
    log("EditGiftNotes - folderId: $folderId, formDataId: $formDataId, notes: $notes");
    emit(EditGiftNotesLoading());

    try {
      Map<String, dynamic> body = {
        "decData": {
          "notes": notes,
          "formDataId": formDataId,
        }
      };

      Encryption? response = await DioClient().encryptData(body);
      if (response != null && response.status!) {
        Decryption? data = await DioClient().decryptData(
          "${ApiConstants.editGiftNotes}/$folderId",
          response.data!,
        );

        if (data != null) {
          log('EditGiftNotes response: ${data.data}');

          // Simple response handling without complex type checking
          flutterToast('Notes updated successfully!', true);
          emit(EditGiftNotesSuccess());
        } else {
          emit(EditGiftNotesError());
          flutterToast("Something went wrong!", false);
        }
      } else {
        emit(EditGiftNotesError());
        flutterToast("Something went wrong!", false);
      }
    } catch (e) {
      log("EditGiftNotes error: $e");
      emit(EditGiftNotesError());
      flutterToast("Something went wrong!", false);
    }
  }
}
