import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/util/util.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/features/favorite_screen/favorite_screen.dart';
import 'package:rick_and_morty/features/character/character.dart';
import 'package:rick_and_morty/generated/l10n.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
    this.onItemRemove,
    this.animation,
  });

  final Character character;
  final void Function()? onItemRemove;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) =>
      animation == null
          ? _buildCard(context)
          : SizeTransition(
            key: ValueKey(character.image),
            sizeFactor: animation!,
            child: _buildCard(context),
          );

  Widget _buildCard(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();
    final isFavorite = context.select(
      (FavoriteCubit cubit) => cubit.state.isFavorite(character),
    );

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child:
                character.image.isNotEmpty
                    ? CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.fill,
                      errorWidget: (context, e, _) => Icon(Icons.error_outline),
                    )
                    : SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    character.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextTheme.of(context).headlineMedium,
                  ),
                ),
                FavoriteIconButton(
                  isFavorite: isFavorite,
                  onPressed:
                      () =>
                          isFavorite
                              ? onItemRemove?.call()
                              : cubit.addToFavorite(character),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: VitalStatusWithSpeciesRow(character: character),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text.rich(
              TextSpan(
                text: "${S.of(context).sex}: ",
                children: [
                  TextSpan(
                    text: S.of(context).gender(character.gender?.name ?? ''),
                    style: textTheme(context).bodyLarge,
                  ),
                ],
              ),
              style: textTheme(
                context,
              ).bodyLarge?.copyWith(color: theme(context).disabledColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
