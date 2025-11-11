//! by ibrhaim
class ReviewModel {
  String? id;
  String? userId;
  String? placeId;
  String? comment;
  double? rate;
  String? date;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.comment,
    required this.rate,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userId: json['userId'],
      placeId: json['placeId'],
      comment: json['comment'],
      rate: json['rate'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'placeId': placeId,
      'comment': comment,
      'rate': rate,
      'date': date,
    };
  }
}
