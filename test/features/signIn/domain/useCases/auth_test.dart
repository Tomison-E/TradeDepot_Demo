
import 'package:mockito/mockito.dart';
import 'package:tradedepot_demo/app/signUp/domain/useCases/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradedepot_demo/app/signUp/domain/user_repository.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

class MockUserRepository extends Mock implements UserRepository{}

void main() {
  Auth useCase;
  MockUserRepository mockUserRepository;


  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = Auth(mockUserRepository);
  });

  final tEmail = "ty@gmail.com";
  final tPassword = "Password";

  test('should get auth status from repository when called', () async {
    //arrange
    when(mockUserRepository.signIn(any, any)).thenAnswer((_) async =>
        ApiResult.success(data: true));

    // act
    final result = await useCase(Params(email: tEmail, password: tPassword));
    // assert

    expect(result, ApiResult.success(data: true));
    verify(mockUserRepository.signIn(tEmail, tPassword));
    verifyNoMoreInteractions(mockUserRepository);
  });
}