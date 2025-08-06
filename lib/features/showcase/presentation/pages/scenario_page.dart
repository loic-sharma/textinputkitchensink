// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../../../core/enums/showcase_scenario.dart';
import '../../../../core/enums/widget_style.dart';
import '../widgets/scenarios/scenario_widget_factory.dart';

class ScenarioPage extends StatefulWidget {
  final ShowcaseScenario scenario;

  const ScenarioPage({super.key, required this.scenario});

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  WidgetStyle _currentStyle = WidgetStyle.material;

  WidgetStyle get nextStyle => switch (_currentStyle) {
    WidgetStyle.material => WidgetStyle.cupertino,
    WidgetStyle.cupertino => WidgetStyle.material,
  };

  void _toggleStyle() {
    setState(() {
      _currentStyle = nextStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scenario.title),
        actions: [
          TextButton.icon(
            onPressed: _toggleStyle,
            icon: Icon(switch (nextStyle) {
              WidgetStyle.material => Icons.android,
              WidgetStyle.cupertino => Icons.apple,
            }),
            label: Text(nextStyle.title),
          ),
        ],
      ),
      body: ScenarioWidgetFactory.createWidget(widget.scenario, _currentStyle),
    );
  }
}
