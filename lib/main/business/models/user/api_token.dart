
class ApiToken {
  String token;

  ApiToken({required this.token});

  factory ApiToken.fromJson(Map<String, dynamic> json) {
    String token = json['token'];
    return ApiToken(token: token);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}