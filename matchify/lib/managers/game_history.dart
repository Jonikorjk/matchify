import 'package:matchify/models/game_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/v4.dart';

enum _GameStorageKey {
  teamOneScore(value: 0),
  teamTwoScore(value: 1),
  date(value: 2);

  final int value;
  const _GameStorageKey({required this.value});
}

class GamesHistory {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();
  static const String gamesStorageKey = 'gameKey';

  void addGame(String teamOneScore, String teamTwoScore) {
    _storage.then((value) {
      var uuidV4 = const UuidV4().generate();
      value.setStringList(
        uuidV4,
        [teamOneScore, teamTwoScore, DateTime.now().toString().split('.')[0]],
      );
      updateGamesId(value, uuidV4);
    });
  }

  void updateGamesId(SharedPreferences value, String uuidV4) {
    var gamesKey = value.getStringList(gamesStorageKey) ?? [];
    gamesKey.add(uuidV4);
    value.setStringList(gamesStorageKey, gamesKey);
  }

  Future<List<GameHistory>?> getHistoryGames() async {
    return _storage.then((value) {
      var games = List<GameHistory>.empty(growable: true);
      var gamesKeys = value.getStringList(gamesStorageKey) ?? [];

      for (var key in gamesKeys) {
        var data = value.getStringList(key);

        if (data == null) {
          return null;
        }

        games.add(
          GameHistory(
            data[_GameStorageKey.teamOneScore.value],
            data[_GameStorageKey.teamTwoScore.value],
            data[_GameStorageKey.date.value],
          ),
        );
      }

      return games;
    });
  }
}
