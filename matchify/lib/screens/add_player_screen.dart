import 'package:matchify/cubits/add_player_cubit.dart';
import 'package:matchify/general/assets.dart';
import 'package:matchify/general/mixins/pick_image_mixin.dart';
import 'package:matchify/general/widget/add_player_widget.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:matchify/general/widget/bottom_button.dart';
import 'package:matchify/general/widget/player_cell.dart';
import 'package:matchify/main.dart';
import 'package:matchify/models/player_model.dart';
import 'package:matchify/screens/add_player_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlayerScreen extends StatefulWidget {
  AddPlayerScreen({super.key});

  final _newPlayer = PlayerModel.defaultPlayer();

  @override
  State<StatefulWidget> createState() {
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends State<AddPlayerScreen>
    with PickImage, RouteAware {
  late final AddPlayerCubit _bloc;

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
    _bloc.updateScreen();
  }

  @override
  void initState() {
    _bloc = AddPlayerCubit(widget._newPlayer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BottomButton(
        title: 'Add player',
        onPressed: () {
          _bloc.addPlayer();
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text('Players list'),
        backgroundColor: ThemeColors.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPlayerStatsScreen(
                    player: widget._newPlayer,
                  ),
                ),
              );
            },
            icon: Image.asset(Assets.editImage),
          ),
        ],
      ),
      body: Container(
        color: ThemeColors.backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            BlocProvider.value(
              value: _bloc,
              child: BlocBuilder<AddPlayerCubit, AddPlayerData>(
                builder: (context, state) {
                  return AddPlayerWidget(
                    width: 170,
                    height: 260,
                    base64StringImage: state.player.imageBase64,
                    onPressed: () async {
                      _bloc.addPlayerImage(await pickImageOneTime());
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget._newPlayer.name,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.white,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 18),
            PlayerStatsWidget(
              crossAxisAlignment: CrossAxisAlignment.center,
              nameFontSize: 20,
              statsFontSize: 16,
              playerStats: widget._newPlayer.stats,
            ),
          ],
        ),
      ),
    );
  }
}
