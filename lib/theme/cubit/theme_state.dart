part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeMode});

  final ThemeMode themeMode;

  ThemeState copyWith({ThemeMode? themeMode}) =>
      ThemeState(themeMode: themeMode ?? this.themeMode);

  bool useLightMode(BuildContext context) => switch (themeMode) {
    ThemeMode.system =>
      View.of(context).platformDispatcher.platformBrightness ==
          Brightness.light,
    ThemeMode.light => true,
    ThemeMode.dark => false,
  };

  @override
  List<Object?> get props => [themeMode];
}
