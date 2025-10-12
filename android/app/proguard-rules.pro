# Flutter & Dart
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**
# Firebase Core
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Firestore / Database
-keepclassmembers class * {
  @com.google.firebase.firestore.PropertyName <fields>;
}

# Firebase Auth
-keep class com.google.android.gms.internal.firebase_auth.** { *; }

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# Firebase Analytics
-keep class com.google.firebase.analytics.** { *; }
# GetX
-keep class get.** { *; }
-keep class com.github.rey5137.material.** { *; }
# AndroidX
-keep class androidx.** { *; }
-dontwarn androidx.**

# Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Keep your application & main activity
-keep class com.yourpackagename.** { *; }

# Prevent stripping of R (resources)
-keep class **.R$* { *; }
