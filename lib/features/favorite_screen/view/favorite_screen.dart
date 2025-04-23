import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/types/types.dart';
import 'package:rick_and_morty/core/util/shortcuts.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/features/character/character.dart';
import 'package:rick_and_morty/features/favorite_screen/favorite_screen.dart';
import 'package:rick_and_morty/generated/l10n.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _listKey = GlobalKey<SliverAnimatedListState>();
  late final FavoriteCubit _cubit;

  // bool _isOpen = false;

  @override
  void initState() {
    _cubit = context.read<FavoriteCubit>();
    super.initState();
  }

  void sortList(List<Character> items) {
    _cubit.removeAllFromFilteredFavorite();
    _removeAllItems();
    _addAllItems(items);
  }

  void _removeAllItems() {
    _listKey.currentState?.removeAllItems(
      (context, animation) => CharacterCard(
        character: Character(
          id: "id",
          name: "name",
          vitalStatus: VitalStatus.unknown,
          gender: Gender.unknown,
          type: "type",
          species: "species",
          image: "",
        ),
        animation: animation,
      ),
    );
  }

  void _addAllItems(List<Character> favList) {
    int length = favList.length;
    _listKey.currentState?.insertAllItems(0, length);
    favList.map((e) => _cubit.addToFilteredFavorite(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final characters = context.select(
      (FavoriteCubit cubit) => cubit.state.favorites,
    );
    final isOpen = context.select(
      (FavoriteCubit cubit) => cubit.state.showFilterBox,
    );

    return BlocListener<FavoriteCubit, FavoriteState>(
      listenWhen: (p, c) => p.selectedItems != c.selectedItems,
      listener: (context, state) {
        if (state.selectedItems.any((e) => e == true)) {
          sortList(state.filteredList);
        } else if (state.selectedItems.every((e) => e == false)) {
          _removeAllItems();
          _addAllItems(state.favorites);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverFloatingHeader(
            child: ColoredBox(
              color: theme(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedCrossFade(
                    firstChild: CharacterFilterDetailsView(),
                    secondChild: SizedBox.shrink(),
                    crossFadeState:
                        isOpen
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: kTabScrollDuration,
                  ),
                  IconButton(
                    onPressed: _cubit.toggleOpenFilterBox,
                    isSelected: isOpen,
                    selectedIcon: Icon(Icons.arrow_drop_up),
                    icon: Icon(Icons.arrow_drop_down_circle),
                  ),
                ],
              ),
            ),
          ),
          characters.isEmpty
              ? SliverFillRemaining(
                child: Center(child: Text(S.of(context).noData)),
              )
              : SliverPadding(
                padding: kTabLabelPadding,
                sliver: SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: characters.length,
                  itemBuilder: (BuildContext context, int index, animation) {
                    final character = characters[index];

                    return CharacterCard(
                      character: character,
                      animation: animation,
                      onItemRemove: () => onItemRemove(character, index),
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }

  void onItemRemove(Character item, int index) {
    _cubit.removeFromFavorite(item);
    _listKey.currentState?.removeItem(
      index,
      duration: kTabScrollDuration,
      (context, animation) =>
          CharacterCard(character: item, animation: animation),
    );
  }
}

class CharacterFilterDetailsView extends StatelessWidget {
  const CharacterFilterDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();
    final selected = context.select(
      (FavoriteCubit cubit) => cubit.state.selectedItems,
    );

    return Wrap(
      runAlignment: WrapAlignment.spaceBetween,
      spacing: 16,
      children: [
        SizedBox(height: 16),
        ...VitalStatus.values.map(
          (e) => FilterChip(
            label: Text(
              e.name,
              style: TextStyle(
                color:
                    e.isAlive
                        ? Colors.green
                        : e.isDead
                        ? Colors.redAccent
                        : Colors.grey,
              ),
            ),
            selected: selected[e.index],
            onSelected:
                (isSelected) => cubit.selectVitalStatus(e.index, isSelected),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
