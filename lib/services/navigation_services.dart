import 'package:di360_flutter/main.dart';
import 'package:flutter/material.dart';

final navigationService = NavigationService();

class NavigationService extends NavigatorObserver {
  static final NavigationService _instance = NavigationService._internal();
  final Set<String> _pendingRoutes = <String>{};
  final Set<String> _pendingActions = <String>{};
  String? _currentRouteName;

  factory NavigationService() {
    return _instance;
  }
  NavigationService._internal();

  Future<dynamic>? runOnce(
      String key, Future<dynamic> Function() action) async {
    if (_pendingActions.contains(key) || _pendingRoutes.contains(key)) {
      return null;
    }

    _pendingActions.add(key);
    try {
      return await action();
    } finally {
      _pendingActions.remove(key);
    }
  }

  Future<dynamic>? navigateTo(String routeName) {
    if (!_canNavigateTo(routeName)) {
      return null;
    }

    _pendingRoutes.add(routeName);
    final navigation = navigatorKey.currentState?.pushNamed(routeName);
    if (navigation == null) {
      _pendingRoutes.remove(routeName);
    } else {
      navigation.whenComplete(() => _pendingRoutes.remove(routeName));
    }
    return navigation;
  }

  Future<dynamic>? popAndNavigateTo(String routeName) {
    return navigatorKey.currentState?.popAndPushNamed(routeName);
  }

  Future<dynamic>? push(Widget page) {
    return navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => page));
  }

  Future<dynamic>? navigateToWithParams(String routeName, {dynamic params}) {
    if (!_canNavigateTo(routeName)) {
      return null;
    }

    _pendingRoutes.add(routeName);
    final navigation =
        navigatorKey.currentState?.pushNamed(routeName, arguments: params);
    if (navigation == null) {
      _pendingRoutes.remove(routeName);
    } else {
      navigation.whenComplete(() => _pendingRoutes.remove(routeName));
    }
    return navigation;
  }

  bool _canNavigateTo(String routeName) {
    return !_pendingRoutes.contains(routeName) &&
        _currentRouteName != routeName;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRouteName = route.settings.name;
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRouteName = previousRoute?.settings.name;
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _currentRouteName = newRoute?.settings.name;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
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
