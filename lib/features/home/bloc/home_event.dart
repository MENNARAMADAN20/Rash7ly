part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetUserEvent extends HomeEvent {}

final class GetAllPlacesEvent extends HomeEvent {}

// Saved Recommendations Events
final class LoadSavedRecommendationsEvent extends HomeEvent {}

final class ToggleSaveRecommendationEvent extends HomeEvent {
  final PlaceModel place;

  const ToggleSaveRecommendationEvent(this.place);

  @override
  List<Object> get props => [place];
}
