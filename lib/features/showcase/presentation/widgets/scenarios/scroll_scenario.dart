// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/enums/widget_style.dart';

class ScrollScenario extends StatefulWidget {
  final WidgetStyle style;

  const ScrollScenario({super.key, required this.style});

  @override
  State<ScrollScenario> createState() => _ScrollScenarioState();
}

class _ScrollScenarioState extends State<ScrollScenario> {
  Widget _buildMaterialVersion() {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextEditingControllerBuilder(
                text: 'Text field $index',
                builder: (context, controller) => TextField(controller: controller),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCupertinoVersion() {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextEditingControllerBuilder(
                text: 'Text field $index',
                builder: (context, controller) => CupertinoTextField(controller: controller),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.style == WidgetStyle.material
      ? _buildMaterialVersion()
      : _buildCupertinoVersion();
  }
}

class TextEditingControllerBuilder extends StatefulWidget {
  const TextEditingControllerBuilder({
    super.key,
    this.text,
    required this.builder,
  });

  final String? text;
  final Widget Function(BuildContext context, TextEditingController controller) builder;

  @override
  State<TextEditingControllerBuilder> createState() => _TextEditingControllerBuilderState();
}

class _TextEditingControllerBuilderState extends State<TextEditingControllerBuilder> {
  late final TextEditingController controller = TextEditingController(text: widget.text);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
