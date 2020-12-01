import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedepot_demo/app/signIn/domain/useCases/auth.dart';
import 'package:meta/meta.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({@required this.getIt}) : super(AuthState(isSuccessful: ApiResult.success(data:false),isLoading: false));
  final getIt;

  void getUser(String email,String password) async{
    final isSignedIn = await getIt.get<Authenticate>()(Params(email: email, password: password));
    return emit(AuthState(isSuccessful: isSignedIn,isLoading: state.isLoading));
  }

  void busy()=> emit(AuthState(isSuccessful: state.isSuccessful,isLoading: true));

 /* void getCurrentUser(){
    final user = getIt.get<GetCurrentUser>()(NoParams());
  }*/

}