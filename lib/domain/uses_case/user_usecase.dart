import 'package:flutter_application_1/data/repository/User_repository.dart';
import 'package:flutter_application_1/domain/entities/credential_entities.dart';

class SignUpUserUseCase {
  final UserRepository _userRepository;

  SignUpUserUseCase(this._userRepository);

  Future<void> execute(Credentials credentials) async {
    await _userRepository.signUp(
      credentials.email, 
      credentials.password, 
      credentials.name, 
      credentials.age
    );
  }
}