import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/notification.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class NotificationViewState {}

class NotificationViewInitials extends NotificationViewState {}

class NotificationViewLoading extends NotificationViewState {}

class NotificationViewError extends NotificationViewState {}

class NotificationViewSuccess extends NotificationViewState {}

class NotificationViewCubit extends Cubit<NotificationViewState> {
  NotificationViewCubit() : super(NotificationViewInitials());
 MyNotifications? myNotifications=MyNotifications();

  Future<void> getMyNotifitication() async {
    emit(NotificationViewLoading());
    Decryption? data =
    await DioClient().decryptDataGetMethod(ApiConstants.myNotification);
    if (data != null) {
      myNotifications = await DioClient().myNotification(data.data!);
      if (myNotifications != null && myNotifications!.status!) {
        emit(NotificationViewSuccess());
        print("notifications ==>$data");
      } else {
        emit(NotificationViewError());
      }
    } else {
      emit(NotificationViewError());
    }
  }

}