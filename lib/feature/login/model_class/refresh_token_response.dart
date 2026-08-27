class RefreshTokenResponse {
  final String? accessToken;
  final DateTime? expiresAt;
  final String? refreshToken;

  RefreshTokenResponse({
    this.accessToken,
    this.expiresAt,
    this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['accessToken'] as String?,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresAt': expiresAt?.toIso8601String(),
      'refreshToken': refreshToken,
    };
  }

  RefreshTokenResponse copyWith({
    String? accessToken,
    DateTime? expiresAt,
    String? refreshToken,
  }) {
    return RefreshTokenResponse(
      accessToken: accessToken ?? this.accessToken,
      expiresAt: expiresAt ?? this.expiresAt,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}