part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetPlacesByCategoryEvent extends CategoryEvent {
  final String category;

  const GetPlacesByCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}
