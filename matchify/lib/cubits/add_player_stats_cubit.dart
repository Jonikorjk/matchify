import 'package:matchify/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlayerStatsData {
  final PlayerModel player;

  const AddPlayerStatsData(this.player);
}

enum StatsControllers {
  name(value: 0),
  pac(value: 1),
  dri(value: 2),
  sho(value: 3),
  def(value: 4),
  pas(value: 5),
  phy(value: 6);

  final int value;
  const StatsControllers({required this.value});
}

const maxStatValue = 99;

class AddPlayerStatsBloc extends Cubit<AddPlayerStatsData> {
  AddPlayerStatsBloc(this._player) : super(AddPlayerStatsData(_player));

  final PlayerModel _player;
  late final List<TextEditingController> controllers = [
    TextEditingController(text: _player.name),
    TextEditingController(text: _player.stats.pac),
    TextEditingController(text: _player.stats.dri),
    TextEditingController(text: _player.stats.sho),
    TextEditingController(text: _player.stats.def),
    TextEditingController(text: _player.stats.pas),
    TextEditingController(text: _player.stats.phy),
  ];

  void updateStat(StatsControllers stat, String text) {
    controllers[stat.value].text = _validated(text);
  }

  void updatePlayerName(String name) {
    controllers[StatsControllers.name.value].text = name;
  }

  void confirmStats() {
    _player.name = controllers[StatsControllers.name.value].text;
    _player.stats.pac = controllers[StatsControllers.pac.value].text;
    _player.stats.dri = controllers[StatsControllers.dri.value].text;
    _player.stats.sho = controllers[StatsControllers.sho.value].text;
    _player.stats.def = controllers[StatsControllers.def.value].text;
    _player.stats.pas = controllers[StatsControllers.pas.value].text;
    _player.stats.phy = controllers[StatsControllers.phy.value].text;
  }

  String _validated(String text) {
    if (text.isEmpty) return "0";
    var input = int.parse(text);
    return input > maxStatValue ? maxStatValue.toString() : input.toString();
  }
}
