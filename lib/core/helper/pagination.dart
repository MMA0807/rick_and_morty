import 'package:equatable/equatable.dart';

class Pagination<T> extends Equatable {
  const Pagination({
    this.data = const [],
    this.currentPage = 41,
    this.totalPages = 41,
  });

  final List<T> data;
  final int currentPage;
  final int totalPages;

  bool get isComplete => currentPage >= totalPages;

  Pagination<T> copyWith({List<T>? data, int? currentPage, int? totalPages}) =>
      Pagination(
        data: data ?? this.data,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
      );

  @override
  List<Object?> get props => [data, currentPage, totalPages];
}
