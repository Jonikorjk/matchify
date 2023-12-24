import 'package:matchify/cubits/players_picker_cubit.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/select_player_cell.dart';
import 'package:matchify/general/widget/theme_button.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersPickerScreen extends StatefulWidget {
  final List<PlayerModel> freePlayers;
  final List<PlayerModel> hiringTeam;

  const PlayersPickerScreen({
    super.key,
    required this.freePlayers,
    required this.hiringTeam,
  });

  @override
  State<StatefulWidget> createState() {
    return PlayersPickerScreenState();
  }
}

class PlayersPickerScreenState extends State<PlayersPickerScreen> {
  late final PlayersPickerCubit _cubit;

  @override
  void initState() {
    _cubit = PlayersPickerCubit(widget.freePlayers, widget.hiringTeam);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _PlayersPickerFloatingButton(widget.hiringTeam),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text(
          'Select Players',
        ),
        backgroundColor: ThemeColors.subBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 34),
        color: ThemeColors.backgroundColor,
        child: BlocProvider.value(
          value: _cubit,
          child: BlocBuilder<PlayersPickerCubit, PlayersPickerData>(
            builder: (context, state) {
              return GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 4,
                children: [
                  for (var player in state.players)
                    GestureDetector(
                      onTap: () => _cubit.selectPlayer(player),
                      child: SelectPlayerCellWidget(
                        avatar: player.image,
                        playerModel: player.player,
                        isSelected: player.isSelected,
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PlayersPickerFloatingButton extends StatelessWidget {
  final List<PlayerModel> hiringTeam;

  const _PlayersPickerFloatingButton(this.hiringTeam);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: ThemeColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 30,
              children: [
                ThemeButton(
                  width: 124,
                  height: 34,
                  buttonType: ThemeButtonType.bordered,
                  fontSize: 18,
                  title: 'Reset',
                  onPressed: () {
                    hiringTeam.clear();
                    Navigator.pop(context);
                  },
                ),
                ThemeButton(
                  width: 124,
                  height: 34,
                  buttonType: ThemeButtonType.filled,
                  fontSize: 18,
                  title: 'Continue',
                  onPressed: () => Navigator.pop(context),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
