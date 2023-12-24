import 'package:matchify/managers/players_manager.dart';
import 'package:matchify/models/player_stats.dart';
import 'package:matchify/general/helpers.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v4.dart';

class PlayerModel {
  late final String id;
  late String name;
  late String imageBase64;
  late PlayerStatsModel stats;

  PlayerModel(this.id, this.imageBase64, this.name, this.stats);
  factory PlayerModel.fromStorage(List<String> playerData) {
    return PlayerModel(
      playerData[PlayerDataIndex.id],
      playerData[PlayerDataIndex.imageBase64],
      playerData[PlayerDataIndex.name],
      PlayerStatsModel.fromStorage(playerData),
    );
  }

  PlayerModel.defaultPlayer() {
    id = const UuidV4().generate().toString();
    name = "Player";
    imageBase64 = "";
    stats = PlayerStatsModel.zero();
  }

  List<String> toStorage() {
    var encodedPlayer = [id, name, imageBase64];
    encodedPlayer.addAll(stats.toStorage());
    return encodedPlayer;
  }

  Image get avatar =>
      decodeBase64ImageString(imageBase64, 50, 70, BoxFit.cover);
}
