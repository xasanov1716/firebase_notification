import 'package:equatable/equatable.dart';



abstract class NotificationState extends Equatable{}

class NotificationInitial extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadingState extends NotificationState{
  @override
  List<Object?> get props => [];
}

class NotificationErrorState extends NotificationState{
  final String errorText;
  NotificationErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}

class NotificationSuccessState extends NotificationState{
  @override
  List<Object?> get props => [];
}
class NotificationImageUploadState extends NotificationState{
  @override
  List<Object?> get props => [];
}