import 'package:tradedepot_demo/app/signIn/domain/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';
import 'package:tradedepot_demo/core/usecases/usecase.dart';

class GetCurrentUser implements UseCase<ApiResult<Auth.User>,NoParams>{
  GetCurrentUser(this.repository);

  final UserRepository repository;

  Future<ApiResult<Auth.User>> call(NoParams noParams) {
    return repository.getCurrentUser();
  }

}

class NoParams{}

