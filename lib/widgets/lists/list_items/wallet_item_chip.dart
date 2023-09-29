import 'package:flutter/material.dart';
import 'package:web3modal_flutter/theme/theme.dart';

class WalletItemChip extends StatelessWidget {
  const WalletItemChip({
    super.key,
    required this.value,
    this.color,
    this.textStyle,
  });
  final String value;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final themeData = Web3ModalTheme.getDataOf(context);
    return Container(
      decoration: BoxDecoration(
        color: color ?? themeData.colors.overgray010,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(right: 8.0),
      child: Text(
        value,
        style: textStyle ??
            themeData.textStyles.micro700.copyWith(
              color: themeData.colors.foreground150,
            ),
      ),
    );
  }
}