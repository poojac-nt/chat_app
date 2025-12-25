import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/repository/chat_repository.dart';
import 'package:logger/logger.dart';

import '../../../core/di/di.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entity/conversation_model.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ChatRepository chatRepository;
  ConversationBloc(this.chatRepository) : super(ConversationLoading()) {
    on<GetConversationsEvent>(_onGetConversations);
  }
  Future<void> _onGetConversations(
    GetConversationsEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());
    await emit.onEach<List<ConversationModel>>(
      chatRepository.getConversations(),
      onData: (conversations) {
        emit(ConversationFetched(conversations));
      },
      onError: (error, stackTrace) {
        emit(ConversationFetchFailed(Failure(message: error.toString())));
        getIt<Logger>().i(error.toString());
      },
    );
  }
}
