
import 'package:bloc/bloc.dart';

abstract class FcmTokenState {

}

class FcmTokenInitial extends FcmTokenState {}

class FcmTokenLoading extends FcmTokenState {}

class FcmTokenLoaded extends FcmTokenState {
  final String token;

  FcmTokenLoaded(this.token);
}

class FcmTokenError extends FcmTokenState{
  final String message;

  FcmTokenError(this.message);
}


class FcmTokenCubit extends Cubit<FcmTokenState>{

  FcmTokenCubit() : super(FcmTokenInitial());


  void setFcmToken(String token){
    emit(FcmTokenLoaded(token));
  }

  String? getFcmToken(){
    if(state is FcmTokenLoaded){
      return (state as FcmTokenLoaded).token;
    }
    return null;
  }


}