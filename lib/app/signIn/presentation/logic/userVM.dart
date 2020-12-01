/*
import 'package:flutter_riverpod/all.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/app/signIn/domain/useCases/auth.dart';
import 'package:tradedepot_demo/app/signIn/domain/useCases/get_current_user.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';
import 'package:tradedepot_demo/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

class UserVM extends StateNotifier<User> {
  UserVM(this._read, [User user]) : super(user ?? null);
  final Reader _read;


  Future<ApiResult<bool>> signIn(String email, String password) {
    return _read(getItProvider).get<Authenticate>()(Params(email: email, password: password));
  }

  Future<ApiResult<Auth.User>> getCurrentUser() => _read(getItProvider).get<GetCurrentUser>()(NoParams());


}

final userVMProvider = StateNotifierProvider((ref) => UserVM(ref.read));*/
