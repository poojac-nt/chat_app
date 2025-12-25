import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entity/message_model.dart';

abstract class MessageState extends Equatable {}

class MessageSending extends MessageState {
  MessageSending();
  @override
  List<Object?> get props => [];
}

class MessageSent extends MessageState {
  MessageSent();
  @override
  List<Object?> get props => [];
}

class MessageSendFailed extends MessageState {
  final Failure failure;
  MessageSendFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}

class MessageReceiving extends MessageState {
  MessageReceiving();
  @override
  List<Object?> get props => [];
}

class MessageReceived extends MessageState {
  final List<MessageModel> messages;
  MessageReceived(this.messages);
  @override
  List<Object?> get props => [messages];
}

class MessageReceiveFailed extends MessageState {
  final Failure failure;
  MessageReceiveFailed(this.failure);

  @override
  List<Object?> get props => [failure];
}
