const String forgotPasswordQuery =
    r'''mutation myMutation($details: ForgotInput!) { forget_password(details: $details) { message status __typename } }''';
