import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:telejob/features/intro/presentation/widgets/page_view_data.dart';

class Indicators extends StatelessWidget {
  const Indicators(this._data, this._currentPage, {super.key});

  final List<Data> _data;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return PageViewDotIndicator(
      currentItem: _currentPage,
      count: _data.length,
      unselectedColor: Theme.of(context).colorScheme.onPrimary,
      selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
      boxShape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      unselectedSize: const Size(10, 10),
      size: const Size(28, 10),
    );
  }
}
