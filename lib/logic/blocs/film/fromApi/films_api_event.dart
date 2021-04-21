
import 'package:equatable/equatable.dart';

abstract class FilmsApiEvent extends Equatable {
  const FilmsApiEvent();
}

class FilmsApiRequested extends FilmsApiEvent {
  @override
  List<Object?> get props => [];

}