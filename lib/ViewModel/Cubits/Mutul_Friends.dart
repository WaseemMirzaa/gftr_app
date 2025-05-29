import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/Mutulfrd.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class MutualFrdsState {}

class MutualFrdsInitials extends MutualFrdsState {}

class MutualFrdsLoading extends MutualFrdsState {}

class MutualFrdsError extends MutualFrdsState {}

class MutualFrdsSuccess extends MutualFrdsState {}

class MutualFrdsCubit extends Cubit<MutualFrdsState> {
  MutualFrdsCubit() : super(MutualFrdsInitials());
  Mutulfriendd? mutulfriendd = Mutulfriendd();
  Future<void> mutual_frds() async {
    emit(MutualFrdsLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(
        ApiConstants.Mutul_friend);
        
    if (data != null) {
      mutulfriendd = await DioClient().GetMutualFrdS(data.data!);
      if (mutulfriendd != null && mutulfriendd!.status!) {
        emit(MutualFrdsSuccess());
      } else {
        emit(MutualFrdsError());
      }
    } else {
      emit(MutualFrdsError());
    }
  }
}