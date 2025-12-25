import 'package:bloc/bloc.dart';
import 'package:chat_app/core/di/di.dart';
import 'package:chat_app/domain/repository/chat_repository.dart';
import 'package:logger/logger.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entity/message_model.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatRepository chatRepository;

  MessageBloc(this.chatRepository) : super(MessageSending()) {
    on<SendMessageEvent>(_onSendMessage);
    on<GetMessagesEvent>(_onGetMessages);
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    final result = await chatRepository.sendMessage(event.messageModel);
    result.fold((failure) => emit(MessageSendFailed(failure)), (success) {});
  }

  Future<void> _onGetMessages(
    GetMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    emit(MessageReceiving());
    await emit.onEach<List<MessageModel>>(
      chatRepository.getMessages(event.conversationId),
      onData: (messages) {
        emit(MessageReceived(messages));
        getIt<Logger>().i(messages.length);
      },
      onError: (error, stackTrace) {
        emit(MessageReceiveFailed(Failure(message: error.toString())));
        getIt<Logger>().i(error.toString());
      },
    );
  }
}
