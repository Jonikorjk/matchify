import 'package:matchify/cubits/game_bloc.dart';
import 'package:matchify/general/enums/team.dart';
import 'package:matchify/general/helpers.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/general_text.dart';
import 'package:matchify/general/widget/red_card_widget.dart';
import 'package:matchify/general/widget/theme_button.dart';
import 'package:matchify/general/widget/yellow_card_widget.dart';
import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:matchify/screens/event_player_game_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreenWidget extends StatefulWidget {
  const GameScreenWidget({
    super.key,
    required this.teamOne,
    required this.teamTwo,
  });

  final List<PlayerModel> teamOne;
  final List<PlayerModel> teamTwo;

  @override
  State<StatefulWidget> createState() {
    return GameScreenState();
  }
}

class GameScreenState extends State<GameScreenWidget> {
  late final GameBloc _bloc = GameBloc(widget.teamOne, widget.teamTwo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _BottomGamePanelWidget(_bloc),
      appBar: AppBar(
        backgroundColor: ThemeColors.backgroundColor,
        shadowColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: ThemeColors.backgroundColor,
        child: BlocProvider<GameBloc>.value(
          value: _bloc,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 36.0),
              const Padding(
                padding: EdgeInsets.only(left: 80, right: 80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Team 1',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 224, 255, 1),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Team 2',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _ScoreWidget(),
              const SizedBox(height: 18),
              _GameEventsTableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScoreWidgetState();
  }
}

class _ScoreWidgetState extends State<_ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameBlocData>(
      builder: (context, state) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GeneralText(
                  text: state.teamOneGoals.toString(),
                  fontSize: 60,
                ),
                const GeneralText(
                  text: '-',
                  fontSize: 60,
                ),
                GeneralText(
                  text: state.teamTwoGoals.toString(),
                  fontSize: 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GameEventsTableWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameEventsState();
}

class _GameEventsState extends State<_GameEventsTableWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameBlocData>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                width: 340,
                color: backgroundColor,
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: const GeneralText(text: 'Game events'),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: backgroundColor,
                width: 340,
                padding: const EdgeInsets.all(10),
                height: 320,
                child: ListView(
                  children: [
                    for (var event in state.gameEvents)
                      _GameEventsCell(
                        time: event.eventTime,
                        playerName: event.playerName,
                        eventType: event.eventType,
                        team: event.team,
                      )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _BottomGamePanelWidget extends StatelessWidget {
  final GameBloc _bloc;

  const _BottomGamePanelWidget(this._bloc);

  void handleGameAction(BuildContext context, GameEventType eventType) {
    StatelessWidget showedWidget = Container();

    if (eventType == GameEventType.goal) {
      showedWidget = EventPlayerGamePicker(
        _bloc.teamOne + _bloc.teamTwo,
        eventType,
        _bloc.emitGoal,
      );
    }

    if (eventType == GameEventType.red) {
      showedWidget = const RedCardWidget();
    }

    if (eventType == GameEventType.yellow) {
      showedWidget = const YellowCardWidget();
    }

    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: showedWidget is EventPlayerGamePicker,
        builder: (context) => showedWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 135,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  handleGameAction(context, GameEventType.yellow);
                },
                child: Image.asset('assets/images/yellow_card.png'),
              ),
              GestureDetector(
                onTap: () {
                  handleGameAction(context, GameEventType.goal);
                },
                child: Image.asset('assets/images/ball.png'),
              ),
              GestureDetector(
                onTap: () {
                  handleGameAction(context, GameEventType.red);
                },
                child: Image.asset('assets/images/red_card.png'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.topCenter,
            child: ThemeButton(
              width: 124,
              height: 34,
              color: Colors.red,
              buttonType: ThemeButtonType.bordered,
              fontSize: 18,
              title: 'End game',
              onPressed: () {
                appManager.gamesHistory.addGame(
                  _bloc.teamOneGoals.toString(),
                  _bloc.teamTwoGoals.toString(),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GameEventsCell extends StatelessWidget {
  final String playerName;
  final GameEventType eventType;
  final Team team;
  final String time;

  const _GameEventsCell({
    required this.playerName,
    required this.eventType,
    required this.team,
    required this.time,
  });

  Image? _getEventImage() {
    switch (eventType) {
      case GameEventType.goal:
        return Image.asset(
          'assets/images/ball.png',
          width: 16,
          height: 16,
        );

      case GameEventType.red:
        return Image.asset(
          'assets/images/red_card.png',
          width: 16,
          height: 16,
        );

      case GameEventType.yellow:
        return Image.asset(
          'assets/images/yellow_card.png',
          width: 16,
          height: 16,
        );

      case GameEventType.initial:
        return null;
    }
  }

  String _getEventText() {
    switch (eventType) {
      case GameEventType.goal:
        return 'scores a goal';

      case GameEventType.red:
        return 'recieves a red card';

      case GameEventType.yellow:
        return 'recieves a yellow card';

      case GameEventType.initial:
        return '';
    }
  }

  RichText _getRichText() {
    String eventText = _getEventText();
    Color eventColor = team == Team.teamOne
        ? const Color.fromRGBO(0, 224, 255, 1)
        : Colors.red;

    return RichText(
      maxLines: 2,
      text: TextSpan(
        text: "The",
        style: const TextStyle(color: Colors.white, fontSize: 16),
        children: [
          TextSpan(
            text: ' $playerName',
            style: TextStyle(color: eventColor, fontSize: 16),
          ),
          TextSpan(
            text: ' $eventText',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: 343,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // GeneralText(text: time),
              _getEventImage()!,
              const SizedBox(width: 5),
              Expanded(
                child: _getRichText(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
