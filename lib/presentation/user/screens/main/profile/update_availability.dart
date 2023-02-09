import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workerr_app/core/colors.dart';
import 'package:workerr_app/core/constants.dart';

class UpdateAvailability extends StatefulWidget {
  const UpdateAvailability({Key? key}) : super(key: key);

  @override
  State<UpdateAvailability> createState() => _UpdateAvailabilityState();
}

class _UpdateAvailabilityState extends State<UpdateAvailability> {
  int? groupValue = 2;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Update Availability',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: backgroundColor,
                  decoration: TextDecoration.none),
            ),
            ksize(x: 100),
            const Divider(),
            kheight20,
            CupertinoSlidingSegmentedControl<int>(
              thumbColor: CupertinoColors.link,
              backgroundColor: CupertinoColors.white,
              padding: EdgeInsets.all(4),
              groupValue: groupValue,
              children: {
                0: const Text(
                  'Availability',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: backgroundColor,
                      decoration: TextDecoration.none),
                ),
                1: buildSegment('On'),
                2: buildSegment('Off'),
              },
              onValueChanged: (value) {
                if (value == 0) {
                  setState(() {
                    groupValue = groupValue;
                  });
                } else {
                  setState(() {
                    groupValue = value;
                  });
                }
              },
            ),
            kheight20,
            const Divider(),
            ksize(x: 100),
            Container(
              width: 115,
              height: 45,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 239, 239),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextButton(
                  onHover: (hovered) => setState(() {
                    this.isPressed = hovered;
                  }),
                  style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    // await Future.delayed(const Duration(milliseconds: 800));

                    Navigator.pop(context);
                  },
                  onLongPress: () {
                    // Navigator.pop(context);
                  },
                  child: Listener(
                    onPointerDown: (event) => setState(() {
                      isPressed = true;
                    }),
                    onPointerUp: (event) => setState(() {
                      isPressed = false;
                    }),
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Go Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            shadows: [
                              for (double i = 1; i < (isPressed ? 10 : 6); i++)
                                Shadow(
                                  color: kshadowColor,
                                  blurRadius: 3,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSegment(String text) => Container(
        padding: EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: backgroundColor,
              decoration: TextDecoration.none),
        ),
      );
}
