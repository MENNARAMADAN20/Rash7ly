import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/repo/add_recommendation_repo.dart';
import 'add_rec_events.dart';
import 'add_rec_state.dart';

class AddRecBloc extends Bloc<AddRecEvent, AddRecState> {
  final AddRecommendationRepo _repo;

  AddRecBloc(this._repo) : super(const AddRecInitial()) {
    on<AddRecSubmitted>(_onSubmit);
    on<_ProgressEvent>((event, emit) {
      emit(AddRecProgress(event.progress));
    });
  }

  Future<void> _onSubmit(
    AddRecSubmitted event,
    Emitter<AddRecState> emit,
  ) async {
    emit(const AddRecLoading());
    try {
      final docRef = await _repo.addRecommendation(
        name: event.name,
        description: event.description,
        location: event.location,
        category: event.category,
        userId: event.userId,
        images: event.images,
        onUploadProgress: (progress) {
          _addProgress(_ProgressEvent(progress));
        },
      );
      emit(AddRecSuccess(docRef.id));
    } catch (e) {
      emit(AddRecFailure(e.toString()));
    }
  }

  // internal progress event
  void _addProgress(_ProgressEvent ev) => add(ev);
}

class _ProgressEvent extends AddRecEvent {
  final double progress;
  const _ProgressEvent(this.progress);
}
