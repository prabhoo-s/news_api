import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Data/Models/sources.dart';
import 'package:news_api/Styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sources_tab_row_text.dart';

class SourcesTabRow extends StatelessWidget {
  const SourcesTabRow({
    required this.source,
    required this.lastItem,
  });

  final Sources source;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SourcesTabRowText(source: source),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              launch(source.url);
            },
            child: const Icon(
              Icons.open_in_browser_outlined,
            ),
          ),
        ],
      ),
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.rowDivider,
          ),
        ),
      ],
    );
  }
}