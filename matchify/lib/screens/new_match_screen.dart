import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/bottom_button.dart';
import 'package:matchify/general/widget/general_textfield.dart';
import 'package:matchify/screens/choose_players_screen.dart';
import 'package:flutter/material.dart';

class NewMatchScreen extends StatelessWidget {
  const NewMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: BottomButton(
        title: 'Continue',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChoosePlayersScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text('Create teams'),
        shadowColor: Colors.black.withOpacity(0),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: Container(
        color: ThemeColors.backgroundColor,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 94),
            _TextFieldWidget(teamNumber: '1'),
            SizedBox(height: 54),
            _TextFieldWidget(teamNumber: '2'),
          ],
        ),
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final String teamNumber;

  const _TextFieldWidget({required this.teamNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.backgroundColor,
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team $teamNumber name',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: 15.0),
          GeneralTextField(
            labelText: "Input team $teamNumber name",
          )
        ],
      ),
    );
  }
}
