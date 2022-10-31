import 'package:adv_flutter_course/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';
part 'app_api.g.dart';

// @RestApi>> JsonSerializable}) =>>>>> package:retrofit/http.dart

// passing base Url from MockLab Api
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
// login implementation and the run the code in terminal to update the Post
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
}
