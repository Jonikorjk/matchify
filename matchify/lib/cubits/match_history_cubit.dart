import 'package:matchify/main.dart';
import 'package:matchify/models/game_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchHistoryData {
  final List<GameHistory> gamesHistory;
  const MatchHistoryData(this.gamesHistory);
}

class MatchHistoryCubit extends Cubit<MatchHistoryData> {
  MatchHistoryCubit() : super(const MatchHistoryData([])) {
    loadGames();
  }

  void loadGames() async {
    var gamesHistory = await appManager.gamesHistory.getHistoryGames() ?? [];
    emit(MatchHistoryData(gamesHistory));
  }
}
