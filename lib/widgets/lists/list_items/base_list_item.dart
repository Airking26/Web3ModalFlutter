import 'package:flutter/material.dart';
import 'package:web3modal_flutter/theme/w3m_theme.dart';

class BaseListItem extends StatelessWidget {
  const BaseListItem({
    super.key,
    this.trailing,
    this.onTap,
    required this.child,
  });
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeData = Web3ModalTheme.getDataOf(context);
    return FilledButton(
      onPressed: onTap,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(1000.0, kListItemHeight),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          themeData.colors.overgray002,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          themeData.colors.overgray005,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusXS),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
