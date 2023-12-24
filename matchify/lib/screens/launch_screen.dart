import 'package:matchify/general/helpers.dart';
import 'package:matchify/main.dart';
import 'package:matchify/managers/banners_manager.dart';
import 'package:matchify/screens/choose_players_screen.dart';
import 'package:matchify/screens/match_history_screen.dart';
import 'package:matchify/screens/players_list_screen.dart';
import 'package:matchify/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class _MainScreenButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const _MainScreenButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Inter",
                      color: Colors.white,
                    ),
                    backgroundColor: const Color.fromRGBO(100, 130, 188, 1),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Inter",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    appManager.bannersManager = BannersManager(context);

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 200, 40, 0),
            child: Column(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Scoreboard",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                _MainScreenButton(
                  text: 'New match',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChoosePlayersScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainScreenButton(
                  text: 'Match history',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MatchHistoryScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainScreenButton(
                  text: "Players list",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayersListsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _MainScreenButton(
                  text: "Settings",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
