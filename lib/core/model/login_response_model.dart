import 'package:medb/core/model/menu_model.dart';
import 'package:medb/core/model/user_details_model.dart';

class LoginResponse {
  final String accessToken;
  final String loginKey;
  final UserDetails userDetails;
  final List<MenuData> menuData;

  LoginResponse({
    required this.accessToken,
    required this.loginKey,
    required this.userDetails,
    required this.menuData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] ?? '',
      loginKey: json['loginKey'] ?? '',
      userDetails: UserDetails.fromJson(json['userDetails'] ?? {}),
      menuData: (json['menuData'] as List<dynamic>?)
          ?.map((item) => MenuData.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}



