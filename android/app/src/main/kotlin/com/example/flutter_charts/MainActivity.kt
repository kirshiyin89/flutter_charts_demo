package com.example.flutter_charts

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.collections.HashMap

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.flutter.dart/flutter_chart"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getData") {
                result.success(getData())
            }
        }
    }

    private fun getData(): HashMap<Int, Int> {
        return hashMapOf(
                2015 to 50000, 2016 to 25000, 2017 to 55000, 2018 to 10000, 2019 to 75000
        );
    }
}