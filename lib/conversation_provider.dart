import 'package:flutter/material.dart';

import 'models.dart';

class ConversationProvider extends ChangeNotifier {
  List<Conversation> _conversations = [];
  int _currentConversationIndex = 0;
  String apikey = "YOUR_API_KEY";
  String proxy = "";
  List<Conversation> get conversations => _conversations;
  int get currentConversationIndex => _currentConversationIndex;
  String get currentConversationTitle =>
      _conversations[_currentConversationIndex].title;
  int get currentConversationLength =>
      _conversations[_currentConversationIndex].messages.length;
  String get yourapikey => apikey;
  String get yourproxy => proxy;
  Conversation get currentConversation =>
      _conversations[_currentConversationIndex];
  // get current conversation's messages format
  //'messages': [
  //   {'role': 'user', 'content': text},
  // ],
  List<Map<String, String>> get currentConversationMessages {
    List<Map<String, String>> messages = [
      {
        'role': "system",
        'content': "",
      }
    ];
    for (Message message
        in _conversations[_currentConversationIndex].messages) {
      messages.add({
        'role': message.senderId == 'User' ? 'user' : 'system',
        'content': message.content
      });
    }
    return messages;
  }

  // initialize provider conversation list
  ConversationProvider() {
    _conversations.add(Conversation(messages: [], title: 'new conversation'));
  }

  // change conversations
  set conversations(List<Conversation> value) {
    _conversations = value;
    notifyListeners();
  }

  // change current conversation
  set currentConversationIndex(int value) {
    _currentConversationIndex = value;
    notifyListeners();
  }

  // change api key
  set yourapikey(String value) {
    apikey = value;
    notifyListeners();
  }

  set yourproxy(String value) {
    proxy = value;
    notifyListeners();
  }

  // add to current conversation
  void addMessage(Message message) {
    _conversations[_currentConversationIndex].messages.add(message);
    notifyListeners();
  }

  // add a new empty conversation
  // default title is 'new conversation ${_conversations.length}'
  void addEmptyConversation(String title) {
    if (title == '') {
      title = 'new conversation ${_conversations.length}';
    }
    _conversations.add(Conversation(messages: [], title: title));
    _currentConversationIndex = _conversations.length - 1;
    notifyListeners();
  }

  // add new conversation
  void addConversation(Conversation conversation) {
    _conversations.add(conversation);
    _currentConversationIndex = _conversations.length - 1;
    notifyListeners();
  }

  // remove conversation by index
  void removeConversation(int index) {
    _conversations.removeAt(index);
    _currentConversationIndex = _conversations.length - 1;
    notifyListeners();
  }

  // remove current conversation
  void removeCurrentConversation() {
    _conversations.removeAt(_currentConversationIndex);
    _currentConversationIndex = _conversations.length - 1;
    if (_conversations.isEmpty) {
      addEmptyConversation('');
    }
    notifyListeners();
  }

  //rename conversation
  void renameConversation(String title) {
    if (title == "") {
      // no title, use default title
      title = 'new conversation $_currentConversationIndex';
    }
    _conversations[_currentConversationIndex].title = title;
    notifyListeners();
  }

  // clear all conversations
  void clearConversations() {
    _conversations.clear();
    addEmptyConversation('');
    notifyListeners();
  }

  // clear current conversation
  void clearCurrentConversation() {
    _conversations[_currentConversationIndex].messages.clear();
    notifyListeners();
  }
}

const String model = "gpt-3.5-turbo";

final Sender systemSender = Sender(
    name: 'System', avatarAssetPath: 'resources/avatars/ChatGPT_logo.png');
final Sender userSender =
    Sender(name: 'User', avatarAssetPath: 'resources/avatars/person.png');
