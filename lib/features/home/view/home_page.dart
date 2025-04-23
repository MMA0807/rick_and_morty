import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/injection/injection.dart';
import 'package:rick_and_morty/features/character/character.dart';
import 'package:rick_and_morty/features/favorite_screen/favorite_screen.dart';
import 'package:rick_and_morty/features/home/cubit/home_cubit.dart';
import 'package:rick_and_morty/features/main_screen/main_screen.dart';
import 'package:rick_and_morty/generated/l10n.dart';
import 'package:rick_and_morty/theme/cubit/theme_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageViewController = PageController();

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final themeState = context.watch<ThemeCubit>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>()),
        BlocProvider<CharacterBloc>(
          create: (context) => getIt<CharacterBloc>()..add(LoadMore()),
        ),
        BlocProvider<FavoriteCubit>(
          create: (context) => getIt<FavoriteCubit>()..init(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          final isLight = themeState.useLightMode(context);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(S.of(context).appTitle),
              actions: [
                IconButton(
                  onPressed: () => themeCubit.toggleTheme(isLight),
                  icon: Icon(isLight ? Icons.dark_mode : Icons.light_mode),
                ),
              ],
            ),
            body: PageView(
              controller: _pageViewController,
              children: [MainScreen(), FavoriteScreen()],
              onPageChanged: (index) => cubit.changedCurrentIndex(index),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap:
                  (index) => _pageViewController.animateToPage(
                    index,
                    duration: kTabScrollDuration,
                    curve: Curves.easeInOut,
                  ),
              selectedFontSize: 0,
              unselectedFontSize: 0,
              iconSize: 32,
              items: [
                BottomNavigationBarItem(
                  label: "",
                  activeIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                ),
                BottomNavigationBarItem(
                  label: "",
                  activeIcon: Icon(Icons.favorite),
                  icon: Icon(Icons.favorite_outline),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
