import 'dart:io';

import '../widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final _focus = FocusNode();
  // final bool _isKeyboardVisible = false;
  bool _isEnabled = false;

  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: const Text('U'),
            ),
            const SizedBox(width: 10),
            const Text('User', style: TextStyle(color: Colors.black87)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) => _messages[index],
              ),
            ),
            const Divider(),
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  _inputChat() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions_outlined),
            ),
            Flexible(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'Write a message',
                ),
                onSubmitted: _handleSubmit,
                onChanged: (value) => {
                  setState(() {
                    if (value.trim().isNotEmpty) {
                      _isEnabled = true;
                    } else {
                      _isEnabled = false;
                    }
                  })
                },
                textInputAction: TextInputAction.send,
                focusNode: _focus,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isAndroid
                  ? FloatingActionButton(
                      onPressed: _isEnabled
                          ? () => _handleSubmit(_controller.text.trim())
                          : null,
                      child: Icon(Icons.send,
                          color: _isEnabled ? Colors.green : Colors.grey),
                    )
                  : CupertinoButton(
                      onPressed: _isEnabled
                          ? () => _handleSubmit(_controller.text.trim())
                          : null,
                      child: Text('Send',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _isEnabled ? Colors.green : Colors.grey)),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _controller.clear();
    _focus.requestFocus();

    final newMessage = ChatMessage(
        message: text,
        uuid: 'myUuid',
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 500)));
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isEnabled = false;
    });
  }

  @override
  void dispose() {
    for (final message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
