import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerListPlayersData {
  final List<PlayerModel> players;

  const PlayerListPlayersData(this.players);
}

class PlayersListCubit extends Cubit<PlayerListPlayersData> {
  late List<PlayerModel> players;

  PlayersListCubit() : super(const PlayerListPlayersData([])) {
    loadPlayers();
  }

  void loadPlayers() async {
    players = await appManager.playersManager.getPlayers() ?? [];
    emit(PlayerListPlayersData(players));
  }
}
