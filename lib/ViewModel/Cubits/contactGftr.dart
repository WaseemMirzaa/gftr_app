
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/contactGftr.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class ContactGftrState{}

class ContactGftrInitials extends ContactGftrState{}
class ContactGftrLoading extends ContactGftrState{}
class ContactGftrError extends ContactGftrState{}
class ContactGftrSuccess extends ContactGftrState{}


class ContactGftrCubit extends Cubit<ContactGftrState> {
  ContactGftrCubit() : super(ContactGftrInitials());

  bool isButtonClicked = false;

  Future<void> contactGftrService(BuildContext context,String name) async {
    emit(ContactGftrLoading());
    ContactGftr? contactGftr = ContactGftr();
    isButtonClicked = true;

    Map<String,dynamic> body = {
      "decData": {
        //"name":name,
        // "email":email,
        // "phone":phone,
         "text":name
      }
    };

    Encryption? response = await DioClient().encryptData(body);
    if(response!=null && response.status!){
      Decryption? data = await DioClient().decryptData(ApiConstants.contactGftr,response.data!);
      if(data!=null){
    contactGftr = await DioClient().contactGftr(data.data!);
        if(contactGftr!=null && contactGftr.status!){
          emit(ContactGftrSuccess());
          Navigator.pop(context);
          // flutterToast(contactGftr.message!,true);
        }else{
          emit(ContactGftrError());
          flutterToast(contactGftr?.message??'',false);
        }
      }else{
        emit(ContactGftrError());
        flutterToast(contactGftr.message!,false);
      }
    }else{
      emit(ContactGftrError());
      flutterToast(contactGftr.message!,false);
    }
    isButtonClicked = false;
  }

}