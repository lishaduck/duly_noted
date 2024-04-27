import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
@RoutePage()
class SampleItemDetailsPage extends StatelessWidget {
  const SampleItemDetailsPage({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
