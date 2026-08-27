import 'dart:io';

class ApiConst {
  ApiConst._();

  static const String contentType = 'application/json';

  static const String baseUrl = '';

  static const String subscriptionsEndPoint = '/api/v1/subscriptions/plans';

  static const String _googleMapAPIKeyAndroid =
      "AIzaSyAoHGQktk5y--nUH7Q8ZHUcNuUa_rHTFQo";
  static const String _googleMapAPIKeyIOS =
      "AIzaSyA5vRiUsDawykjIT0GpCKgJ_20f-6eHWFA";

  static const String staticGoogleAPIKey =
      "AIzaSyAzaYcSFRWOySuMNQMzAYPIVhvvF3eieDY";

  static String get googleAPIKey =>
      Platform.isIOS ? _googleMapAPIKeyIOS : _googleMapAPIKeyAndroid;

  static String professionalSignUp = "/api/v1/auth/signup-professional-v2";
  static String practiceSignUp = "/api/v1/auth/signup-practice-v2";
  static String supplierSignUp = "/api/v1/auth/signup-supplier-v2";
  static String adminSignUp = "";
  static String login = "/api/v1/auth/login-v2";
  static const String resendMail = '/api/v1/event/resend-verification-mail';
  static const String adminApproveUser = '/api/v1/event/admin-approve-user/';
  static String refreshToken = '/api/v1/auth/refresh-token_v2';
  static String newsfeedCreation = '/api/v1/newsfeeds';
}
