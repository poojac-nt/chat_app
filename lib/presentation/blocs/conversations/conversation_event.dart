import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {}

class GetConversationsEvent extends ConversationEvent {
  @override
  List<Object?> get props => [];
}

class SearchConversationEvent extends ConversationEvent {
  final String query;
  SearchConversationEvent(this.query);
  @override
  List<Object?> get props => [query];
}
