part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitialState extends CategoryState {}

final class CategoryLoadingState extends CategoryState {}

final class CategorySuccessState extends CategoryState {
  final List<PlaceModel> places;

  const CategorySuccessState(this.places);

  @override
  List<Object> get props => [places];
}

final class CategoryEmptyState extends CategoryState {
  final String message;

  const CategoryEmptyState(this.message);

  @override
  List<Object> get props => [message];
}

final class CategoryFailedState extends CategoryState {
  final String error;

  const CategoryFailedState(this.error);

  @override
  List<Object> get props => [error];
}
