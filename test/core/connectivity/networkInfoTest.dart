import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/core/connectivity/networkInfo.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

  void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;


  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });


    group('test isConnected', (){

      test('should forward the call to DataConnectionChecker.hasConnection', () async{
        // arrange
        final tHasConnection = Future.value(true);

        when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnection);

        //act
        final result = networkInfoImpl.isConnected;

        //assert
        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      });

    });
  }

