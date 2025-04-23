import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/error/exceptions.dart';
import 'package:rick_and_morty/generated/l10n.dart';

class StatusError extends StatelessWidget {
  const StatusError({
    super.key,
    required this.exception,
  });

  final Exception exception;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_getMessageFromException(context)),
    );
  }

  String _getMessageFromException(BuildContext context) {
    if (exception is ServerException) {
      return S.of(context).sorryServerErrorOccured;
    } else if (exception is CacheException) {
      return S.of(context).noInternetConnection;
    } else {
      return S.of(context).someUnexpectedErrorOccurred;
    }
  }
}
