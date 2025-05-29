import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/all_gift.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class Fetch_All_GiftsState{}

class Fetch_All_GiftsInitials extends Fetch_All_GiftsState{}
class Fetch_All_GiftsLoading extends Fetch_All_GiftsState{}
class Fetch_All_GiftsError extends Fetch_All_GiftsState{}
class Fetch_All_GiftsSuccess extends Fetch_All_GiftsState{}


class Fetch_All_GiftsCubit extends Cubit<Fetch_All_GiftsState> {
  Fetch_All_GiftsCubit() : super(Fetch_All_GiftsInitials());

  Allgifts? allgifts =  Allgifts();

  Future<void> Fetch_All_GiftsService() async {
    emit(Fetch_All_GiftsLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.all_gifts);
    
        if(data!=null){
      allgifts = await DioClient().All_My_Gifts(data.data!);
      if(allgifts!=null && allgifts!.status!){
        emit(Fetch_All_GiftsSuccess());
      }else{
        emit(Fetch_All_GiftsError());
      }
    }else{
      emit(Fetch_All_GiftsError());
    }
  }

}