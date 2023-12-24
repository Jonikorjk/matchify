import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/player_cell.dart';
import 'package:matchify/models/player_model.dart';
import 'package:matchify/cubits/game_bloc.dart';
import 'package:flutter/material.dart';

class EventPlayerGamePicker extends StatelessWidget {
  final List<PlayerModel> _ingamePlayers;
  final GameEventType eventType;
  final void Function(PlayerModel playerModel) onPressed;

  const EventPlayerGamePicker(
    this._ingamePlayers,
    this.eventType,
    this.onPressed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Players'),
        backgroundColor: ThemeColors.subBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 34),
        color: ThemeColors.backgroundColor,
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 4,
          children: [
            for (var index = 0; index < _ingamePlayers.length; index++)
              GestureDetector(
                onTap: () {
                  onPressed(_ingamePlayers[index]);
                  Navigator.pop(context);
                },
                child: _SelectEventInitiatorCell(_ingamePlayers[index]),
              )
          ],
        ),
      ),
    );
  }
}

class _SelectEventInitiatorCell extends StatelessWidget {
  final PlayerModel _playerModel;

  const _SelectEventInitiatorCell(this._playerModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromRGBO(25, 25, 25, 1),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70, width: 50, child: _playerModel.avatar),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _playerModel.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 8),
              PlayerStatsWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                nameFontSize: 16,
                statsFontSize: 11,
                playerStats: _playerModel.stats,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
