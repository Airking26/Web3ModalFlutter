import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:web3modal_flutter/pages/qr_code_page.dart';
import 'package:web3modal_flutter/theme/theme.dart';
import 'package:web3modal_flutter/utils/asset_util.dart';
import 'package:web3modal_flutter/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:web3modal_flutter/widgets/miscellaneous/searchbar.dart';

import 'package:walletconnect_modal_flutter/services/explorer/explorer_service_singleton.dart';

class AllWalletsHeader extends StatelessWidget {
  const AllWalletsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Web3ModalTheme.getDataOf(context);
    return Container(
      decoration: BoxDecoration(color: themeData.colors.background125),
      padding: const EdgeInsets.all(kPadding12),
      child: Row(
        children: [
          Expanded(
            child: Web3ModalSearchBar(
              hint: 'Search Wallet',
              onTextChanged: (value) {
                explorerService.instance!.filterList(query: value);
              },
            ),
          ),
          const SizedBox.square(dimension: 12.0),
          IconButton(
            padding: const EdgeInsets.all(0.0),
            visualDensity: VisualDensity.compact,
            onPressed: () {
              widgetStack.instance.add(const QRCodePage());
            },
            icon: SvgPicture.asset(
              AssetUtil.getThemedAsset(context, 'qr_code.svg'),
              package: 'web3modal_flutter',
              width: kSearchFieldHeight,
              height: kSearchFieldHeight,
            ),
          ),
        ],
      ),
    );
  }
}