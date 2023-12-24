import 'package:matchify/models/player_model.dart';
import 'package:flutter/widgets.dart';

class PlayerPickerModel {
  final PlayerModel player;
  final Image image;
  bool isSelected;

  PlayerPickerModel(this.player, this.image, this.isSelected);
}
