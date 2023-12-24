import 'package:matchify/general/assets.dart';
import 'package:matchify/general/helpers.dart';
import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:matchify/models/player_stats.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class PlayerCellWidget extends StatelessWidget {
  const PlayerCellWidget({super.key, required this.playerModel});

  final PlayerModel playerModel;

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
          SizedBox(
            height: 70,
            width: 50,
            child: decodeBase64ImageString(
              playerModel.imageBase64,
              50,
              70,
              BoxFit.cover,
            ),
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
                IconButton(
                  onPressed: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: 'Confirm',
                      text: 'Are you sure delete this player?',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No',
                      onConfirmBtnTap: () {
                        appManager.playersManager.deletePlayer(playerModel);
                        Navigator.pop(context);
                      },
                    );
                  },
                  icon: Image.asset(Assets.trashImage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerStatsWidget extends StatelessWidget {
  final PlayerStatsModel playerStats;

  const PlayerStatsWidget({
    super.key,
    required this.playerStats,
    required this.crossAxisAlignment,
    required this.nameFontSize,
    required this.statsFontSize,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final double nameFontSize;
  final double statsFontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 13,
            children: [
              Text(
                "${playerStats.pac} PAC",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statsFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${playerStats.dri} DRI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statsFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${playerStats.sho} SHO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statsFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Wrap(
            spacing: 13,
            children: [
              Text(
                "${playerStats.def} DEF",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statsFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${playerStats.pas} PAS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statsFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${playerStats.phy} PHY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statsFontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
