import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo{

  NetworkInfoImpl(this._dataConnectionChecker);
  final DataConnectionChecker _dataConnectionChecker;


  @override
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;

}


//final dataConnectionCheckerProvider = Provider((ref) => DataConnectionChecker());
//final customConnectionCheckerProvider = Provider<Connection>((ref) => CustomDataConnectionChecker(ref.read));
//final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImpl(ref.read));

 /*abstract class Connection{
  Future<bool> get hasConnection;
 }

class CustomDataConnectionChecker implements Connection {
  CustomDataConnectionChecker(this._read);
  final Reader _read;

  @override
  Future<bool> get hasConnection => _read(dataConnectionCheckerProvider).hasConnection;



}*/