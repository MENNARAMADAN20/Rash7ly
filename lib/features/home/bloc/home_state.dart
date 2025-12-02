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
