// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/enums/widget_style.dart';

class SelectableTextScenario extends StatefulWidget {
  final WidgetStyle style;

  const SelectableTextScenario({super.key, required this.style});

  @override
  State<SelectableTextScenario> createState() => _SelectableTextScenarioState();
}

class _SelectableTextScenarioState extends State<SelectableTextScenario> {
  final TextEditingController _controller1 = TextEditingController(text: 'Text field');
  final TextEditingController _controller2 = TextEditingController(text: 'Read-only text field');

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Widget _buildMaterialVersion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16.0,
        children: [
          SelectableText('This is selectable text thanks to SelectableText!'),

          SelectionArea(
            child: Text('This is selectable text thanks to SelectionArea!'),
          ),

          TextField(
            controller: _controller1,
          ),

          TextField(
            controller: _controller2,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoVersion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16.0,
        children: [
          SelectableText('This is selectable text thanks to SelectableText!'),

          SelectionArea(
            child: Text('This is selectable text thanks to SelectionArea!'),
          ),

          CupertinoTextField(
            controller: _controller1,
          ),

          CupertinoTextField(
            controller: _controller2,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.style == WidgetStyle.material
        ? _buildMaterialVersion()
        : _buildCupertinoVersion(),
    );
  }
}
