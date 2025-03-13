import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Model/contactverfy.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import '../../../Helper/apiConstants.dart';
abstract class ContactVierfyState {}

class ContactVierfyInitials extends ContactVierfyState {}

class ContactVierfyLoading extends ContactVierfyState {}

class ContactVierfyError extends ContactVierfyState {}

class ContactVierfySuccess extends ContactVierfyState {}

class ContactVierfyCubit extends Cubit<ContactVierfyState> {
  ContactVierfyCubit() : super(ContactVierfyInitials());
  ContactVerfy? contactVerfy = ContactVerfy();

  Future<void> getContactFetch(BuildContext context,
      {required List checkData}) async {
    emit(ContactVierfyLoading());
    List list=[];
    checkData.forEach((element) {
      String a=element.phoneNumber.replaceAll('+','');
      String b=a.replaceAll('-','');
      String c=b.replaceAll('(','');
      String d=c.replaceAll(')','');
      String e=d.replaceAll(' ','');
      if(e.length==10){
        e="$countryCodeSelect$e";
      }
      print(e);
      print(element.userName);
      print("elementLength : ${e.length}");
      list.add({
        "phoneNumber":"$e",
        "userName":element.userName
      });
    });

    Map<String, dynamic> body = {
      "decData":{"checkData":list}
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      log('encode : ${response.data}');
      Decryption? data = await DioClient()
          .decryptData(ApiConstants.getVerifiedContact, response.data!);
      log('Decryption ${data?.data}');
      if (data != null) {
        contactVerfy = await DioClient().getVerifiedContact(data.data!);
        if (contactVerfy != null && contactVerfy!.status!) {
          // flutterToast(contactVerfy!.message!, true);
          emit(ContactVierfySuccess());
        } else {
          emit(ContactVierfyError());
          flutterToast(contactVerfy!.message!, false);
        }
      } else {
        emit(ContactVierfyError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(ContactVierfyError());
      flutterToast("Something went wrong!", false);
    }
  }
}
