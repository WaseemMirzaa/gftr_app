import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/gftrStories.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GftrStoriesState {}

class GftrStoriesInitials extends GftrStoriesState {}

class GftrStoriesLoading extends GftrStoriesState {}

class GftrStoriesError extends GftrStoriesState {}

class GftrStoriesSuccess extends GftrStoriesState {}

class GftrStoriesCubit extends Cubit<GftrStoriesState> {
  GftrStoriesCubit() : super(GftrStoriesInitials());

  GftrStories? gftrStories = GftrStories();

  // Future<void> gftrStoriesService() async {
  //   emit(GftrStoriesLoading());
  //     Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.gftrStories);
  //     if(data!=null){
  //       gftrStories = await DioClient().gftrStories(data.data!);
  //       if(gftrStories!=null && gftrStories!.status!){
  //         emit(GftrStoriesSuccess());
  //       }else{
  //         emit(GftrStoriesError());
  //       }
  //     }else{
  //       emit(GftrStoriesError());
  //     }
  // }

  Future<void> gftrStoriesService() async {
    emit(GftrStoriesLoading());
    try {
      Decryption? data =
          await DioClient().decryptDataGetMethod(ApiConstants.gftrStories);

      if (data != null) {
        gftrStories = await DioClient().gftrStories(data.data!);

        if (gftrStories != null && gftrStories!.status!) {
          // // Log the parsed data
          // log("****************Parsed Data: ${gftrStories!.data!.post![0].content}");
          emit(GftrStoriesSuccess());
        } else {
          print("Error: Invalid gftrStories or status is false");
          emit(GftrStoriesError());
        }
      } else {
        print("Error: Data from API is null");
        emit(GftrStoriesError());
      }
    } catch (e) {
      // Log any exceptions
      print("Exception occurred: $e");
      emit(GftrStoriesError());
    }
  }
}
