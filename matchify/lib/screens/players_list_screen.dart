import 'package:matchify/cubits/players_list_cubit.dart';
import 'package:matchify/general/assets.dart';
import 'package:matchify/general/helpers.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/player_cell.dart';
import 'package:matchify/main.dart';
import 'package:matchify/screens/add_player_screen.dart';
import 'package:matchify/screens/update_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersListsScreen extends StatefulWidget {
  const PlayersListsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return PlayersListState();
  }
}

class PlayersListState extends State<PlayersListsScreen> with RouteAware {
  final _bloc = PlayersListCubit();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _bloc.loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Players list"),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        color: const Color.fromRGBO(25, 25, 25, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 35),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: ThemeColors.buttonBackgroundColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPlayerScreen(),
                      ),
                    );
                  },
                  child: Image.asset(Assets.plusImage),
                ),
              ),
            ),
            Expanded(
              child: BlocProvider<PlayersListCubit>.value(
                value: _bloc,
                child: BlocBuilder<PlayersListCubit, PlayerListPlayersData>(
                  builder: (context, state) {
                    return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 4,
                      children: [
                        for (var player in state.players)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatePlayerScreen(
                                    player: player,
                                  ),
                                ),
                              );
                            },
                            child: PlayerCellWidget(
                              playerModel: player,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
