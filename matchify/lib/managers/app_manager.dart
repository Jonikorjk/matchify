import 'package:matchify/managers/banners_manager.dart';
import 'package:matchify/managers/game_history.dart';
import 'package:matchify/managers/players_manager.dart';
import 'package:matchify/managers/settings_manager.dart';

class AppManager {
  var playersManager = PlayersManager();
  var gamesHistory = GamesHistory();
  var settingsManager = SettingsManager();
  late BannersManager bannersManager;
}
