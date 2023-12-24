import 'package:matchify/cubits/add_player_stats_cubit.dart';
import 'package:matchify/general/assets.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/general_text.dart';
import 'package:matchify/general/widget/general_textfield.dart';
import 'package:matchify/models/player_model.dart';
import 'package:flutter/material.dart';

class AddPlayerStatsScreen extends StatefulWidget {
  const AddPlayerStatsScreen({super.key, required this.player});

  final PlayerModel player;

  @override
  State<StatefulWidget> createState() {
    return _AddPlayerStatsScreenState();
  }
}

class _AddPlayerStatsScreenState extends State<AddPlayerStatsScreen> {
  late AddPlayerStatsBloc _bloc;

  @override
  void initState() {
    _bloc = AddPlayerStatsBloc(widget.player);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add player`s stats'),
        backgroundColor: ThemeColors.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              _bloc.confirmStats();
              Navigator.pop(context);
            },
            icon: Image.asset(Assets.doneImage),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: ThemeColors.backgroundColor,
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.4,
            children: [
              _AddPlayerStatsScreenTextField(
                title: 'Player name',
                labelText: 'Input name',
                controller: _bloc.controllers[StatsControllers.name.value],
                inputType: TextInputType.text,
                onChanged: (text) => _bloc.updatePlayerName(text),
              ),
              _AddPlayerStatsScreenTextField(
                title: 'PAC statistic',
                labelText: 'Input PAC',
                controller: _bloc.controllers[StatsControllers.pac.value],
                onChanged: (text) =>
                    _bloc.updateStat(StatsControllers.pac, text),
              ),
              _AddPlayerStatsScreenTextField(
                title: 'DRI statistic',
                labelText: 'Input DRI',
                controller: _bloc.controllers[StatsControllers.dri.value],
                onChanged: (text) =>
                    _bloc.updateStat(StatsControllers.dri, text),
              ),
              _AddPlayerStatsScreenTextField(
                title: 'SHO statistic',
                labelText: 'Input SHO',
                controller: _bloc.controllers[StatsControllers.sho.value],
                onChanged: (text) =>
                    _bloc.updateStat(StatsControllers.sho, text),
              ),
              _AddPlayerStatsScreenTextField(
                title: 'DEF statistic',
                labelText: 'Input DEF',
                controller: _bloc.controllers[StatsControllers.def.value],
                onChanged: (text) =>
                    _bloc.updateStat(StatsControllers.def, text),
              ),
              _AddPlayerStatsScreenTextField(
                title: 'PAS statistic',
                labelText: 'Input PAS',
                controller: _bloc.controllers[StatsControllers.pas.value],
                onChanged: (text) =>
                    _bloc.updateStat(StatsControllers.pas, text),
              ),
              _AddPlayerStatsScreenTextField(
                title: 'PHY statistic',
                labelText: 'Input PHY',
                controller: _bloc.controllers[StatsControllers.phy.value],
                onChanged: (text) =>
                    _bloc.updateStat(StatsControllers.phy, text),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPlayerStatsScreenTextField extends StatelessWidget {
  final String title;
  final String labelText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? inputType;

  const _AddPlayerStatsScreenTextField({
    required this.title,
    required this.labelText,
    this.onChanged,
    this.controller,
    this.inputType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralText(text: title),
          const SizedBox(
            height: 16,
          ),
          GeneralTextField(
            textInputType: inputType,
            onChanged: onChanged,
            controller: controller,
            labelText: labelText,
          ),
        ],
      ),
    );
  }
}
