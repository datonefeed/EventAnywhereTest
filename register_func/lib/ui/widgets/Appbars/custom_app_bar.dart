import 'package:go_router/go_router.dart';
import 'package:register_func/core/constants/app_routers.dart';
import 'package:register_func/core/theme/my_theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Current Location",
                    style: TextStyle(color: MyTheme.white.withOpacity(0.6)),
                  ),
                  Icon(Icons.arrow_drop_down, color: MyTheme.white)
                ],
              ),
              Text(
                "Da Nang, Viet Nam",
                style: TextStyle(color: MyTheme.white),
              )
            ],
          ),
        ),
        InkWell(
            onTap: () {
              context.go('/notification');
            },
            child:
                Image(image: AssetImage("assets/icons/ic_notification.png"))),
      ],
    );
  }
}
