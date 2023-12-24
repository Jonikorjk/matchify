import 'package:matchify/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<bool> {
  SettingsCubit() : super(false) {
    _getBannersStatus();
  }

  void _getBannersStatus() async {
    emit(await appManager.settingsManager.getBannersStatus() ?? true);
  }

  void updateBannersStatus() async {
    var status = await appManager.settingsManager.getBannersStatus() ?? true;
    appManager.settingsManager.setBannersStatus(!status);
    emit(!status);
  }
}
