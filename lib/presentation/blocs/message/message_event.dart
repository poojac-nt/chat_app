import 'package:chat_app/domain/entity/message_model.dart';
import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {}

class SendMessageEvent extends MessageEvent {
  final MessageModel messageModel;
  SendMessageEvent(this.messageModel);
  @override
  List<Object?> get props => [messageModel];
}

class GetMessagesEvent extends MessageEvent {
  final String conversationId;

  GetMessagesEvent(this.conversationId);

  @override
  // TODO: implement props
  List<Object?> get props => [conversationId];
}
