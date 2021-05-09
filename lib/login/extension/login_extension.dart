import '../enum/login_enum.dart';

extension ILoginServicePathExtension on ILoginServicePath {
  String get value {
    switch (this) {
      case ILoginServicePath.LOGIN:
        return '/login';
      default:
        return '';
    }
  }
}
