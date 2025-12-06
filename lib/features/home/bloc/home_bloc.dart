import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/features/auth/data/models/user_model.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';
import 'package:rash7ly/features/home/data/repo/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository _authRepo;
  final HomeRepo _homeRepo;

  List<PlaceModel>? places = [];

  HomeBloc({required AuthRepository authRepo, required HomeRepo homeRepo})
    : _authRepo = authRepo,
      _homeRepo = homeRepo,
      super(HomeInitialState()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetUserEvent>((event, emit) async {
      try {
        emit(HomeLoadingState());
        final UserModel? user = await _authRepo.getCurrentUser();

        if (user != null) {
          user.photoUrl ??= AppAssets.personProfile; // if image is null
          emit(GetUserSuccessState(user));
        } else {
          // guest user
          UserModel guestUser = UserModel(
            id: 'guest_id', //! first add guest option to auth
            name: 'Guest',
            email: 'guest@example.com',
            photoUrl: AppAssets.personProfile,
          );
          emit(GetUserGuestState(guestUser));
        }
      } catch (e) {
        //! first make {getcurrentuser} method return error not null
        emit(GetUserFailed(e.toString()));
      }
    });

    on<GetAllPlacesEvent>((event, emit) async {
      //! by ibarhim
      try {
        log('loading places');
        emit(GetAllPlacesLoadingState());
        places = await _homeRepo.getplaces();
        if (places != null) {
          log('places loaded');
          emit(GetAllPlacesSuccessState());
        } else {
          log('no places found');
          emit(const GetAllPlacesFailedState('No places found.'));
        }
      } catch (e) {
        log('failed to load places: $e');
        emit(GetAllPlacesFailedState(e.toString()));
      }
    });
  }
}
