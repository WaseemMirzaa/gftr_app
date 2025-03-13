import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/groupreplynotification.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GroupReplyNotificationState {}

class GroupReplyNotificationInitials extends GroupReplyNotificationState {}

class GroupReplyNotificationLoading extends GroupReplyNotificationState {}

class GroupReplyNotificationError extends GroupReplyNotificationState {}

class GroupReplyNotificationSuccess extends GroupReplyNotificationState {}

class GroupReplyNotificationCubit extends Cubit<GroupReplyNotificationState> {
  GroupReplyNotificationCubit() : super(GroupReplyNotificationInitials());
  GroupRequestReplyNotification? groupRequestReplyNotification=GroupRequestReplyNotification();

  Future<void> getgroupRequestReplyNotification() async {
    emit(GroupReplyNotificationLoading());
    Decryption? data =
    await DioClient().decryptDataGetMethod(ApiConstants.groupRequestReply);
    if (data != null) {
      groupRequestReplyNotification = await DioClient().groupRequestReplyNotification(data.data!);
      if (groupRequestReplyNotification != null && groupRequestReplyNotification!.status!) {
        emit(GroupReplyNotificationSuccess());
        // flutterToast(groupRequestReplyNotification!.message!, true);
      } else {
        emit(GroupReplyNotificationError());
      }
    } else {
      emit(GroupReplyNotificationError());
    }
  }

}