package com.luiz.meganlife

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent

class MeganAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {}
    override fun onInterrupt() {}
}
