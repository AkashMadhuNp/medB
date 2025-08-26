import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medb/core/model/login_response_model.dart';
import 'package:medb/core/model/menu_model.dart';
import 'package:medb/core/model/user_details_model.dart';

class AuthService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _accessTokenKey = 'access_token';
  static const String _loginKeyKey = 'login_key';
  static const String _userDetailsKey = 'user_details';
  static const String _menuDataKey = 'menu_data';
  static const String _isLoggedInKey = 'is_logged_in';

  static String? _accessToken;
  static String? _loginKey;
  static UserDetails? _userDetails;
  static List<MenuData>? _menuData;
  static bool _isLoggedIn = false;

  static Future<void> init() async {
    await _loadPersistedData();
  }

  static Future<void> storeLoginData(LoginResponse loginResponse) async {
    try {
      _accessToken = loginResponse.accessToken;
      _loginKey = loginResponse.loginKey;
      _userDetails = loginResponse.userDetails;
      _menuData = loginResponse.menuData;
      _isLoggedIn = true;

      await Future.wait([
        _storage.write(key: _accessTokenKey, value: loginResponse.accessToken),
        _storage.write(key: _loginKeyKey, value: loginResponse.loginKey),
        _storage.write(key: _userDetailsKey, value: _encodeUserDetails(loginResponse.userDetails)),
        _storage.write(key: _menuDataKey, value: _encodeMenuData(loginResponse.menuData)),
        _storage.write(key: _isLoggedInKey, value: 'true'),
      ]);

      print('AuthService: Login data stored successfully');
    } catch (e) {
      print('AuthService: Error storing login data: $e');
      throw Exception('Failed to store login data');
    }
  }

  static String? get accessToken => _accessToken;

  static String? get loginKey => _loginKey;

  static UserDetails? get userDetails => _userDetails;

  static List<MenuData>? get menuData => _menuData;

  static bool get isLoggedIn => _isLoggedIn && _accessToken != null;

  static Future<void> clearLoginData() async {
    try {
      _accessToken = null;
      _loginKey = null;
      _userDetails = null;
      _menuData = null;
      _isLoggedIn = false;

      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _loginKeyKey),
        _storage.delete(key: _userDetailsKey),
        _storage.delete(key: _menuDataKey),
        _storage.delete(key: _isLoggedInKey),
      ]);

      print('AuthService: Login data cleared successfully');
    } catch (e) {
      print('AuthService: Error clearing login data: $e');
    }
  }

  static Future<void> updateAccessToken(String newAccessToken) async {
    try {
      _accessToken = newAccessToken;
      await _storage.write(key: _accessTokenKey, value: newAccessToken);
      print('AuthService: Access token updated successfully');
    } catch (e) {
      print('AuthService: Error updating access token: $e');
    }
  }

  static Future<void> _loadPersistedData() async {
    try {
      final isLoggedIn = await _storage.read(key: _isLoggedInKey);
      
      if (isLoggedIn == 'true') {
        final accessToken = await _storage.read(key: _accessTokenKey);
        final loginKey = await _storage.read(key: _loginKeyKey);
        final userDetailsStr = await _storage.read(key: _userDetailsKey);
        final menuDataStr = await _storage.read(key: _menuDataKey);

        if (accessToken != null && loginKey != null) {
          _accessToken = accessToken;
          _loginKey = loginKey;
          _isLoggedIn = true;

          if (userDetailsStr != null) {
            _userDetails = _decodeUserDetails(userDetailsStr);
          }

          if (menuDataStr != null) {
            _menuData = _decodeMenuData(menuDataStr);
          }

          print('AuthService: Persisted data loaded successfully');
        }
      }
    } catch (e) {
      print('AuthService: Error loading persisted data: $e');
      await clearLoginData();
    }
  }

  static String _encodeUserDetails(UserDetails userDetails) {
    return '${userDetails.id}|${userDetails.firstName}|${userDetails.middleName}|${userDetails.lastName}|${userDetails.email}|${userDetails.contactNo}|${userDetails.isEmailVerified}';
  }

  static UserDetails? _decodeUserDetails(String encoded) {
    try {
      final parts = encoded.split('|');
      if (parts.length >= 7) {
        return UserDetails(
          id: parts[0],
          firstName: parts[1],
          middleName: parts[2],
          lastName: parts[3],
          email: parts[4],
          contactNo: parts[5],
          isEmailVerified: parts[6] == 'true',
        );
      }
    } catch (e) {
      print('AuthService: Error decoding user details: $e');
    }
    return null;
  }

  static String _encodeMenuData(List<MenuData> menuData) {
    return menuData.length.toString();
  }

  static List<MenuData>? _decodeMenuData(String encoded) {
    try {
      final count = int.parse(encoded);
      return List.generate(count, (index) => MenuData(
        id: 'menu_$index',
        name: 'Menu $index',
        order: index,
      ));
    } catch (e) {
      print('AuthService: Error decoding menu data: $e');
    }
    return null;
  }
}