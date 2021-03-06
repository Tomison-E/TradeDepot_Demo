import 'package:flutter/cupertino.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/usecases/usecase.dart';

import '../profile_repository.dart';

class GetUser implements UseCase<User,Params>{
  GetUser(this.repository);

  final ProfileRepository repository;

  Future<User> call(Params params) async {

    return repository.getUser(params.email);
  }

}


class Params {
  final String email;

  Params({@required this.email});
}