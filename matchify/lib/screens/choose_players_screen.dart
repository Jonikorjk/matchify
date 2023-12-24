import 'package:matchify/cubits/choose_players_cubit.dart';
import 'package:matchify/general/assets.dart';
import 'package:matchify/general/helpers.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/bottom_button.dart';
import 'package:matchify/general/widget/select_players_widget.dart';
import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:matchify/screens/game_screen.dart';
import 'package:matchify/screens/players_picker_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../general/enums/team.dart';

class ChoosePlayersScreen extends StatefulWidget {
  const ChoosePlayersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChoosePlayersScreenState();
  }
}

class _ChoosePlayersScreenState extends State<ChoosePlayersScreen>
    with RouteAware {
  final ChoosePlayersCubit _bloc = ChoosePlayersCubit();

  Widget getProperWidget(Team team, List<PlayerModel> teamPlayers) {
    switch (team) {
      case Team.teamOne:
        if (teamPlayers.isEmpty) {
          return _TeamSelectorButton(
            bloc: _bloc,
            concurentTeam: Team.teamTwo,
          );
        }
        return _TeamScrollableListWidget(
          teamNumber: '1',
          teamPlayers: teamPlayers,
          bloc: _bloc,
          concurentTeam: Team.teamTwo,
        );
      case Team.teamTwo:
        if (teamPlayers.isEmpty) {
          return _TeamSelectorButton(
            bloc: _bloc,
            concurentTeam: Team.teamOne,
          );
        }
        return _TeamScrollableListWidget(
          teamNumber: '2',
          teamPlayers: teamPlayers,
          bloc: _bloc,
          concurentTeam: Team.teamOne,
        );
    }
  }

  void _showPlayersPicker(
    List<PlayerModel> avaliablePlayers,
    List<PlayerModel> hiringTeam,
  ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => PlayersPickerScreen(
          freePlayers: avaliablePlayers,
          hiringTeam: hiringTeam,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BottomButton(
        title: 'Continue',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreenWidget(
                teamOne: _bloc.teamOne,
                teamTwo: _bloc.teamTwo,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text('Choose players'),
        backgroundColor: ThemeColors.subBackgroundColor,
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocConsumer<ChoosePlayersCubit, ChoosePlayersState>(
          listener: (context, state) {
            if (state.flow == ChoosePlayersStateFlow.playersPickerTeamOne) {
              _showPlayersPicker(state.avaliablePlayers, _bloc.teamOne);
            }

            if (state.flow == ChoosePlayersStateFlow.playersPickerTeamTwo) {
              _showPlayersPicker(state.avaliablePlayers, _bloc.teamTwo);
            }
          },
          builder: (context, state) {
            var widgetTeamOne = getProperWidget(Team.teamOne, state.teamOne);
            var widgetTeamTwo = getProperWidget(Team.teamTwo, state.teamTwo);
            return Container(
              width: MediaQuery.of(context).size.width,
              color: ThemeColors.subBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgetTeamOne,
                  widgetTeamTwo,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _bloc.updateScreen();
  }
}

class _TeamSelectorButton extends StatelessWidget {
  const _TeamSelectorButton({required this.bloc, required this.concurentTeam});
  final ChoosePlayersCubit bloc;
  final Team concurentTeam;

  @override
  Widget build(BuildContext context) {
    var teamNumber = concurentTeam == Team.teamOne ? 'Team 2' : 'Team 1';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Text(
          teamNumber,
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        SelectPlayersWidget(
          width: 165,
          height: 90,
          onPressed: () => bloc.selectAvaliablePlayers(
            concurentTeam: concurentTeam,
          ),
        ),
      ],
    );
  }
}

class _TeamScrollableListWidget extends StatelessWidget {
  final List<PlayerModel> teamPlayers;
  final ChoosePlayersCubit bloc;
  final Team concurentTeam;
  final String teamNumber;

  const _TeamScrollableListWidget({
    required this.concurentTeam,
    required this.teamPlayers,
    required this.teamNumber,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Team $teamNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 3),
            IconButton(
              onPressed: () {
                bloc.selectAvaliablePlayers(concurentTeam: concurentTeam);
              },
              icon: Image.asset(Assets.editImage),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 106,
          child: ListView(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            scrollDirection: Axis.horizontal,
            children: [
              for (var player in teamPlayers)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        decodeBase64ImageString(
                          player.imageBase64,
                          70,
                          80,
                          BoxFit.cover,
                        ),
                        Text(player.name),
                      ],
                    ),
                    const SizedBox(width: 8)
                  ],
                )
            ],
          ),
        )
      ],
    );
  }
}
