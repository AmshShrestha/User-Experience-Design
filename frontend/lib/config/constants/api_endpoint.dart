class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // static const String baseUrl = "http://192.168.56.1:3000/api/v1/";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // static const String imageUrl = "http://192.56.137.1:3000/uploads/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getUserProfile = "auth/";
  static const String updateUser = "auth/updateUser/";
  static const String deleteUser = "auth/deleteUser/";
  static const String uploadImage = "auth/uploadImage/";

  // ====================== Detail Routes ======================
  static const String createDetails = "detail/createDetails/";
  static const String deleteDetails = "detail/deleteDetails/";
  static const String uploadCoverPhoto = "auth/uploadImage/";
  static const String getAllDetails = "detail/";
}
