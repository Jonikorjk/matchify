import 'package:matchify/general/helpers.dart';
import 'package:matchify/models/player_stats.dart';
import 'package:flutter/material.dart';

class PlayerStatsWidget extends StatelessWidget {
  final double width;
  final double height;
  final PlayerStatsModel stats;


  const PlayerStatsWidget({
    super.key,
    this.width = 191,
    this.height = 46,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            textDirection: TextDirection.ltr,
            spacing: 13,
            children: [
              Text('${stats.pac} PAC'),
              Text('${stats.dri} DRI'),
              Text('${stats.sho} SHO'),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            textDirection: TextDirection.ltr,
            spacing: 13,
            children: [
              Text('${stats.def} DEF'),
              Text('${stats.pas} PAS'),
              Text('${stats.phy} PHY'),
            ],
          ),
        ],
      ),
    );
  }
}
