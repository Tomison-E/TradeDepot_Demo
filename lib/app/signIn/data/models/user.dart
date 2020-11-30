
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


@freezed
abstract class User with _$User {
@Assert('email.isNotEmpty', 'email cannot be empty')
@Assert('username.length>1', 'username should be atleast two characters')

 factory User({@required String firstName, @required String lastName,
@required String email, @required String username,int level, int stage}) = _User;

factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}




