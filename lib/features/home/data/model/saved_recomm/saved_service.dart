import 'dart:async';
import 'package:rash7ly/features/home/data/model/place_model.dart';

class SavedService {
  static final List<PlaceModel> saved = [];

  static final StreamController<List<PlaceModel>> _controller =
      StreamController<List<PlaceModel>>.broadcast();

  static Stream<List<PlaceModel>> get stream => _controller.stream;

  static void toggleSaved(PlaceModel item) {
    final exists = saved.any((e) => e.title == item.title);

    if (exists) {
      saved.removeWhere((e) => e.title == item.title);
    } else {
      saved.add(item);
    }

    _controller.add(List.from(saved));
  }

  static bool isSaved(PlaceModel item) {
    return saved.any((e) => e.title == item.title);
  }
}
