import 'dart:io';

import '../models/message.dart';
import '../services/auth_service.dart';
import '../services/socket_service.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:provider/provider.dart';

import '../services/chat_service.dart';
import '../services/preferences_service.dart';
import '../widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _focus = FocusNode();
  bool _isEnabled = false;
  bool _showEmojiPicker = false;

  final List<ChatMessage> _messages = [];
  // List<String> _recentEmojis = [];
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  late PreferencesService preferencesService;

  @override
  void initState() {
    super.initState();
    preferencesService = PreferencesService();
    // _loadRecentEmojis();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService.on('private-message', _listenMessage);
    _loadMessages(chatService.userTo.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = chatService.userTo;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                user.name.substring(0, 2),
              ),
            ),
            const SizedBox(width: 10),
            Text(user.name, style: const TextStyle(color: Colors.black87)),
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
            _emojiPicker(),
            _inputChat(),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _showEmojiPicker = !_showEmojiPicker;
                  if (!_showEmojiPicker) {
                    _focus.requestFocus();
                  } else {
                    _focus.unfocus();
                  }
                });
              },
              icon: const Icon(Icons.emoji_emotions_outlined),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'Write a message',
                ),
                onSubmitted: _handleSubmit,
                onTap: () => setState(() => _showEmojiPicker = false),
                onChanged: (value) {
                  setState(() {
                    _isEnabled = value.trim().isNotEmpty;
                  });
                },
                focusNode: _focus,
              ),
            ),
            Platform.isAndroid
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
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isEnabled ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _emojiPicker() {
    return Offstage(
      offstage: !_showEmojiPicker,
      child: EmojiPicker(
        textEditingController: _controller,
        scrollController: _scrollController,
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          viewOrderConfig: const ViewOrderConfig(),
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.2
                    : 1.0),
          ),
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(),
          bottomActionBarConfig: const BottomActionBarConfig(),
          searchViewConfig: const SearchViewConfig(),
        ),
        onEmojiSelected: (category, emoji) {
          setState(() {
            _isEnabled = _controller.text.trim().isNotEmpty;
          });
          _saveRecentEmoji(emoji.emoji);
        },
      ),
    );
  }

  void _saveRecentEmoji(String emoji) async {
    List<String> recentEmojis = await preferencesService.getRecentEmojis();
    if (!recentEmojis.contains(emoji)) {
      recentEmojis.add(emoji);
    }
    await preferencesService.saveRecentEmojis(recentEmojis);
  }

  // void _loadRecentEmojis() async {
  //   _recentEmojis = await preferencesService.getRecentEmojis();

  //   setState(() {});
  // }

  void _handleSubmit(String text) {
    if (text.isEmpty) return;

    _controller.clear();
    _focus.requestFocus();

    final newMessage = ChatMessage(
        message: text,
        uid: authService.user.uid,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 500)));
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _showEmojiPicker = false;
      _isEnabled = false;
    });

    socketService.emit('private-message', {
      'from': authService.user.uid,
      'to': chatService.userTo.uid,
      'message': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  void _listenMessage(data) {
    final newMessage = ChatMessage(
        message: data['message'],
        uid: data['from'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 500)));
    setState(() {
      _messages.insert(0, newMessage);
    });
    newMessage.animationController.forward();
  }

  void _loadMessages(String userId) async {
    List<Message> chat = await chatService.getChats(userId);

    final historyMessages = chat.map((message) => ChatMessage(
        message: message.message,
        uid: message.from,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messages.insertAll(0, historyMessages);
    });
  }

  @override
  void dispose() {
    for (final message in _messages) {
      message.animationController.dispose();
    }
    _controller.dispose();
    socketService.off('private-message');
    super.dispose();
  }
}
