
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/encryptions.dart';
import 'package:gftr/Model/updateProfile.dart';

import 'package:gftr/ViewModel/apiServices.dart';

abstract class ProfileState{}

class ProfileInitials extends ProfileState{}
class ProfileLoading extends ProfileState{}
class ProfileError extends ProfileState{}
class ProfileSuccess extends ProfileState{}


class ProfileCubit extends Cubit<ProfileState> {

  ProfileCubit() : super(ProfileInitials());

  Future<UpdateProfile?> verifyOtpService(String email,String userName,String password) async {

    emit(ProfileLoading());

    Map<String,dynamic> body = {
      "decData": {
        "username":userName,
        "email":email,
        "password":password
      }
    };

    Encryption? response = await DioClient().encryptData(body);
    if(response!=null && response.status!){
      Decryption? data = await DioClient().decryptData(ApiConstants.updateProfile,response.data!);
      if(data!=null){
        UpdateProfile? profileUpdate = await DioClient().updateProfile(data.data!);
        if(profileUpdate!=null && profileUpdate.status!){
          emit(ProfileSuccess());
          return profileUpdate;
        }else{
          emit(ProfileError());
          return null;
        }
      }else{
        emit(ProfileError());
        return null;
      }
    }else{
      emit(ProfileError());
      return null;
    }
  }

}