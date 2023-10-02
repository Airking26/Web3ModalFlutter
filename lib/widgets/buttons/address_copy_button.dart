import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:web3modal_flutter/theme/w3m_theme.dart';
import 'package:web3modal_flutter/widgets/web3modal_provider.dart';
import 'package:web3modal_flutter/widgets/text/w3m_address.dart';

import 'package:walletconnect_modal_flutter/services/utils/toast/toast_message.dart';
import 'package:walletconnect_modal_flutter/services/utils/toast/toast_utils_singleton.dart';

class W3MAddressWithCopyButton extends StatelessWidget {
  const W3MAddressWithCopyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Web3ModalProvider.of(context).service;
    final themeData = Web3ModalTheme.getDataOf(context);
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: service.address!));
        toastUtils.instance.show(
          ToastMessage(
            type: ToastType.info,
            text: 'Address copied',
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          W3MAddress(
            service: service,
            style: themeData.textStyles.title700.copyWith(
              color: themeData.colors.foreground100,
            ),
          ),
          const SizedBox.square(dimension: 8.0),
          SvgPicture.asset(
            'assets/icons/copy.svg',
            package: 'web3modal_flutter',
            colorFilter: ColorFilter.mode(
              themeData.colors.foreground250,
              BlendMode.srcIn,
            ),
            width: 20.0,
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
