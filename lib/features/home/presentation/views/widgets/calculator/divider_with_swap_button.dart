import 'package:flutter/material.dart';

import 'currency_swap_button.dart';

class DividerWithSwapButton extends StatelessWidget {
  const DividerWithSwapButton({super.key, this.onSwapPressed});

  final VoidCallback? onSwapPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Divider(color: Color(0xffE7E7EE)),
        PositionedDirectional(
          top: -13,
          child: CurrencySwapButton(onPressed: onSwapPressed),
        ),
      ],
    );
  }
}
