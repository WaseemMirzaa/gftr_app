import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Helper/apiConstants.dart';
import '../../../Helper/appConfig.dart';

abstract class Profiel_ImageState {}

class Profiel_ImageInitials extends Profiel_ImageState {}

class Profiel_ImageLoading extends Profiel_ImageState {}

class Profiel_ImageError extends Profiel_ImageState {}

class Profiel_ImageSuccess extends Profiel_ImageState {}

class Profiel_ImageCubit extends Cubit<Profiel_ImageState> {
  Profiel_ImageCubit() : super(Profiel_ImageInitials());
  Future<void> getBuilGrop(BuildContext context,
      {required File Imgg}) async {
    emit(Profiel_ImageLoading());
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    print("pickedFile :$pickedFile");
    if (pickedFile != null) {
      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.User_img));
      var header ={
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': ' $authorization',
      };
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          Imgg.path,
          contentType: MediaType('image', 'jpeg'),
          // Adjust the content type based on your file format
        ),
      );request.headers.addAll(header);
      var response = await request.send();
      if (response.statusCode == 200) {
        // Image was successfully uploaded
        print('Image upload failed with status: ${response.stream.isBroadcast}');
        print('Image upload failed with status: ${response.statusCode}');
        print('Image upload failed with status: ${response.headers}');
        print('Image upload failed with status: ${response.contentLength}');
        print('Image upload failed with status: ${response.toString()}');
        print('Image upload failed with status: ${response.stream.isBroadcast}');
        print('Image uploaded');
        flutterToast('Image uploaded', true);

      } else {
        // Handle the error
        print('Image upload failed with status: ${response.statusCode}');
        flutterToast('Image can`t uploaded', false);
        Navigator.pop(context);
      }
      // The image was picked successfully, proceed with sending it to the backend.
      // sendImageToBackend(File(pickedFile.path));
    }
    // setState(() {
    //   selectImage(ImageSource.gallery);
    //
    //   Navigator.pop(context);
    // });

  }
}
