import 'package:matchify/cubits/match_history_cubit.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/general_text.dart';
import 'package:matchify/models/game_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchHistoryScreen extends StatefulWidget {
  const MatchHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchHistoryState();
  }
}

class _MatchHistoryState extends State<MatchHistoryScreen> {
  final _bloc = MatchHistoryCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GeneralText(text: 'Match history'),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: Container(
        color: ThemeColors.backgroundColor,
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: BlocProvider.value(
          value: _bloc,
          child: BlocBuilder<MatchHistoryCubit, MatchHistoryData>(
            builder: (context, state) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  for (var game in state.gamesHistory.reversed)
                    _MatchHistoryCell(game),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MatchHistoryCell extends StatelessWidget {
  final GameHistory _gameHistory;

  const _MatchHistoryCell(this._gameHistory);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 84,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.topCenter,
            child: GeneralText(
              text: _gameHistory.date,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 37,
            width: 450,
            color: ThemeColors.subBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _LeftTeamSide(),
                GeneralText(text: _gameHistory.teamOneScore),
                GeneralText(text: _gameHistory.teamTwoScore),
                _RightTeamSide()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftTeamSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8),
        Image.asset(
          'assets/images/blue_color.png',
          width: 17,
          height: 21,
        ),
        const SizedBox(width: 8),
        const GeneralText(text: 'Team'),
      ],
    );
  }
}

class _RightTeamSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GeneralText(text: 'Team'),
        const SizedBox(width: 8),
        Image.asset(
          'assets/images/red_color.png',
          width: 18,
          height: 20,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
