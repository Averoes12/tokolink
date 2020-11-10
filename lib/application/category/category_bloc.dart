import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:tokolink/infrastructure/repositories/category_repository.dart';
import 'package:tokolink/model/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());
  final _categoryRepo = GetIt.I<CategoryRepository>();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategory) {
      yield CategoryLoading();

      try {
        final payload = await _categoryRepo.getCategories();
        yield CategoryLoaded(payload);
      } catch (e) {
        yield CategoryLoaded([]);
      }
    }

    if (event is GetSubCategory) {
      yield CategoryLoading();

      try {
        final payload = await _categoryRepo.getSubCategories(event.category.idCategory);
        yield CategoryLoaded(payload);
      } catch (e) {
        yield CategoryLoaded([]);
      }
    }
  }
}
