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
  List<PlaceModel> savedPlaces = [];
  Set<String> savedPlaceIds = {};

  /// Get places where BestDestinations is true
  List<PlaceModel> get bestDestinations =>
      places?.where((p) => p.bestDestinations).toList() ?? [];

  /// Get places where PopularPackage is true
  List<PlaceModel> get popularPackages =>
      places?.where((p) => p.popularPackage).toList() ?? [];

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

    on<LoadSavedRecommendationsEvent>((event, emit) async {
      try {
        log('LoadSavedRecommendationsEvent: started');
        emit(SavedRecommendationsLoadingState());

        // Get saved IDs from user
        final savedIds = await _authRepo.getSavedRecommendationIds();
        log(
          'LoadSavedRecommendationsEvent: got ${savedIds.length} savedIds: $savedIds',
        );
        savedPlaceIds = savedIds.toSet();

        // Fetch places by IDs
        savedPlaces = [];
        for (final id in savedIds) {
          log('LoadSavedRecommendationsEvent: fetching place with id: $id');
          final place = await _homeRepo.getPlaceById(id);
          if (place != null) {
            savedPlaces.add(place);
            log(
              'LoadSavedRecommendationsEvent: added place ${place.title} to savedPlaces',
            );
          } else {
            log('LoadSavedRecommendationsEvent: place was NULL for id: $id');
          }
        }

        log(
          'LoadSavedRecommendationsEvent: emitting SavedRecommendationsSuccessState with ${savedPlaces.length} places',
        );
        emit(SavedRecommendationsSuccessState(savedPlaces));
      } catch (e) {
        log('failed to load saved recommendations: $e');
        emit(SavedRecommendationsFailedState(e.toString()));
      }
    });

    on<ToggleSaveRecommendationEvent>((event, emit) async {
      try {
        final placeId = event.place.id;
        if (placeId == null) return;

        await _authRepo.toggleSavedRecommendation(placeId);

        final wasSaved = savedPlaceIds.contains(placeId);
        if (wasSaved) {
          savedPlaceIds.remove(placeId);
          savedPlaces.removeWhere((p) => p.id == placeId);
        } else {
          savedPlaceIds.add(placeId);
          savedPlaces.add(event.place);
        }

        emit(ToggleSaveSuccessState(isSaved: !wasSaved, placeId: placeId));
        emit(SavedRecommendationsSuccessState(List.from(savedPlaces)));
      } catch (e) {
        log('failed to toggle saved recommendation: $e');
        emit(SavedRecommendationsFailedState(e.toString()));
      }
    });
  }

  /// Check if a place is saved (for UI)
  bool isPlaceSaved(String? placeId) {
    if (placeId == null) return false;
    return savedPlaceIds.contains(placeId);
  }
}
