import 'package:adv_flutter_course/data/network/failure.dart';
import 'package:adv_flutter_course/domain/model/models.dart';
import 'package:adv_flutter_course/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/requests.dart';
import 'base_usecase.dart';

//abstract class BaseUseCase<In, Out>
// { Future<Either<Failure, Out>> execute(In input);
// }
class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;

  String password;

  LoginUseCaseInput(this.email, this.password);
}
