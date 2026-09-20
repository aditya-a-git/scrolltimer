package com.example.scrolltimer

import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
	override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
		super.configureFlutterEngine(flutterEngine)

		MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
			.setMethodCallHandler { call, result ->
				if (call.method == "getForegroundApp") {
					result.success(getForegroundApp())
				} else {
					result.notImplemented()
				}
			}
	}

	private fun getForegroundApp(): String? {
		val usageStatsManager =
			getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
		val endTime = System.currentTimeMillis()
		val usageEvents = usageStatsManager.queryEvents(endTime - 5000, endTime)
		val event = UsageEvents.Event()
		var foregroundApp: String? = null

		while (usageEvents.hasNextEvent()) {
			usageEvents.getNextEvent(event)
			if (event.eventType == UsageEvents.Event.ACTIVITY_RESUMED) {
				foregroundApp = event.packageName
			}
		}

		return foregroundApp
	}

	private companion object {
		const val CHANNEL = "scrolltimer/foreground"
	}
}
