import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

abstract class UseCase <T, Params> {
  Future <T> call (Params params) ;
}