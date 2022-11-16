import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/widgets/app_banner.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_input.dart';
import 'package:mobile/models/guesses_model.dart';

class GameItem extends StatefulWidget {
  final GameModel game;
  final Future<void> Function(int, int) confirm;
  const GameItem({super.key, required this.game, required this.confirm});

  @override
  State<GameItem> createState() => _GameItemState();
}

class _GameItemState extends State<GameItem> {
  final firstTeam = TextEditingController();
  final secondTeam = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    firstTeam.dispose();
    secondTeam.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.game.guess != null) {
      firstTeam.text = widget.game.guess!.firstTeamPoints.toString();
      secondTeam.text = widget.game.guess!.secondTeamPoints.toString();
    }
    super.initState();
  }

  Future<void> save() async {
    if (firstTeam.text.isNotEmpty && secondTeam.text.isNotEmpty) {
      setState(() => loading = true);
      await widget.confirm.call(
        int.parse(firstTeam.text),
        int.parse(secondTeam.text),
      );
      setState(() => loading = false);
    } else {
      AppBanner.error(subtitle: 'Chute um resultado para os dois times');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: AppTheme.colors.gray800,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                Text(
                    "${widget.game.firstTeamName} X ${widget.game.secondTeamName}"),
                Text(widget.game.dateFormatted),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 50,
                        height: 40,
                        child: AppInput(
                          textAlign: TextAlign.center,
                          controller: firstTeam,
                          textInputType: TextInputType.number,
                          enable: widget.game.guess == null,
                          formatters: [
                            Mask.generic(masks: ['##'])
                          ],
                        )),
                    CountryFlags.flag(
                      widget.game.firstTeamCode,
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(width: 40),
                    const Icon(Icons.close),
                    const SizedBox(width: 40),
                    CountryFlags.flag(
                      widget.game.secondTeamCode,
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                        width: 50,
                        height: 40,
                        child: AppInput(
                          textAlign: TextAlign.center,
                          controller: secondTeam,
                          enable: widget.game.guess == null,
                          textInputType: TextInputType.number,
                          formatters: [
                            Mask.generic(masks: ['##'])
                          ],
                        )),
                  ],
                )
              ]),
            ),
            if (widget.game.guess == null)
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: AppButton(
                  backgroundColor: AppTheme.colors.green500,
                  color: AppTheme.colors.white,
                  title: "Confirmar palpite",
                  loading: loading,
                  onTap: save,
                ),
              ),
            Container(
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.colors.yellow500,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
