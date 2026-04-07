import 'package:equatable/equatable.dart';

abstract class NotificationToggleState extends Equatable {
  final bool isEnabled;

  const NotificationToggleState({this.isEnabled = true});

  @override
  List<Object?> get props => [isEnabled];
}

class NotificationToggleInitial extends NotificationToggleState {
  const NotificationToggleInitial({super.isEnabled});
}

class NotificationToggleLoading extends NotificationToggleState {
  const NotificationToggleLoading({required super.isEnabled});
}

class NotificationToggleSuccess extends NotificationToggleState {
  final String? message;

  const NotificationToggleSuccess({required super.isEnabled, this.message});

  @override
  List<Object?> get props => [isEnabled, message];
}

class NotificationToggleError extends NotificationToggleState {
  final String errorMessage;

  const NotificationToggleError({
    required super.isEnabled,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [isEnabled, errorMessage];
}
