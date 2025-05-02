import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/features/character/character.dart';
import 'package:rick_and_morty/features/favorite_screen/favorite_screen.dart';
import 'package:rick_and_morty/features/main_screen/main_screen.dart';

final _pageBucket = PageStorageBucket();

class CharactersListView extends StatefulWidget {
  const CharactersListView({super.key});

  @override
  State<CharactersListView> createState() => _CharactersListViewState();
}

class _CharactersListViewState extends State<CharactersListView> {
  final _scrollController = ScrollController();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<CharacterBloc>();

    final state = bloc.stream.firstWhere(
      (element) => element.status.isSuccess || element.status.isFailure,
    );

    bloc.add(Refreshed());
    await state;

    _scrollUp();
  }

  void _scrollUp() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        curve: Curves.easeInOut,
        duration: kTabScrollDuration,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        switch (state.status) {
          case CharacterStatus.initial:
            return RefreshIndicator(
              onRefresh: () async => await _refresh(context),
              child: const Center(child: CircularProgressIndicator()),
            );
          case CharacterStatus.failure:
            return RefreshIndicator(
              onRefresh: () async => await _refresh(context),
              child: Center(
                child: StatusError(
                  exception: state.error ?? UnknownException(),
                ),
              ),
            );
          case CharacterStatus.loading || CharacterStatus.success:
            final characters = state.characters;
            final cubit = context.read<FavoriteCubit>();

            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async => await _refresh(context),
                child: PageStorage(
                  bucket: _pageBucket,
                  child: CustomScrollView(
                    key: PageStorageKey("charactersPageKey"),
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 16)),
                      characters.isEmpty
                          ? SliverFillRemaining(child: StatusEmpty())
                          : SliverPadding(
                            padding: kTabLabelPadding,
                            sliver: SliverList.builder(
                              itemCount:
                                  state.hasReachedMax
                                      ? characters.length
                                      : characters.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                return index >= characters.length
                                    ? BottomLoader()
                                    : CharacterCard(
                                      character: characters[index],
                                      onItemRemove:
                                          () => cubit.removeFromFavorite(
                                            characters[index],
                                          ),
                                    );
                              },
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: AnimatedCrossFade(
                duration: kThemeChangeDuration,
                firstChild: FloatingActionButton(
                  onPressed: _scrollUp,
                  mini: true,
                  child: Icon(Icons.navigation),
                ),
                secondChild: SizedBox.shrink(),
                crossFadeState:
                    _isVisible
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
              ),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    _showScrollUpBtn();

    if (_isBottom) {
      context.read<CharacterBloc>().add(LoadMore());
    }
  }

  void _showScrollUpBtn() {
    final userScrollDirection = _scrollController.position.userScrollDirection;

    if (_scrollController.offset < 700) {
      if (_isVisible == true) setState(() => _isVisible = false);
      return;
    }

    if (userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible == true) setState(() => _isVisible = false);
    } else {
      if (userScrollDirection == ScrollDirection.forward) {
        if (_isVisible == false) {
          setState(() => _isVisible = true);
        }
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
