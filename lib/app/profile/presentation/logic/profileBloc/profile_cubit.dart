import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedepot_demo/app/profile/domain/useCases/get_user.dart';
import 'package:tradedepot_demo/core/networkExceptions/network_exceptions.dart';
import '../../../../signIn/data/models/user.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({@required this.getIt}) : super(ProfileLoading());
  final getIt;

 void getUser(String email) async{
   final user = await getIt.get<GetUser>()(Params(email: email));
   user.maybeWhen(
     success: (User data){
       emit(ProfileData(user: data));
     },
     failure: (NetworkExceptions exception) {
       emit(ProfileError(errorMsg: NetworkExceptions.getErrorMessage(exception)));
     },
     orElse: () {
       emit(ProfileError(errorMsg: "Unable to load user data"));
     },
   );
 }


}