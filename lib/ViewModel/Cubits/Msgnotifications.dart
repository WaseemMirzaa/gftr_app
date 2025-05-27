import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/MsgNotifications.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class MessagnotiState {}

class MessagnotiInitials extends MessagnotiState {}

class MessagnotiLoading extends MessagnotiState {}

class MessagnotiError extends MessagnotiState {}

class MessagnotiSuccess extends MessagnotiState {}

class MessagnotiCubit extends Cubit<MessagnotiState> {
  MessagnotiCubit() : super(MessagnotiInitials());
   Notifications? notifications =Notifications();
  Future messages() async {
    emit(MessagnotiLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.msg_notifocation);
    print("============================**> $data");
    if (data != null) {
      notifications = await DioClient().MassageNotification(data.data!);
      print(notifications!.data);
      if (notifications != null && notifications!.status!) {
        emit(MessagnotiSuccess());
        print("============================**> succesfull");
      } else {
        emit(MessagnotiError());
        print("============================**> fail");
      }
    } else {
      emit(MessagnotiError());
      print("============================**> fail22");
    }
  }
}