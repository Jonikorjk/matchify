import 'package:matchify/general/assets.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/player_cell.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter/material.dart';

class SelectPlayerCellWidget extends StatefulWidget {
  const SelectPlayerCellWidget({
    super.key,
    required this.playerModel,
    required this.avatar,
    required this.isSelected,
  });

  final bool isSelected;
  final PlayerModel playerModel;
  final Image avatar;

  @override
  State<StatefulWidget> createState() {
    return _SelectPlayerCellState();
  }
}

class _SelectPlayerCellState extends State<SelectPlayerCellWidget> {
  @override
  Widget build(BuildContext context) {
    return _VariousSelectPlayerCellWidget(
      widget.isSelected,
      widget.playerModel,
      widget.avatar,
    );
  }
}

class _VariousSelectPlayerCellWidget extends StatelessWidget {
  final bool isSelected;
  final PlayerModel playerModel;
  final Image avatar;

  const _VariousSelectPlayerCellWidget(
    this.isSelected,
    this.playerModel,
    this.avatar,
  );

  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromRGBO(25, 25, 25, 1),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 69, width: 51, child: avatar),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  playerModel.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(
                  height: 8,
                ),
                PlayerStatsWidget(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  nameFontSize: 16,
                  statsFontSize: 11,
                  playerStats: playerModel.stats,
                ),
              ],
            ),
            Expanded(
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 32,
                    height: 32,
                    child: IconButton(
                      onPressed: null,
                      icon: Image.asset(Assets.plusImage),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: ThemeColors.subBackgroundColor,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 69,
            width: 51,
            child: avatar,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                playerModel.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(
                height: 8,
              ),
              PlayerStatsWidget(
                crossAxisAlignment: CrossAxisAlignment.start,
                nameFontSize: 16,
                statsFontSize: 11,
                playerStats: playerModel.stats,
              ),
            ],
          ),
          Expanded(
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: 32,
                  height: 32,
                  child: IconButton(
                    onPressed: null,
                    icon: Image.asset(Assets.minusImage),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
