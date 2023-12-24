import 'package:matchify/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerDataIndex {
  static const id = 0;
  static const name = 1;
  static const imageBase64 = 2;
  static const pacStat = 3;
  static const driStat = 4;
  static const shoStat = 5;
  static const defStat = 6;
  static const pasStat = 7;
  static const phyStat = 8;
}

class PlayersManager {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();
  static const playerStorageKey = 'playersKey';

  void addPlayer(PlayerModel player) {
    _storage.then((value) {
      value.setStringList(player.id, player.toStorage());
      updatePlayersId(value, player.id, false);
    });
  }

  void updatePlayer(PlayerModel player) {
    _storage.then((value) {
      value.setStringList(player.id, player.toStorage());
    });
  }

  void updatePlayersId(SharedPreferences value, String id, bool remove) {
    var playersKey = value.getStringList(playerStorageKey) ?? [];
    if (remove) {
      playersKey.remove(id);
    } else {
      playersKey.add(id);
    }
    value.setStringList(playerStorageKey, playersKey);
  }

  void deletePlayer(PlayerModel player) {
    _storage.then((value) {
      value.remove(player.id);
      updatePlayersId(value, player.id, true);
    });
  }

  Future<List<PlayerModel>?> getPlayers() async {
    return await _storage.then(
      (value) {
        var players = List<PlayerModel>.empty(growable: true);
        List<String> playersKey = value.getStringList(playerStorageKey) ?? [];

        for (var playerKey in playersKey) {
          var data = value.getStringList(playerKey);

          if (data == null) {
            return null;
          }

          players.add(
            PlayerModel.fromStorage(data),
          );
        }

        return players;
      },
    );
  }
}
