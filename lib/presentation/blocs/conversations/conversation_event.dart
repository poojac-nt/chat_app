import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {}

class GetConversationsEvent extends ConversationEvent {
  @override
  List<Object?> get props => [];
}
