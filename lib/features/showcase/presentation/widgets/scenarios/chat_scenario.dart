// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/enums/widget_style.dart';

class ChatScenario extends StatefulWidget {
  final WidgetStyle style;

  const ChatScenario({super.key, required this.style});

  @override
  State<ChatScenario> createState() => _ChatScenarioState();
}

class _ChatScenarioState extends State<ChatScenario> {
  final _controller = TextEditingController();

  final List<_Message> _messages = <_Message>[
    _Message(
      sender: _Sender.me,
      text:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
    _Message(
      sender: _Sender.someoneElse,
      text:
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
  ];

  void _submit() {
    if (_controller.text.isEmpty) {
      return;
    }
    setState(() {
      _messages.add(_Message(text: _controller.text, sender: _Sender.me));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMaterialVersion() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                reverse: true,
                children:
                    _messages.reversed
                        .map(
                          (_Message message) =>
                              _MessageWidget(message: message),
                        )
                        .toList(),
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    onFieldSubmitted: (String value) => _submit(),
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffdddddd),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(onPressed: _submit, icon: Icon(Icons.send)),
              ],
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoVersion() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                reverse: true,
                children:
                    _messages.reversed
                        .map(
                          (_Message message) =>
                              _MessageWidget(message: message),
                        )
                        .toList(),
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: CupertinoTextField(
                    onSubmitted: (String? value) => _submit(),
                    controller: _controller,
                  ),
                ),
                CupertinoButton(
                  onPressed: _submit,
                  child: Icon(CupertinoIcons.arrow_right),
                ),
              ],
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.style == WidgetStyle.material
        ? _buildMaterialVersion()
        : _buildCupertinoVersion();
  }
}

class _Message {
  const _Message({required this.text, required this.sender});

  final String text;
  final _Sender sender;
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget({required this.message});

  final _Message message;

  Color get _backgroundColor => switch (message.sender) {
    _Sender.me => Colors.blue,
    _Sender.someoneElse => Colors.grey,
  };

  Color get _textColor => switch (message.sender) {
    _Sender.me => Colors.white,
    _Sender.someoneElse => Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (message.sender == _Sender.me) SizedBox(width: 24.0),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message.text, style: TextStyle(color: _textColor)),
              ),
            ),
          ),
          if (message.sender == _Sender.someoneElse) SizedBox(width: 24.0),
        ],
      ),
    );
  }
}

enum _Sender { me, someoneElse }
