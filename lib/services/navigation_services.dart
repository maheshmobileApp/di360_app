import 'package:di360_flutter/main.dart';
import 'package:flutter/material.dart';

final navigationService = NavigationService();

class NavigationService extends NavigatorObserver{
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }
  NavigationService._internal();

  Future<dynamic>? navigateTo(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  Future<dynamic>? popAndNavigateTo(String routeName) {
    return navigatorKey.currentState?.popAndPushNamed(routeName);
  }

  Future<dynamic>? push(Widget page) {
    return navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => page));
  }

  Future<dynamic>? navigateToWithParams(String routeName, {dynamic params}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: params);
  }

  void goBack({dynamic params}) {
    return navigatorKey.currentState?.pop(params);
  }

  void replaceWith(String routeName, {dynamic params}) {
    navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: params);
  }

  void pushNamedAndRemoveUntil(String routeName, {dynamic params}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: params);
  }
}
