import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/CalenderEvents.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class CalendarPostsState {}

class CalendarPostsInitials extends CalendarPostsState {}

class CalendarPostsLoading extends CalendarPostsState {}

class CalendarPostsError extends CalendarPostsState {}

class CalendarPostsSuccess extends CalendarPostsState {}

class CalendarPostsCubit extends Cubit<CalendarPostsState> {
  CalendarPostsCubit() : super(CalendarPostsInitials());
  Future events_views(BuildContext context,
      {required String Date,
        required String Title,

        }) async {
    emit(CalendarPostsLoading());
    Map<String, dynamic> body = {
      "decData": {
        "date": Date,
        "title":Title,
      }
    };
    print("That is my Calendar Events body:${body}");
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient().decryptData(ApiConstants.calendar_events, response.data!);
      if (data != null) {
        CalenderPost? calrndarEventPost = await DioClient().calendar_events(data.data!);
        if (calrndarEventPost != null && calrndarEventPost.status!) {
          flutterToast(calrndarEventPost.message!, true);
          emit(CalendarPostsSuccess());
          //flutterToast("your data success fully add", false);
        } else {
          emit(CalendarPostsError());
        }
      } else {
        emit(CalendarPostsError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(CalendarPostsError());
      flutterToast("Something went wrong!", false);
    }
  }
}