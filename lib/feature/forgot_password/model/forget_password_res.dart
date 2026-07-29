class ForgetPasswordRes {
  final ForgetPasswordData? data;

  ForgetPasswordRes({this.data});

  factory ForgetPasswordRes.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRes(
      data: json['data'] != null
          ? ForgetPasswordData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class ForgetPasswordData {
  final ForgetPassword? forgetPassword;

  ForgetPasswordData({this.forgetPassword});

  factory ForgetPasswordData.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordData(
      forgetPassword: json['forget_password'] != null
          ? ForgetPassword.fromJson(
              json['forget_password'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forget_password': forgetPassword?.toJson(),
    };
  }
}

class ForgetPassword {
  final String message;
  final String status;
  final String typename;

  ForgetPassword({
    required this.message,
    required this.status,
    required this.typename,
  });

  factory ForgetPassword.fromJson(Map<String, dynamic> json) {
    return ForgetPassword(
      message: json['message']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      typename: json['__typename']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      '__typename': typename,
    };
  }
}