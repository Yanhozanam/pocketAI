
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:be_smart_ai/main.dart';

class FakePathProvider with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/besmartai_test';
  }

  @override
  Future<String?> getTemporaryPath() async {
    return '/besmartai_test_tmp';
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return '/besmartai_test';
  }

  @override
  Future<String?> getLibraryPath() async {
    return '/besmartai_test';
  }

  @override
  Future<String?> getDownloadsPath() async => null;

  @override
  Future<String?> getExternalStoragePath() async => null;

  @override
  Future<List<String>?> getExternalCachePaths() async => null;

  @override
  Future<List<String>?> getExternalStoragePaths({StorageDirectory? type}) async => null;

  @override
  Future<String?> getApplicationCachePath() async {
    return '/besmartai_test_cache';
  }
}

void main() {
  setUp(() {
    PathProviderPlatform.instance = FakePathProvider();
  });

  testWidgets('App launches and shows download screen when model missing',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BeSmartAIApp());
    await tester.pump();

    expect(find.text('Setting up BeSmartAI'), findsOneWidget);
  });

  testWidgets('Download screen shows BeSmartAI branding',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BeSmartAIApp());
    await tester.pump();

    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });
}

