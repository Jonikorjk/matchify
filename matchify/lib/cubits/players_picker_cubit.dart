import 'package:matchify/models/player_model.dart';
import 'package:matchify/models/player_picker_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersPickerData {
  final List<PlayerPickerModel> players;

  const PlayersPickerData(this.players);
}

class PlayersPickerCubit extends Cubit<PlayersPickerData> {
  final List<PlayerModel> _hiringTeam;
  final _avaliablePlayers = List<PlayerPickerModel>.empty(growable: true);

  PlayersPickerCubit(List<PlayerModel> freePlayers, this._hiringTeam)
      : super(const PlayersPickerData([])) {
    loadFreePlayers(freePlayers);
  }

  void loadFreePlayers(List<PlayerModel> freePlayers) {
    for (var freePlayer in freePlayers) {
      _avaliablePlayers.add(
        PlayerPickerModel(
          freePlayer,
          freePlayer.avatar,
          _hiringTeam
              .where((element) => element.id == freePlayer.id)
              .isNotEmpty,
        ),
      );
    }

    emit(PlayersPickerData(_avaliablePlayers));
  }

  void selectPlayer(PlayerPickerModel playerModel) {
    var selectedPlayer = _avaliablePlayers
        .firstWhere((element) => element.player.id == playerModel.player.id);

    selectedPlayer.isSelected = !selectedPlayer.isSelected;

    if (selectedPlayer.isSelected) {
      _hiringTeam.add(selectedPlayer.player);
    } else {
      _hiringTeam.removeWhere(
        (element) => element.id == selectedPlayer.player.id,
      );
    }

    emit(PlayersPickerData(_avaliablePlayers));
  }
}
