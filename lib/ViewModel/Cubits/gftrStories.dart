import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/gftrStories.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GftrStoriesState {}

class GftrStoriesInitials extends GftrStoriesState {}

class GftrStoriesLoading extends GftrStoriesState {}

class GftrStoriesError extends GftrStoriesState {
  final String? errorMessage;
  GftrStoriesError({this.errorMessage});
}

class GftrStoriesSuccess extends GftrStoriesState {}

class GftrStoriesCubit extends Cubit<GftrStoriesState> {
  GftrStoriesCubit() : super(GftrStoriesInitials());

  GftrStories? gftrStories = GftrStories();

  Future<void> gftrStoriesService() async {
    emit(GftrStoriesLoading());
    try {
      Decryption? data =
          await DioClient().decryptDataGetMethod(ApiConstants.gftrStories);

      if (data != null) {
        gftrStories = await DioClient().gftrStories(data.data!);

        if (gftrStories != null && gftrStories!.status!) {
          // Extensive logging for debugging
          log("API Response Received Successfully");
          log("Total Posts: ${gftrStories?.data?.post?.length ?? 0}");

          // Log details of first post for verification
          if (gftrStories?.data?.post?.isNotEmpty == true) {
            final firstPost = gftrStories!.data!.post![1];
            log("First Post Details:");
            log("Title: ${firstPost.title}");
            log("Image URL: ${firstPost.image}");
            log("Content: ${firstPost.content}");
          }

          emit(GftrStoriesSuccess());
        } else {
          log("Error: Invalid gftrStories or status is false");
          emit(GftrStoriesError(errorMessage: "Invalid data received"));
        }
      } else {
        log("Error: Data from API is null");
        emit(GftrStoriesError(errorMessage: "No data received from API"));
      }
    } catch (e) {
      // More detailed error logging
      log("Exception occurred", error: e);
      emit(GftrStoriesError(errorMessage: e.toString()));
    }
  }

  // Optional method to directly get the full image URL
  String getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';

    // Remove leading slash if present
    final cleanedPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

    return "${ApiConstants.baseUrls}$cleanedPath";
  }
}
