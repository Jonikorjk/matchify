import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlayerData {
  final PlayerModel player;

  const AddPlayerData(this.player);
}

class AddPlayerCubit extends Cubit<AddPlayerData> {
  AddPlayerCubit(this._player) : super(AddPlayerData(_player));

  final PlayerModel _player;

  void addPlayerImage(String base64StringImage) {
    if (base64StringImage.isNotEmpty) {
      _player.imageBase64 = base64StringImage;
      emit(AddPlayerData(_player));
    }
  }

  void addPlayer() {
    appManager.playersManager.addPlayer(_player);
  }

  void updateScreen() {
    emit(AddPlayerData(_player));
  }
}
