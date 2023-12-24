import 'package:matchify/models/player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general/enums/team.dart';

enum GameEventType {
  goal,
  red,
  yellow,
  initial,
}

class GameEvent {
  String playerName;
  String eventTime;
  GameEventType eventType;
  Team team;

  GameEvent(this.playerName, this.eventTime, this.eventType, this.team);
}

class GameBlocData {
  final int teamOneGoals;
  final int teamTwoGoals;

  final List<GameEvent> gameEvents;

  const GameBlocData(this.teamOneGoals, this.teamTwoGoals, this.gameEvents);
}

class GameBloc extends Cubit<GameBlocData> {
  final List<PlayerModel> teamOne;
  final List<PlayerModel> teamTwo;
  final List<GameEvent> gameEvents = [];
  int teamOneGoals = 0;
  int teamTwoGoals = 0;

  GameBloc(this.teamOne, this.teamTwo) : super(const GameBlocData(0, 0, []));

  void emitYellowCard(PlayerModel selectedPlayer) {
    var team = teamOne.contains(selectedPlayer) ? Team.teamOne : Team.teamTwo;
    gameEvents
        .add(GameEvent(selectedPlayer.name, '', GameEventType.yellow, team));

    emit(GameBlocData(teamOneGoals, teamTwoGoals, gameEvents));
  }

  void emitRedCard(PlayerModel selectedPlayer) {
    var team = teamOne.contains(selectedPlayer) ? Team.teamOne : Team.teamTwo;
    gameEvents.add(GameEvent(
      selectedPlayer.name,
      '',
      GameEventType.red,
      team,
    ));

    emit(GameBlocData(teamOneGoals, teamTwoGoals, gameEvents));
  }

  void emitGoal(PlayerModel selectedPlayer) {
    Team team;
    if (teamOne.contains(selectedPlayer)) {
      team = Team.teamOne;
      teamOneGoals++;
    } else {
      team = Team.teamTwo;
      teamTwoGoals++;
    }

    gameEvents.add(GameEvent(
      selectedPlayer.name,
      '90:00',
      GameEventType.goal,
      team,
    ));

    emit(GameBlocData(teamOneGoals, teamTwoGoals, gameEvents));
  }
}
