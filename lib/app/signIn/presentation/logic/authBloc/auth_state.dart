part of 'auth_cubit.dart';

class AuthState {
  final ApiResult<bool> isSuccessful;
  final bool isLoading;
  AuthState({@required this.isSuccessful, this.isLoading});


/*
  @override
  List<Object> get props => [this.isSuccessful,this.isLoading];*/

}