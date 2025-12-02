import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rash7ly/core/constants/app_assets.dart';
import 'package:rash7ly/features/auth/data/models/user_model.dart';
import 'package:rash7ly/features/auth/data/repo/auth_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository _authRepo = AuthRepository();

  HomeBloc() : super(HomeInitialState()) {
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
  }
}
