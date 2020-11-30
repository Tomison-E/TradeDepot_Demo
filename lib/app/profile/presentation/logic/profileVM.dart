import 'package:flutter_riverpod/all.dart';
import 'package:tradedepot_demo/app/profile/domain/useCases/get_user.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';

import '../../../../injection_container.dart';

class ProfileVM extends StateNotifier<User> {
  ProfileVM(this._read, [User user]) : super(user ?? null);
  final Reader _read;

  Future<User> getUser(String email) => _read(getItProvider).get<GetUser>()(Params(email: email));

}

final profileVMProvider = StateNotifierProvider((ref) => ProfileVM(ref.read));