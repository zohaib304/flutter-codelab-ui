import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'FriendlyChat',
      home: ChatScreen(),
    ),
  );
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
  }

  Widget _buidTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                return _messages[index];
              },
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buidTextComposer(),
          )
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String _name = 'Zohaib';
  ChatMessage({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
