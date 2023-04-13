import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/services/api_services.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String choserModelId}) async {
    chatList.addAll(
        await ApiServices.sendMessage(message: msg, modelId: choserModelId));
    notifyListeners();
  }
}
