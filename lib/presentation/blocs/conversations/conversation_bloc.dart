import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/repository/chat_repository.dart';
import 'package:logger/logger.dart';

import '../../../core/di/di.dart';
import '../../../core/errors/failure.dart';
import '../../../core/firebase/firebase_auth_service.dart';
import '../../../domain/entity/conversation_model.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ChatRepository chatRepository;
  ConversationBloc(this.chatRepository) : super(ConversationLoading()) {
    on<GetConversationsEvent>(_onGetConversations);
    on<SearchConversationEvent>(_onSearchConversations);
  }
  Future<void> _onGetConversations(
    GetConversationsEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());
    await emit.onEach<List<ConversationModel>>(
      chatRepository.getConversations(),
      onData: (conversations) {
        emit(
          ConversationFetched(
            conversations: conversations,
            searchConversations: conversations,
          ),
        );
      },
      onError: (error, stackTrace) {
        emit(ConversationFetchFailed(Failure(message: error.toString())));
        getIt<Logger>().i(error.toString());
      },
    );
  }

  Future<void> _onSearchConversations(
    SearchConversationEvent event,
    Emitter<ConversationState> emit,
  ) async {
    final currentState = state;
    if (currentState is ConversationFetched) {
      if (event.query.isEmpty) {
        emit(
          ConversationFetched(
            conversations: currentState.conversations,
            searchConversations: currentState.conversations,
          ),
        );
      } else {
        final filteredConversations = currentState.conversations.where((
          conversation,
        ) {
          final currentUserId = FirebaseAuthService.currentUserId;
          final otherUserId = conversation.participants.firstWhere(
            (uid) => uid != currentUserId,
          );
          final otherUserName =
              conversation.participantsData[otherUserId]['name'];
          return otherUserName.toLowerCase().contains(
            event.query.toLowerCase(),
          );
        }).toList();
        emit(
          ConversationFetched(
            conversations: currentState.conversations,
            searchConversations: filteredConversations,
          ),
        );
      }
    }
  }
}
