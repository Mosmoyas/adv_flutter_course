class LoginRequest {
  String email;
  String password;

  // to carry the required paramaters to the API in the AuthenticationResponse class
  LoginRequest(this.email, this.password);
}
