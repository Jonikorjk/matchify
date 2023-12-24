import 'package:matchify/managers/players_manager.dart';

class PlayerStatsModel {
  String pac;
  String sho;
  String dri;
  String def;
  String pas;
  String phy;

  factory PlayerStatsModel.fromStorage(List<String> playerData) {
    return PlayerStatsModel(
      playerData[PlayerDataIndex.pacStat],
      playerData[PlayerDataIndex.driStat],
      playerData[PlayerDataIndex.shoStat],
      playerData[PlayerDataIndex.defStat],
      playerData[PlayerDataIndex.pasStat],
      playerData[PlayerDataIndex.phyStat],
    );
  }
  PlayerStatsModel(this.pac, this.sho, this.dri, this.def, this.pas, this.phy);
  PlayerStatsModel.zero({
    this.pac = "0",
    this.sho = "0",
    this.dri = "0",
    this.def = "0",
    this.pas = "0",
    this.phy = "0",
  });

  List<String> toStorage() {
    return [
      pac.toString(),
      dri.toString(),
      sho.toString(),
      def.toString(),
      pas.toString(),
      phy.toString(),
    ];
  }
}
