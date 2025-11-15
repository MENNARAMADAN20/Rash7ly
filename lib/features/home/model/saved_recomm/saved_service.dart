import 'dart:async';
import 'package:rash7ly/features/home/model/Best_destinations.dart';

class SavedService {
  static final List<BestDestination> saved = [];

  static final StreamController<List<BestDestination>> _controller =
      StreamController<List<BestDestination>>.broadcast();

  static Stream<List<BestDestination>> get stream => _controller.stream;

  static void toggleSaved(BestDestination item) {
    final exists = saved.any((e) => e.image == item.image);

    if (exists) {
      saved.removeWhere((e) => e.image == item.image);
    } else {
      saved.add(item);
    }

    _controller.add(List.from(saved));
  }

  static bool isSaved(BestDestination item) {
    return saved.any((e) => e.image == item.image);
  }
}
