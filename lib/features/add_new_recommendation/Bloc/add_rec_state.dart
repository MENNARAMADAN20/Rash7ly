import 'package:equatable/equatable.dart';

abstract class AddRecState extends Equatable {
  const AddRecState();
  @override
  List<Object?> get props => [];
}

class AddRecInitial extends AddRecState {
  const AddRecInitial();
}

class AddRecLoading extends AddRecState {
  const AddRecLoading();
}

class AddRecProgress extends AddRecState {
  final double progress; // 0.0 - 1.0
  const AddRecProgress(this.progress);
  @override
  List<Object?> get props => [progress];
}

class AddRecSuccess extends AddRecState {
  final String docId;
  const AddRecSuccess(this.docId);
  @override
  List<Object?> get props => [docId];
}

class AddRecFailure extends AddRecState {
  final String error;
  const AddRecFailure(this.error);
  @override
  List<Object?> get props => [error];
}
