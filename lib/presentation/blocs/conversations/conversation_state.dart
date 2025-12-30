import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entity/conversation_model.dart';

abstract class ConversationState extends Equatable {}

class ConversationLoading extends ConversationState {
  @override
  List<Object?> get props => [];
}

class ConversationFetched extends ConversationState {
  final List<ConversationModel> searchConversations;
  final List<ConversationModel> conversations;
  ConversationFetched({
    required this.conversations,
    required this.searchConversations,
  });
  @override
  List<Object?> get props => [conversations, searchConversations];
}

class ConversationFetchFailed extends ConversationState {
  final Failure failure;
  ConversationFetchFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}
