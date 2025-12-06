import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rash7ly/features/categories/data/repo/category_repo.dart';
import 'package:rash7ly/features/home/data/model/place_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo _categoryRepo;

  List<PlaceModel>? places = [];

  CategoryBloc({required CategoryRepo categoryRepo})
    : _categoryRepo = categoryRepo,
      super(CategoryInitialState()) {
    on<GetPlacesByCategoryEvent>((event, emit) async {
      try {
        log('loading places for category: ${event.category}');
        emit(CategoryLoadingState());
        places = await _categoryRepo.getPlacesByCategory(event.category);
        if (places != null && places!.isNotEmpty) {
          log('places loaded for category: ${event.category}');
          emit(CategorySuccessState(places!));
        } else {
          log('no places found for category: ${event.category}');
          emit(const CategoryEmptyState('No places found for this category.'));
        }
      } catch (e) {
        log('failed to load places: $e');
        emit(CategoryFailedState(e.toString()));
      }
    });
  }
}
