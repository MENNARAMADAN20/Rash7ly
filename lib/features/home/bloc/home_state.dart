part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {}

// get user states
final class GetUserLoadingState extends HomeState {}

final class GetUserSuccessState extends HomeState {
  final UserModel? userModel;

  const GetUserSuccessState(this.userModel);
}

final class GetUserGuestState extends HomeState {
  final UserModel userModel;

  const GetUserGuestState(this.userModel);
}

final class GetUserFailed extends HomeState {
  final String error;

  const GetUserFailed(this.error);

  @override
  List<Object> get props => [error];
}

// places states
final class GetAllPlacesLoadingState extends HomeState {}

final class GetAllPlacesSuccessState extends HomeState {}

final class GetAllPlacesFailedState extends HomeState {
  final String error;

  const GetAllPlacesFailedState(this.error);

  @override
  List<Object> get props => [error];
}

// Saved Recommendations States
final class SavedRecommendationsLoadingState extends HomeState {}

final class SavedRecommendationsSuccessState extends HomeState {
  final List<PlaceModel> savedPlaces;

  const SavedRecommendationsSuccessState(this.savedPlaces);

  @override
  List<Object> get props => [savedPlaces];
}

final class SavedRecommendationsFailedState extends HomeState {
  final String error;

  const SavedRecommendationsFailedState(this.error);

  @override
  List<Object> get props => [error];
}

final class ToggleSaveSuccessState extends HomeState {
  final bool isSaved;
  final String placeId;

  const ToggleSaveSuccessState({required this.isSaved, required this.placeId});

  @override
  List<Object> get props => [isSaved, placeId];
}
