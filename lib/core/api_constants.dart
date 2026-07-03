
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
}
