import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePlayerData {
  final PlayerModel player;

  const UpdatePlayerData(this.player);
}

class UpdatePlayerCubit extends Cubit<UpdatePlayerData> {
  UpdatePlayerCubit(this._player) : super(UpdatePlayerData(_player));

  final PlayerModel _player;

  void updatePlayerImage(String base64StringImage) {
    if (base64StringImage.isNotEmpty) {
      _player.imageBase64 = base64StringImage;
      emit(UpdatePlayerData(_player));
    }
  }

  void updatePlayer() {
    appManager.playersManager.updatePlayer(_player);
  }

  void updateScreen() {
    emit(UpdatePlayerData(_player));
  }
}
