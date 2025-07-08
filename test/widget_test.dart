import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bakeflow_erp/main.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: BakeFlowApp(),
      ),
    );
    
    // Verify the app loads
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}