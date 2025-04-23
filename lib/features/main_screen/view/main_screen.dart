import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character/character.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CharactersListView();
  }
}
