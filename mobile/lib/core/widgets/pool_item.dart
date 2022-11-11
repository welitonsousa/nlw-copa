import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/models/pool_model.dart';
import 'package:mobile/models/user_model.dart';

class PoolItem extends StatelessWidget {
  final PoolModel pool;
  const PoolItem({super.key, required this.pool});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: AppTheme.colors.yellow500,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppTheme.colors.gray800,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pool.title,
                      maxLines: 1,
                      style: context.textTheme.headline6,
                    ),
                    Text("Criado por ${pool.owner?.name}", maxLines: 1),
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: context.width / 2,
                  child: AvataresItem(
                    participants: pool.participants,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AvataresItem extends StatelessWidget {
  final List<UserModel> participants;
  const AvataresItem({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        ...List.generate(
          participants.length > 4 ? 4 : participants.length,
          (index) {
            return Positioned(
              right: (index + 1) * 28,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppTheme.colors.gray600,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 3.5,
                      color: AppTheme.colors.gray800,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (participants[index].avatar.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          participants[index].avatar,
                        ),
                      ),
                    if (participants[index].avatar.isEmpty)
                      const Icon(Icons.person)
                  ],
                ),
              ),
            );
          },
        ).reversed,
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: AppTheme.colors.gray600,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 3.5, color: AppTheme.colors.gray800),
          ),
          child: Center(child: Text("+${participants.length}")),
        )
      ],
    );
  }
}
