import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Model/decryption.dart';
import 'package:gftr/Model/get_sll_users.dart';
import 'package:gftr/ViewModel/apiServices.dart';

abstract class UsersviewsState {}

class UsersviewsInitials extends UsersviewsState {}

class UsersviewsLoading extends UsersviewsState {}

class UsersviewsError extends UsersviewsState {}

class UsersviewsSuccess extends UsersviewsState {}

class UsersviewsCubit extends Cubit<UsersviewsState> {
  UsersviewsCubit() : super(UsersviewsInitials());
  ViewAllUsers? viewAllUsers = ViewAllUsers();
  Future<void> users_views() async {
    emit(UsersviewsLoading());
    Decryption? data = await DioClient().decryptDataGetMethod(ApiConstants.view_all_users);
    if (data != null) {
      viewAllUsers = await DioClient().View_users(data.data!);
      if (viewAllUsers != null && viewAllUsers!.status!) {
        emit(UsersviewsSuccess());
      } else {
        emit(UsersviewsError());
      }
    } else {
      emit(UsersviewsError());
    }
  }

}