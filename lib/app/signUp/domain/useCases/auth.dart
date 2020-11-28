import 'package:tradedepot_demo/app/signUp/domain/user_repository.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';
import 'package:meta/meta.dart';
import 'package:tradedepot_demo/core/usecases/usecase.dart';



class Auth implements UseCase<bool,Params>{
  Auth(this.repository);

  final UserRepository repository;

  Future<ApiResult<bool>> call(Params params) async {

    return await repository.signIn(params.email,params.password);
  }

}


class Params {
  final String email;
  final String password;

  Params({@required this.email, @required this.password});
}