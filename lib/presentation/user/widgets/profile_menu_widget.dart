import 'package:flutter/material.dart';
import 'package:workerr_app/core/colors.dart';

class ProfileMenuWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textColor;

  bool isSwitch;

  ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.isSwitch = false,
    required this.onpress,
    this.endIcon = true,
    this.textColor = kc60,
  }) : super(key: key);

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onpress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: kc60,
        ),
        child: Icon(
          widget.icon,
          size: 26,
          color: kc30,
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(color: widget.textColor, fontSize: 20),
      ),
      trailing: widget.endIcon
          ? Padding(
              padding: EdgeInsets.only(right: (widget.isSwitch) ? 0 : 25),
              child: Container(
                width: widget.isSwitch ? 80 : 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: widget.isSwitch
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                ),
                child: widget.isSwitch
                    ? Switch(
                        splashRadius: 5,
                        value: _switchValue,
                        onChanged: (bool value) {
                          setState(() {
                            _switchValue = value;
                          });
                        })
                    : const Icon(
                        Icons.chevron_right_outlined,
                        size: 30,
                        color: kc10,
                      ),
              ),
            )
          : null,
    );
  }
}
