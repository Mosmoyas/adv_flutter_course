import 'package:analyzer/dart/ast/ast.dart';

class Failure {
  int code; // 200 201 400 500 303
  String message; // the message which will display to the user
 
  Failure(this.code, this.message);
}
