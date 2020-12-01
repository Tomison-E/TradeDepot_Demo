part of 'profile_cubit.dart';
/*class ProfileState extends Equatable{
  final User user;

  ProfileState({@required this.user});



  @override
  List<Object> get props => [this.user];

}*/

@immutable
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileData extends ProfileState {
  final User user;

  ProfileData({@required this.user});
}

class ProfileError extends ProfileState {
  final String errorMsg;

  ProfileError({@required this.errorMsg});
}