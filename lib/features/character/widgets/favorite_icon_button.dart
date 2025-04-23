import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    this.onPressed,
  });

  final bool isFavorite;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.favorite,
        size: 32,
        color: isFavorite ? Colors.red : null,
      ),
    );
  }
}
