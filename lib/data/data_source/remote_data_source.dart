// this class to talk to the AppService class in app_api fileto the Login (post) Method
import 'package:adv_flutter_course/data/network/app_api.dart';
import 'package:adv_flutter_course/data/responses/responses.dart';

import '../network/requests.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
