class ReviewService {
  static Map<String, List<Map<String, String>>> reviews = {};

  static List<Map<String, String>> getReviews(String placeId) {
    return reviews[placeId] ?? [];
  }

  static void addReview(String placeId, String user, String text) {
    reviews.putIfAbsent(placeId, () => []);
    reviews[placeId]!.insert(0, {"user": user, "text": text});
  }
}
