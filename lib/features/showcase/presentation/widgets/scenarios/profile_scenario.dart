// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/enums/widget_style.dart';
import '../cupertino_form_field.dart';

class ProfileScenario extends StatefulWidget {
  final WidgetStyle style;

  const ProfileScenario({super.key, required this.style});

  @override
  State<ProfileScenario> createState() => _ProfileScenarioState();
}

class _ProfileScenarioState extends State<ProfileScenario> {
  final _bioController = TextEditingController();
  final GlobalKey<FormState> _formKeyMaterial = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCupertino = GlobalKey<FormState>();

  static String? _bioValidator(String? value) {
    return value != null && value.length >= 20
        ? null
        : 'Bios must contain at least 20 characters.';
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Widget _buildMaterialVersion() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyMaterial,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              buildCounter: (
                BuildContext context, {
                required int currentLength,
                required int? maxLength,
                required bool isFocused,
              }) {
                return Text('$currentLength / 20');
              },
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                hintText: 'Tell us about yourself',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              validator: _bioValidator,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (_formKeyMaterial.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoVersion() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyCupertino,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CupertinoFormField(
              controller: _bioController,
              placeholder: 'Tell us about yourself',
              prefixIcon: CupertinoIcons.text_justify,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              validator: _bioValidator,
            ),
            const SizedBox(height: 24),
            CupertinoButton.filled(
              onPressed: () {
                if (_formKeyCupertino.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create Profile'),
            ),
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
