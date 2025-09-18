# AGENTS.md - DI360 Flutter Project

## Build/Lint/Test Commands
- `flutter run` - Start development build
- `flutter build apk` - Build Android APK 
- `flutter build ios` - Build iOS app
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run single test file
- `flutter analyze` - Static analysis and linting
- `flutter pub get` - Install dependencies

## Architecture & Structure
- **Provider pattern**: State management using ChangeNotifier ViewModels
- **Feature-based**: Code organized by features in `lib/feature/`
- **Core services**: HTTP, navigation, local storage in `lib/core/` and `lib/services/`
- **Repository pattern**: Data layer abstraction in each feature
- **Assets**: Images, fonts, JSON data in `assets/` folder

## Code Style & Conventions
- **Imports**: Package imports first, then local imports with absolute paths like `package:di360_flutter/`
- **Naming**: camelCase for variables/methods, PascalCase for classes, snake_case for files
- **ViewModels**: Extend ChangeNotifier, use mixins (like ValidationMixins) for shared behavior
- **Controllers**: TextEditingController for form inputs, dispose in dispose() method
- **State**: Call notifyListeners() after state changes
- **Error handling**: Try-catch blocks with user-friendly messages via ToastMessage.show()
