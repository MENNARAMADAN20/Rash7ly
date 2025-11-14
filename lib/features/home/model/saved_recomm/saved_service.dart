import 'package:rash7ly/features/home/model/Best_destinations.dart';

class SavedService {
  static List<BestDestination> saved = [];

  static void toggleSaved(BestDestination item) {
    if (saved.contains(item)) {
      saved.remove(item);
    } else {
      saved.add(item);
    }
  }

  static bool isSaved(BestDestination item) {
    return saved.contains(item);
  }
}
