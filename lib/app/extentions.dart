import 'package:adv_flutter_course/app/constants.dart';

extension NonNullInteger on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullString on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}
///https://mosmoyas.mocklab.io/  
///