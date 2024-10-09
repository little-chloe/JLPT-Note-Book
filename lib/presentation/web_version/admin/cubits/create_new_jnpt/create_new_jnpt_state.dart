import 'package:equatable/equatable.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

abstract class CreateNewJnptState extends Equatable {
  const CreateNewJnptState();

  @override
  List<Object> get props => [];
}

class CreateNewJnptInitial extends CreateNewJnptState {}

class CreateNewJnptLoading extends CreateNewJnptState {}

class CreateNewJnptFailure extends CreateNewJnptState {
  final String message;

  const CreateNewJnptFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateNewJnptSuccess extends CreateNewJnptState {
  final String message;
  final LevelEntity levelEntity;

  const CreateNewJnptSuccess(
      {required this.message, required this.levelEntity});

  @override
  List<Object> get props => [message, levelEntity];
}
