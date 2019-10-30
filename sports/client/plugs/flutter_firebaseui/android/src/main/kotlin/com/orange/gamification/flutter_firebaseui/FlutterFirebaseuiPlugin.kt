package com.orange.gamification.flutter_firebaseui

import android.app.Activity
import android.content.Context
import com.firebase.ui.auth.AuthUI
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterFirebaseuiPlugin(var registrar: Registrar) : MethodCallHandler {
    private val RC_SIGN_IN = 999

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_firebaseui")
            channel.setMethodCallHandler(FlutterFirebaseuiPlugin(registrar))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "logIn") {
            logIn(call, result)
        } else {
            result.notImplemented()
        }
    }

    private fun logIn(call: MethodCall, result: MethodChannel.Result) {
// Choose authentication providers
        val providers = arrayListOf(
                AuthUI.IdpConfig.PhoneBuilder().build())
        registrar.activity().startActivityForResult(
                AuthUI.getInstance()
                        .createSignInIntentBuilder()
                        .setAvailableProviders(providers)
                        .build(),
                RC_SIGN_IN)
        registrar.addActivityResultListener { requestCode, resultCode, data ->
            if (resultCode == Activity.RESULT_OK) {
                result.success("logIn success")
            } else {
                result.error("404", "logIn success","")
            }
            true
        }

    }

}
