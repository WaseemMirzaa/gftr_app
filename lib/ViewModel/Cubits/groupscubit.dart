import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/groups.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GroupViewState {}

class GroupViewInitials extends GroupViewState {}

class GroupViewLoading extends GroupViewState {}

class GroupViewError extends GroupViewState {}

class GroupViewSuccess extends GroupViewState {}

class GroupViewCubit extends Cubit<GroupViewState> {
  GroupViewCubit() : super(GroupViewInitials());

  List uniqueArray = [];
  List userReq = [];
  Groups? groups = Groups();
  Future<void> getGroups() async {
    emit(GroupViewLoading());
    Decryption? data =
        await DioClient().decryptDataGetMethod(ApiConstants.groups);
    if (data != null) {
      groups = await DioClient().getGroups(data.data!);
      if (groups != null && groups!.status!) {
        // Clear lists before updating
        userReq.clear();
        uniqueArray.clear();

        // Update userReq list with pending requests
        if (groups?.userNotAcceptedRequest != null) {
          for (var element in groups!.userNotAcceptedRequest!) {
            userReq.add(element.phoneNumber.toString());
          }
        }

        // Update uniqueArray with accepted friends
        if (groups?.groupDetails != null) {
          for (var element in groups!.groupDetails!) {
            uniqueArray.add(element.phoneNumber.toString());
          }
        }

        emit(GroupViewSuccess());
      } else {
        emit(GroupViewError());
      }
    } else {
      emit(GroupViewError());
    }
  }
}
