import 'package:matchify/cubits/settings_cubit.dart';
import 'package:matchify/general/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsScreen> {
  final _bloc = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<SettingsCubit, bool>(
          builder: (context, state) {
            return Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(color: backgroundColor),
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    const SizedBox(height: 68),
                    SwitchWidget(
                      text: "Banners",
                      value: state,
                      onToggle: (value) {
                        _bloc.updateBannersStatus();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool) onToggle;

  const SwitchWidget({
    super.key,
    required this.text,
    required this.value,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        FlutterSwitch(
          value: value,
          inactiveColor: const Color.fromRGBO(51, 51, 51, 1),
          activeColor: Colors.white,
          activeToggleColor: Colors.black,
          width: 55,
          height: 30,
          onToggle: onToggle,
        )
      ],
    );
  }
}
