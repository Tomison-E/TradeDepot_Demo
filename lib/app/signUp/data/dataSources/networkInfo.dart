import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_riverpod/all.dart';

abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo{

  NetworkInfoImpl(this._read);
  final Reader _read;


  @override
  Future<bool> get isConnected => _read(customConnectionCheckerProvider).hasConnection;

}


final dataConnectionCheckerProvider = Provider((ref) => DataConnectionChecker());
final customConnectionCheckerProvider = Provider<Connection>((ref) => CustomDataConnectionChecker(ref.read));

 abstract class Connection{
  Future<bool> get hasConnection;
 }

class CustomDataConnectionChecker implements Connection {
  CustomDataConnectionChecker(this._read);
  final Reader _read;

  @override
  Future<bool> get hasConnection => _read(dataConnectionCheckerProvider).hasConnection;



}