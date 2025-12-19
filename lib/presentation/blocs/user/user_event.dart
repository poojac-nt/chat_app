import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent {
  final String id;
  const FetchUser({required this.id});
  @override
  List<Object> get props => [id];
}
