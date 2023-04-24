import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitter_swipe/models/enums/settings.dart';
import 'package:sitter_swipe/services/di.dart';

class AppPreferences with AppPreferencesHelperFunctions {
  void save(Settings setting, dynamic value) {
    saveValueFromType(
        settingsEnumToKey(setting), getSettingDataType(setting), value);
  }

  dynamic get(Settings setting) {
    return getValue(setting);
  }
}

class AppPreferencesHelperFunctions {
  SharedPreferences prefs = instance<SharedPreferences>();

  void saveValueFromType(String key, SettingsTypes type, dynamic value) {
    switch (type) {
      case SettingsTypes.bool:
        prefs.setBool(key, value);
        break;
      case SettingsTypes.int:
        prefs.setInt(key, value);
        break;
      case SettingsTypes.string:
        prefs.setString(key, value);
        break;
    }
  }

  dynamic getValue(Settings setting) async {
    switch (setting) {
      case Settings.useMiles:
        bool? useMiles = prefs.getBool(SettingsPrefsKeys.useMiles);
        return useMiles;
      case Settings.userIsParent:
        bool? userIsParent = prefs.getBool(SettingsPrefsKeys.userIsParent);
        return userIsParent;
    }
  }

  String settingsEnumToKey(Settings setting) {
    switch (setting) {
      case Settings.useMiles:
        return SettingsPrefsKeys.useMiles;
      case Settings.userIsParent:
        return SettingsPrefsKeys.userIsParent;
    }
  }

  SettingsTypes getSettingDataType(Settings setting) {
    switch (setting) {
      case Settings.useMiles:
        return SettingsTypes.bool;
      case Settings.userIsParent:
        return SettingsTypes.bool;
    }
  }
}

class SettingsPrefsKeys {
  static const String useMiles = "useMiles";
  static const String userIsParent = "userIsParent";
}

String? saveUserCity;
String? saveUserStateOrProvince;
// get location ONCE per session, and then save it here