import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tradedepot_demo/app/profile/presentation/ui/widgets/user_bar.dart';
import 'package:tradedepot_demo/app/profile/presentation/ui/widgets/verification_bar.dart';
import 'package:tradedepot_demo/app/signIn/data/models/user.dart';
import 'package:tradedepot_demo/core/networkExceptions/network_exceptions.dart';
import 'package:tradedepot_demo/src/res/colours.dart';
import 'package:tradedepot_demo/src/res/style.dart';
import 'package:tradedepot_demo/app/profile/presentation/logic/profileVM.dart';
import 'package:tradedepot_demo/src/constants/uiData.dart';


final $user = FutureProvider.autoDispose.family;
final userPages =
$user<User, String>(
      (ref, email) async {
    final repository = ref.watch(profileVMProvider);
    //ref.watch(repositoryState);
    final user = await repository.getUser(email);
    // Once a page was downloaded, preserve its state to avoid re-downloading it again.
    ref.maintainState = true;
    return user;
  },
);


/*final repositoryState = Provider<User>((ref){
  return ref.watch(userRepositoryProvider.state);
});*/

/*final user =
Provider.autoDispose<AsyncValue<User>>((ref) {
  final email = ref.read(fireBaseAuthProvider).currentUser.email;
  return ref.watch(userPages(email)).whenData((value){
    User userData;
    value.docs.forEach((doc) {
      userData = User.fromJson(doc.data());
    });
    return userData;
  }
  );
});*/

/*final docID = Provider.autoDispose<AsyncValue<String>>((ref) {
  final email = ref.read(fireBaseAuthProvider).currentUser.email;
  return ref.watch(userPages(email)).whenData((value){
    String id;
    value.docs.forEach((doc) {
      id = doc.id;
    });
    return id;
  }
  );
}
);*/


class Profile extends ConsumerWidget{
 final String email;
 Profile(this.email);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(userPages(email)).when(
        loading: () =>
            Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
        error: (err, stack) {
          return Center(
            child: Text(NetworkExceptions.getErrorMessage(NetworkExceptions.getDioException(err))),
          );
        },
        data: (user) {
          if(user == null){
            return Center(
              child: Text('Error Loading Data'),
            );
          }
          return Container(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserBar(user.firstName,user.lastName,user.username,user.email),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 150,
                        decoration: BoxDecoration(border: Border.all(
                            color: Colours.regText),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text("KYC LV ${user.level}", style: Style.regText),
                        alignment: Alignment.center,
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text("Upgrade to level ${user.stage}", style: TextStyle(
                              color: Color.fromRGBO(108, 210, 207, 1.0),
                              fontSize: 14.0,
                              fontStyle: FontStyle.italic)))
                    ], mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Text("Verification", style: TextStyle(
                          color: Colours.navBarText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                      RaisedButton(onPressed: () {},
                        child: Text(user.level>0 ? "Continue Verification":"Begin Verification", style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0)),
                        color: Color.fromRGBO(108, 210, 207, 1.0),
                        highlightColor: Colors.white,
                        hoverColor: Colors.black,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),)
                    ], mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),

                  const SizedBox(height: 20),
                  Text("Complete steps below to get verified",
                      style: Style.regText),
                  const SizedBox(height: 30),
                  VerificationBar(
                      icon: Icons.account_balance_rounded, level:1, label:"BVN Verification",activeLevel:user.stage),
                  const SizedBox(height: 20),
                  VerificationBar(
                      icon:Icons.contact_mail, level:2, label:"Passport Verification", activeLevel:user.stage),
                  const SizedBox(height: 20),
                  VerificationBar(icon:Icons.link, level:3, label:"Link Bank account",activeLevel:user.stage),

                ], crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          );
        }
    );
  }

  String getRoute(int val){
    switch(val){
      case 1 : return UIData.bvnRoute;
      case 2 : return UIData.passportRoute;
      case 3 : return UIData.otpRoute;
    }
    return UIData.unknown;
  }



  //void verification(BuildContext context,String route) async{
    /* Navigator.pushNamed(context, route).then((value) {
      if(value){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: new Text("Awaiting Approval")
        ));
      }
    })*/
  /*  Navigator.pushNamed(context, route).then((value) {
      if(value){
        reload(context);
      }
    });*/
  //}

/*  void reload(BuildContext context){
    context.read(userRepositoryProvider).refresh();
    //context.read(fireBaseAuthProvider).currentUser.delete();
  }*/

}