package com.besmartai.app

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.besmartai.app/asset_extractor"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "extractModel") {
                val assetPath = call.argument<String>("assetPath") ?: ""
                val outputPath = call.argument<String>("outputPath") ?: ""
                try {
                    val outputFile = File(outputPath)
                    if (outputFile.exists()) {
                        result.success(outputPath)
                        return@setMethodCallHandler
                    }
                    outputFile.parentFile?.mkdirs()
                    val inputStream = assets.open(assetPath)
                    val outputStream = FileOutputStream(outputFile)
                    val buffer = ByteArray(8 * 1024)
                    var bytesRead: Int
                    while (inputStream.read(buffer).also { bytesRead = it } != -1) {
                        outputStream.write(buffer, 0, bytesRead)
                    }
                    outputStream.flush()
                    outputStream.close()
                    inputStream.close()
                    result.success(outputPath)
                } catch (e: Exception) {
                    result.error("EXTRACT_ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
