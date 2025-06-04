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

  List uniqueArray=[];
  List userReq = [];
  Groups? groups = Groups();
  Future<void> getGroups() async {
    emit(GroupViewLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.groups);
    if (data != null) {
      groups = await DioClient().getGroups(data.data!);
      if (groups != null && groups!.status!) {
        emit(GroupViewSuccess());
       groups?.userNotAcceptedRequest?.forEach((element) {
        
        userReq.add(element.phoneNumber.toString());

       });
        groups?.groupDetails?.forEach((element) {
          
          uniqueArray.add(element.phoneNumber.toString());
        });
        print("===========>$uniqueArray");
      } else {
        emit(GroupViewError());
      }
    } else {
      emit(GroupViewError());
    }
  }
}
