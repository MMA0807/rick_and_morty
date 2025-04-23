import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/helper/prefix_to_upper_case.dart';
import 'package:rick_and_morty/core/types/types.dart';
import 'package:rick_and_morty/core/util/util.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

class VitalStatusWithSpeciesRow extends StatelessWidget {
  const VitalStatusWithSpeciesRow({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textTheme(context).bodyLarge ?? TextStyle(),
      child: Row(
        spacing: 8,
        children: [
          if (character.vitalStatus != null)
            ...switch (character.vitalStatus!) {
              VitalStatus.alive => [
                Icon(Icons.circle, size: 16, color: Colors.lightGreenAccent),
                Text(
                  "${prefixToUpperCase(character.vitalStatus?.name)} "
                  "- ${character.species}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
              VitalStatus.dead => [
                Icon(Icons.circle, size: 16, color: Colors.redAccent),
                Text(
                  "${prefixToUpperCase(character.vitalStatus?.name)} "
                  "- ${character.species}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
              VitalStatus.unknown => [
                Icon(Icons.circle_outlined, size: 12, color: Colors.grey),
                Text(
                  "${character.vitalStatus?.name} "
                  "- ${character.species}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            },
        ],
      ),
    );
  }
}
