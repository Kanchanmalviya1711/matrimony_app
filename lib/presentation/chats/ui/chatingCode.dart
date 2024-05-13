import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.cyan,
    Colors.red,
    Colors.amber,
    Colors.pink,
    Colors.orange,
    Colors.teal,
    Colors.yellow,
    Colors.purple,
    Colors.indigo,
    Colors.lime,
  ];
  IOWebSocketChannel? _channel;
  String? _username;
  String? _password;
  List<Widget> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _username == null ? _buildUsernamePage() : _buildChatPage();
  }

  Widget _buildUsernamePage() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(
            onPressed: _connect,
            child: Text('Connect'),
          ),
          if (_password != null) Text('Wrong password'),
        ],
      ),
    );
  }

  Widget _buildChatPage() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: _messages,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(labelText: 'Message'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _connect() {
    _username = _usernameController.text.trim();
    _password = _passwordController.text;

    if (_username!.isNotEmpty) {
      // Check password
      if (_password == "hello") {
        setState(() {});
        _channel = IOWebSocketChannel.connect('ws://localhost:8080/websocket');
        _channel!.stream.listen((message) {
          _handleMessage(message);
        });
      }
    }
  }

  void _sendMessage() {
    String messageContent = _messageController.text.trim();
    if (messageContent.isNotEmpty && _channel != null) {
      Map<String, dynamic> chatMessage = {
        'sender': _username,
        'content': messageContent,
        'type': 'CHAT',
      };
      _channel!.sink.add(jsonEncode(chatMessage));
      _messageController.clear();
    }
  }

  void _handleMessage(dynamic message) {
    Map<String, dynamic> parsedMessage = jsonDecode(message);
    String type = parsedMessage['type'];
    String sender = parsedMessage['sender'];
    String content = parsedMessage['content'];

    if (type == 'JOIN') {
      _addMessage('$sender joined!', Colors.grey);
    } else if (type == 'LEAVE') {
      _addMessage('$sender left!', Colors.grey);
    } else {
      _addMessage(content, _getAvatarColor(sender));
    }
  }

  void _addMessage(String messageContent, Color color) {
    _messages.add(
      ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(_username![0]),
        ),
        title: Text(_username!),
        subtitle: Text(messageContent),
      ),
    );
    setState(() {});
  }

  Color _getAvatarColor(String messageSender) {
    int hash = 0;
    for (int i = 0; i < messageSender.length; i++) {
      hash = 31 * hash + messageSender.codeUnitAt(i);
    }
    int index = hash.abs() % _colors.length;
    return _colors[index];
  }

  @override
  void dispose() {
    _channel!.sink.close();
    super.dispose();
  }
}
