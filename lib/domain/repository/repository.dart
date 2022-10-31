import 'package:adv_flutter_course/data/network/failure.dart';
import 'package:adv_flutter_course/data/network/requests.dart';
import 'package:adv_flutter_course/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  //LoginRequest class the network in Data Layer

  // we will get errors which comes from Failure Object or success which comes from Authentication Object
  // we rounded the Either Object with Future because the Post Method is already Future class which is async call

  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
