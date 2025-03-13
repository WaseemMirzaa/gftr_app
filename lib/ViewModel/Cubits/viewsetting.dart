import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/viewsetting.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class ViewSettingState {}

class ViewSettingInitials extends ViewSettingState {}

class ViewSettingLoading extends ViewSettingState {}

class ViewSettingError extends ViewSettingState {}

class ViewSettingSuccess extends ViewSettingState {}

class ViewSettingCubit extends Cubit<ViewSettingState> {
  ViewSettingCubit() : super(ViewSettingInitials());
  ViewSetting? viewSetting = ViewSetting();
  Future<void> getviewSetting() async {
    emit(ViewSettingLoading());
    Decryption? data =
        await DioClient().decryptDataGetMethod(ApiConstants.viewSetting);
    if (data != null) {
      viewSetting = await DioClient().viewSetting(data.data!);
      if (viewSetting != null && viewSetting!.status!) {
        emit(ViewSettingSuccess());
        // flutterToast(viewSetting!.message!, true);
        phoneNumberPre = viewSetting?.data?.phoneNumber.toString() ?? '';
        emailPre = viewSetting?.data?.email ?? '';
        street=viewSetting?.data?.street ?? '';
        unit=viewSetting?.data?.unit ?? '';
        zipcode=viewSetting?.data?.zipcode ?? '';
        contry=viewSetting?.data?.country ?? '';
        state=viewSetting?.data?.state ?? '';
        city=viewSetting?.data?.city ?? '';
       // adressPre = viewSetting?.data?.address ?? '';
        User_id =viewSetting?.data?.id.toString() ?? '';
        birthDayPre = "${viewSetting?.data?.birthday.day.toString().padLeft(2, '0')}/${viewSetting?.data?.birthday.month.toString().padLeft(2, '0')}/${viewSetting?.data?.birthday?.year}";
      } else {
        emit(ViewSettingError());
      }
    } else {
      emit(ViewSettingError());
    }
  }
}
