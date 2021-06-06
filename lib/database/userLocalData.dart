import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {
  static SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static signout() => _preferences.clear();

  static const _uidKey = 'UIDKEY';
  static const _emailKey = 'EMAILKEY';
  static const _displayNameKey = 'DISPLAYNAMEKEY';
  static const _phoneNumberKey = 'PhoneNumber';
  static const _imageUrlKey = 'IMAGEURLKEY';
  static const _interest = 'USERINTEREST';

  //s
  // Setters
  //
  static Future setUserUID(String uid) async =>
      await _preferences.setString(_uidKey, uid ?? '');

  static Future setUserEmail(String email) async =>
      await _preferences.setString(_emailKey, email ?? '');

  static Future setUserDisplayName(String name) async =>
      await _preferences.setString(_displayNameKey, name ?? '');

  static Future setUserPhoneNumber(String number) async =>
      await _preferences.setString(_phoneNumberKey, number ?? '');

  static Future setUserImageUrl(String url) async =>
      await _preferences.setString(_imageUrlKey, url ?? '');

  static Future setUserInterest(List<String> interest) async =>
      await _preferences.setStringList(_interest, interest ?? []);

  // static Future setPlaceIDInLocalData(String id) async =>
  //     await _preferences.setString(_placeID, id ?? '');

  //
  // Getters
  //
  static String getUserUID() => _preferences.getString(_uidKey) ?? '';
  static String getUserEmail() => _preferences.getString(_emailKey) ?? '';
  static String getUserDisplayName() =>
      _preferences.getString(_displayNameKey) ?? '';
  static String getUserPhoneNumber() =>
      _preferences.getString(_phoneNumberKey) ?? '';
  static String getUserImageUrl() => _preferences.getString(_imageUrlKey) ?? '';
  static List<String> getUserInterest() =>
      _preferences.getStringList(_interest) ?? [];
  // static String getPlaceIDForLocalData() =>
  //     _preferences.getString(_placeID) ?? '';
}
