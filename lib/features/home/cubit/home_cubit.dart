import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void changedCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
