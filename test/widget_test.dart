// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty/core/const/const.dart';
import 'package:rick_and_morty/data/data_sources/data_sources.dart';

void main() {
  test('Character', () async {
    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(Links.baseUrl),
    );
    final push = HomeRemoteDataSource(client);

    final result = await push.getCharacter([1, 67]);

    debugPrint("$result");
  });
}
