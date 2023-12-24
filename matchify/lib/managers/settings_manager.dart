import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  static const _bannersKey = 'banners';

  void setBannersStatus(bool bannersEnabed) {
    _storage.then(
      (value) {
        value.setBool(_bannersKey, bannersEnabed);
      },
    );
  }

  Future<bool?> getBannersStatus() async {
    return await _storage.then(
      (value) {
        var bannersStatus = value.getBool(_bannersKey);

        if (bannersStatus == null) {
          setBannersStatus(true);
        }

        return bannersStatus;
      },
    );
  }
}
