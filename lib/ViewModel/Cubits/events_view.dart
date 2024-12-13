import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/get_calender_events.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class ViewEventsState {}

class ViewEventsInitials extends ViewEventsState {}

class ViewEventsLoading extends ViewEventsState {}

class ViewEventsError extends ViewEventsState {}

class ViewEventsSuccess extends ViewEventsState {}
class ViewEventsCubit extends Cubit<ViewEventsState> {
  ViewEventsCubit() : super(ViewEventsInitials());
  CalenderGet? calenderGet = CalenderGet();
  List tititi = [];

  Future<void> getcalendarEvents() async {
    emit(ViewEventsLoading());
    Decryption? data = await DioClient().decryptDataGetMethod("${ApiConstants.view_calendar_events}");
    if (data != null) {
      calenderGet = await DioClient().Calendar_events_view(data.data!);
      print(data.data);
      if (calenderGet != null && calenderGet!.status!) {
        emit(ViewEventsSuccess());
        print("you are pass my friend");
      } else {
        emit(ViewEventsError());
        print("you are  hello fail my friend");
      }
    } else {
      emit(ViewEventsError());
      print("you are fully fail my friend");
    }
  }

}
