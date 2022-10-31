// ignore_for_file: unrelated_type_equality_checks

import 'package:adv_flutter_course/data/data_source/remote_data_source.dart';
import 'package:adv_flutter_course/data/mappers/mapper.dart';
import 'package:adv_flutter_course/data/network/network_info.dart';
import 'package:adv_flutter_course/domain/model/models.dart';
import 'package:adv_flutter_course/data/network/requests.dart';
import 'package:adv_flutter_course/data/network/failure.dart';
import 'package:adv_flutter_course/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // it connected to internet , it is safe to call API
      final response = await _remoteDataSource.login(loginRequest);
      if (response.status == 0) {
        //success // return data
        return Right(response.toDomain());
      } else {
        //failure error , return either  left

        return left(Failure(409, response.message ?? "business error message"));
      }
    } else {
      //return internet connection error , return left
      return left(Failure(501, "please check your internet connection"));
    }
  }
}
