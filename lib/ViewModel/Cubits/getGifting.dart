import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/getgifting.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/apiServices.dart';
import 'package:gftr/ViewModel/prefsService.dart';

abstract class GetgifingState {}

class GetgifingInitials extends GetgifingState {}

class GetgifingLoading extends GetgifingState {}

class GetgifingError extends GetgifingState {}

class GetgifingSuccess extends GetgifingState {}

class GetgifingCubit extends Cubit<GetgifingState> {
  GetgifingCubit() : super(GetgifingInitials());
  SharedPrefsService prefsService = SharedPrefsService();
 // GetGifting getGifting = GetGifting();

  Future<void> Get_Gifting(BuildContext context,
      {required String birthday,
      required String street,
      required String unit,
      required String city,
      required String zipcode,
      required String state,
      required String country,
      required bool isPrivate
      }) async {
    emit(GetgifingLoading());
    Map<String, dynamic> body = {
      "decData": {
        "birthday": birthday,
        "isPrivate": isPrivate,
        "street": street,
        "unit": unit,
        "city": city,
        "zipcode": zipcode,
        "state": state,
        "country": country,
      }
    };
    Encryption? response = await DioClient().encryptData(body);
    if (response != null && response.status!) {
      Decryption? data = await DioClient()
          .decryptData(ApiConstants.getGifting, response.data!);
      if (data != null) {
        GetGifting? getGifting = await DioClient().getGifting(data.data!);
        print(getGifting!.data);
        if (getGifting != null && getGifting.status!) {
          emit(GetgifingSuccess());
          log("${getGifting.data?.phoneNumber}");
          phoneNumberPre = getGifting.data!.phoneNumber.toString();
          emailPre = getGifting.data!.email.toString();
          street=getGifting.data?.street.toString() ?? '';
          unit=getGifting.data?.unit.toString() ?? '';
          zipcode=getGifting.data?.zipcode.toString() ?? '';
          contry=getGifting.data?.country.toString() ?? '';
          state=getGifting.data?.state.toString() ?? '';
          city=getGifting.data?.city.toString() ?? '';
         // adressPre = "${getGifting.data?.street ?? ''},${getGifting.data?.unit ?? ''},${getGifting.data?.city ?? ''},${getGifting.data?.zipcode ?? ''},${getGifting.data?.state ?? ''},${getGifting.data?.country ?? ''}";
          profileNamePre =
              "${getGifting.data?.firstname} ${getGifting.data?.lastname}";
          birthDayPre =
              "${getGifting.data?.birthday?.month.toString().padLeft(2, '0')}/${getGifting.data?.birthday?.day.toString().padLeft(2, '0')}/${getGifting.data?.birthday?.year}";
          prefsService.setStringData('phoneNumberPre', phoneNumberPre);
          prefsService.setStringData('emailPre', emailPre);
          prefsService.setStringData('street', street);
          prefsService.setStringData('unit', unit);
          prefsService.setStringData('zipcode', zipcode);
          prefsService.setStringData('contry', contry);
          prefsService.setStringData('state', state);
          prefsService.setStringData('city', city);
          prefsService.setStringData('birthDayPre', birthDayPre);
          prefsService.setStringData('profileNamePre', profileNamePre);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GfterStoryViewPage()),
            (route) => false,
          );
          // flutterToast(getGifting.message!, true);
          bottombarblack = true;
        } else {
          emit(GetgifingError());
          flutterToast(getGifting?.message ?? '', false);
        }
      } else {
        emit(GetgifingError());
        flutterToast("Something went wrong!", false);
      }
    } else {
      emit(GetgifingError());
      flutterToast("Something went wrong!", false);
    }
  }
}
