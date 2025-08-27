import 'package:medb/core/model/menu_module_model.dart';
import 'package:medb/core/model/user_details_model.dart';

class LoginResponse {
  final String accessToken;
  final String loginKey;
  final UserDetails userDetails;
  final List<MenuModule> menuData;

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
          ?.map((item) => MenuModule.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'loginKey': loginKey,
      'userDetails': userDetails.toJson(),
      'menuData': menuData.map((module) => module.toJson()).toList(),
    };
  }
}
