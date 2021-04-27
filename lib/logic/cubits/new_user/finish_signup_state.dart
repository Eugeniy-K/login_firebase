import 'package:equatable/equatable.dart';

enum ProgressStatus {init, inProgress}

class FinishSignupState extends Equatable {

  final userName;
  final ProgressStatus status;

  const FinishSignupState({this.userName = '',
    this.status = ProgressStatus.init});

  FinishSignupState copyWith({String? name, ProgressStatus? status}) {
    return FinishSignupState(
      userName: name ?? this.userName,
      status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [userName, status];
}