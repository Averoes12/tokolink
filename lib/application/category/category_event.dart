part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategory extends CategoryEvent {
  @override
  List<Object> get props => [];
}

class GetSubCategory extends CategoryEvent {
  final Category category;

  GetSubCategory(this.category);

  @override
  List<Object> get props => [category];
}
