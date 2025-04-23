import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/theme/theme.dart';

import 'core/injection/injection.dart';
import 'features/home/view/home_page.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt, env: Environment.prod);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(ThemeMode.system),

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Rick and Morty",
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            darkTheme: ThemeData.dark(),
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale('ru'),
            supportedLocales: S.delegate.supportedLocales,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
