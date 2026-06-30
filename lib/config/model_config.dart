class ModelConfig {
  static const String modelName = 'BeSmartAI Qwen2.5';
  static const String version = '1.0.0';
  static const String downloadUrl =
      'https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct-GGUF/resolve/main/qwen2.5-1.5b-instruct-q4_k_m.gguf';
  static const String fileName = 'qwen2.5-1.5b-instruct-q4_k_m.gguf';
  static const String sha256 = 'skip_for_now';
  static const int expectedSizeBytes = 1202590848;

  static const int recommendedThreads = 4;
  static const int contextSize = 2048;
  static const int maxTokens = 512;
  static const int nGpuLayers = -1;
  static const double temperature = 0.7;
  static const double topP = 0.95;
}