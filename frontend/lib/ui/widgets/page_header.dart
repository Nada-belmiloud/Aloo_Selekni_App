import 'package:flutter/material.dart';
import 'settings_icon.dart';

class PageHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;

  const PageHeader({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      toolbarHeight: 60,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back arrow with correct direction
          IconButton(
            icon: Icon(
              isRTL ? Icons.arrow_back : Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),

        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}