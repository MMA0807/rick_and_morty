import 'package:flutter/material.dart';
import 'package:rick_and_morty/generated/l10n.dart';

class StatusEmpty extends StatelessWidget {
  const StatusEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).noData),
    );
  }
}