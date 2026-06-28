class ModelConfig {
  static const String modelName = 'PocketAI Gemma 4 E2B';
  static const String version = '1.0.0';
  static const String downloadUrl =
      'https://huggingface.co/unsloth/gemma-4-E2B-it-qat-GGUF/resolve/main/gemma-4-E2B-it-qat-UD-Q2_K_XL.gguf';
  static const String fileName = 'gemma-4-E2B-it-qat-UD-Q2_K_XL.gguf';
  static const String sha256 = 'skip_for_now';
  static const int expectedSizeBytes = 2194728960;

  static const int recommendedThreads = 4;
  static const int contextSize = 2048;
  static const int maxTokens = 512;
  static const int nGpuLayers = -1;
  static const double temperature = 0.7;
  static const double topP = 0.95;
}
