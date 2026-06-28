import 'package:llamafu/llamafu.dart';
import '../config/model_config.dart';

abstract class LLMService {
  Future<String> generateResponse(String input);
  bool get isAvailable;
  Future<void> initialize();
  void dispose();
}

class MockLLMService implements LLMService {
  @override
  bool get isAvailable => true;

  @override
  Future<void> initialize() async {}

  @override
  void dispose() {}

  @override
  Future<String> generateResponse(String input) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return 'mockResponse';
  }
}

class RealLLMService implements LLMService {
  final String modelPath;
  Llamafu? _llamafu;

  RealLLMService({
    required this.modelPath,
  });

  @override
  bool get isAvailable => _llamafu != null;

  @override
  Future<void> initialize() async {
    _llamafu = await Llamafu.init(
      modelPath: modelPath,
      threads: ModelConfig.recommendedThreads,
      contextSize: ModelConfig.contextSize,
    );
  }

  @override
  Future<String> generateResponse(String prompt) async {
    if (_llamafu == null) throw Exception('Model not initialized');
    return await _llamafu!.complete(
      prompt: prompt,
      maxTokens: ModelConfig.maxTokens,
      temperature: ModelConfig.temperature,
    );
  }

  @override
  void dispose() {
    _llamafu?.close();
  }
}
