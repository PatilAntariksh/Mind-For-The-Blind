import 'package:flutter/material.dart';

class ModeSelection extends StatelessWidget {
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Choose Your Mode",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        buildModeButton(
                          context,
                          title: "Back",
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        buildModeButton(
                          context,
                          title: "Video Navigation",
                          color: Colors.grey,
                          onPressed: () {
                            // This route is still empty.
                            Navigator.pushNamed(context, '/video_room');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        buildModeButton(
                          context,
                          title: "Currency Detection",
                          color: Colors.grey,
                          onPressed: () {
                            // Updated route to point to the test inference screen.
                            Navigator.pushNamed(context, '/camera');
                          },
                        ),
                        const SizedBox(width: 10),
                        buildModeButton(
                          context,
                          title: "AI-Assistant",
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.pushNamed(context, '/ai_assistant');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildModeButton(
      BuildContext context, {
        required String title,
        required Color color,
        required VoidCallback onPressed,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
