// Model classes for the chat app

// conversations include multiple messages
class Conversation {
  final List<Message> messages;
  String title;

  Conversation({required this.messages, required this.title});
}

// Sender should have name and avatar
class Sender {
  final String name;
  final String avatarAssetPath;
  // id
  final String id;

  Sender({required this.name, required this.avatarAssetPath, String? id})
      : id = id ?? name;
}

// message should have role, content, timestamp
class Message {
  final String content;
  final DateTime timestamp;
  // sender id
  final String senderId;

  Message({required this.content, required this.senderId, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}