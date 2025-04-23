import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  final String roomId;

  VideoCallPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    // Generate a unique user ID each time
    final String userId = 'user_${DateTime.now().millisecondsSinceEpoch}';

    return ZegoUIKitPrebuiltCall(
      appID: 890795783, 
      appSign: '2bf1885667a1def2296bc2be92ce76588286aa2bf900295e0bf4541d399a15d6', 
      userID: userId,
      userName: 'User_$userId',
      callID: roomId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
