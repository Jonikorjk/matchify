import 'package:matchify/general/enums/team.dart';
import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ChoosePlayersStateFlow {
  playersPickerTeamOne,
  playersPickerTeamTwo,
  continueFlow,
  none,
}

class ChoosePlayersState {
  final List<PlayerModel> teamOne;
  final List<PlayerModel> teamTwo;
  final List<PlayerModel> avaliablePlayers;
  ChoosePlayersStateFlow flow;

  ChoosePlayersState(
      this.teamOne, this.teamTwo, this.avaliablePlayers, this.flow);
}

class ChoosePlayersCubit extends Cubit<ChoosePlayersState> {
  ChoosePlayersCubit()
      : super(ChoosePlayersState([], [], [], ChoosePlayersStateFlow.none)) {
    _getPlayers();
  }

  late final List<PlayerModel> allPlayers;
  final List<PlayerModel> teamOne = List.empty(growable: true);
  final List<PlayerModel> teamTwo = List.empty(growable: true);

  void _getPlayers() async {
    allPlayers = await appManager.playersManager.getPlayers() ?? [];
  }

  void updateScreen() {
    emit(ChoosePlayersState(teamOne, teamTwo, [], ChoosePlayersStateFlow.none));
  }

  void selectAvaliablePlayers({
    Team concurentTeam = Team.teamOne,
  }) {
    var teamConcurent = switch (concurentTeam) {
      Team.teamOne => teamOne,
      Team.teamTwo => teamTwo,
    };

    var avaliablePlayers = List<PlayerModel>.empty(growable: true);

    for (var player in allPlayers) {
      if (teamConcurent.where((element) => element.id == player.id).isEmpty) {
        avaliablePlayers.add(player);
      }
    }

    switch (concurentTeam) {
      case Team.teamOne:
        emit(
          ChoosePlayersState(
            [],
            [],
            avaliablePlayers,
            ChoosePlayersStateFlow.playersPickerTeamTwo,
          ),
        );
      case Team.teamTwo:
        emit(
          ChoosePlayersState(
            [],
            [],
            avaliablePlayers,
            ChoosePlayersStateFlow.playersPickerTeamOne,
          ),
        );
    }
  }
}
