// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../../../../core/enums/showcase_scenario.dart';
import 'scenario_page.dart';

class ShowcaseHomePage extends StatelessWidget {
  const ShowcaseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Input Showcase')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'This project demonstrates some basic text input use cases on the web in Flutter.',
            ),
            RichText(
              text: TextSpan(
                text: 'The source code can be found at: ',
                children: <InlineSpan>[
                  WidgetSpan(
                    child: _Link(
                      uri: Uri.parse(
                        'https://www.github.com/justinmc/textinputkitchensink',
                      ),
                      linkedText:
                          'github.com/justinmc/textinputkitchensink',
                    ),
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'A similar project written in HTML, CSS, and JavaScript can be found at: ',
                children: <InlineSpan>[
                  WidgetSpan(
                    child: _Link(
                      uri: Uri.parse(
                        'https://justinmc.github.io/textinputkitchensink-web/',
                      ),
                      linkedText: 'justinmc.github.io/textinputkitchensink-web/',
                    ),
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ShowcaseScenario.values.length,
                itemBuilder: (context, index) {
                  final scenario = ShowcaseScenario.values[index];
                  return ListTile(
                    title: Text(scenario.title),
                    subtitle: Text(scenario.description),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => ScenarioPage(scenario: scenario),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Link extends StatefulWidget {
  const _Link({required this.uri, required this.linkedText});

  final Uri uri;
  final String linkedText;

  @override
  State<_Link> createState() => _LinkState();
}

class _LinkState extends State<_Link> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: widget.uri,
      target: LinkTarget.blank,
      builder: (BuildContext context, FollowLink? followLink) {
        return GestureDetector(
          onTap: followLink,
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                _hovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _hovered = false;
              });
            },
            cursor: SystemMouseCursors.click,
            child: Text(
              widget.linkedText,
              style: TextStyle(
                color: Colors.blue,
                decoration: _hovered ? TextDecoration.underline : null,
                decorationColor: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
