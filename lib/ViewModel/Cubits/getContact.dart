import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/GetContactList.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class GetContactViewState {}

class GetContactViewInitials extends GetContactViewState {}

class GetContactViewLoading extends GetContactViewState {}

class GetContactViewError extends GetContactViewState {}

class GetContactViewSuccess extends GetContactViewState {}

class GetContactViewCubit extends Cubit<GetContactViewState> {
  GetContactViewCubit() : super(GetContactViewInitials());
  GetContactList? getContactList = GetContactList();
  List<EmailList> emailList = [];
  List<String> smslList = [];
  List<String> displayname = [];
  bool select = false;
  Future<void> getContactsList() async {
    emit(GetContactViewLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.verifiedContactList);
    if (data != null) {
      getContactList = await DioClient().getContactList(data.data!);
      if (getContactList != null && getContactList!.status!) {
        emit(GetContactViewSuccess());
        getContactList!.registered!.forEach((element) {
          element.isVerified == true
              ? emailList.add(EmailList(
                  name: element.userName ?? '', email: element.email ?? ''))
              : null;
          smslList.add(element.phoneNumber.toString() ?? '');
          displayname.add(element.userName.toString() ?? '');
        });
        log("emailList : $emailList");
        log("smsList : $smslList");
        log("displayname : $displayname");
        log("select : $select");
      } else {
        emit(GetContactViewError());
      }
    } else {
      emit(GetContactViewError());
    }
  }
}

class EmailList {
  String name;
  String email;
  EmailList({required this.name, required this.email});
}

class SmsList {
  String name;
  String phone;
  SmsList({required this.name, required this.phone});
}
