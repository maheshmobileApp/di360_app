enum ChatMessageType { text, file }


class ChatMessage {
  final ChatMessageType type;
  final bool isMine;
  final String? text;
  final DateTime timestamp;

  // file fields
  final String? fileName;
  final String? fileSize;
  final String? filePath;

  ChatMessage._({
    required this.type,
    required this.isMine,
    this.text,
    required this.timestamp,
    this.fileName,
    this.fileSize,
    this.filePath,
  });

  factory ChatMessage.text(
      {required String text,
      required bool isMine,
      required DateTime timestamp}) {
    return ChatMessage._(
        type: ChatMessageType.text,
        isMine: isMine,
        text: text,
        timestamp: timestamp);
  }

  factory ChatMessage.file(
      {required String fileName,
      required String fileSize,
      String? filePath,
      required bool isMine,
      required DateTime timestamp}) {
    return ChatMessage._(
      type: ChatMessageType.file,
      isMine: isMine,
      fileName: fileName,
      fileSize: fileSize,
      filePath: filePath,
      timestamp: timestamp,
    );
  }
}