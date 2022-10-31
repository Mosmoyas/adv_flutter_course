// ignore_for_file: unrelated_type_equality_checks

import 'package:adv_flutter_course/data/data_source/remote_data_source.dart';
import 'package:adv_flutter_course/data/mappers/mapper.dart';
import 'package:adv_flutter_course/data/network/error_handler.dart';
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

      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success // return data
          return Right(response.toDomain());
        } else {
          //failure error , return either  left

          return left(
              Failure(ApiInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return internet connection error , return left // from getFailure comes Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION)
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
