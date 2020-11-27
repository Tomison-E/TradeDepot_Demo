import 'package:flutter_riverpod/all.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradedepot_demo/app/signUp/data/dataSources/networkInfo.dart';

class _FakeDataConnectionChecker implements Connection {
  bool val = true;

  @override
  Future<bool> get hasConnection => Future.value(val);

}

  void main() {
    group('test isConnected', (){
      final container = ProviderContainer(
          overrides: [
            customConnectionCheckerProvider.overrideWithProvider(Provider((ref)=> _FakeDataConnectionChecker()))
          ]
      );


      test('should forward the call to DataConnectionChecker.hasConnection', () async{
        // act
        final result = await container.read(customConnectionCheckerProvider).hasConnection;

        //assert
        expect(result, true);
      });

    });
  }

