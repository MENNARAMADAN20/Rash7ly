import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class AddRecEvent extends Equatable {
  const AddRecEvent();
  @override
  List<Object?> get props => [];
}

class AddRecSubmitted extends AddRecEvent {
  final String name;
  final String description;
  final String location;
  final String category;
  final String userId;
  final List<File> images;

  const AddRecSubmitted({
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.userId,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
    name,
    description,
    location,
    category,
    userId,
    images,
  ];
}
