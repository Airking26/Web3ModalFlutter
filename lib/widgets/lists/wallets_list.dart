import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:web3modal_flutter/models/grid_item.dart';
import 'package:web3modal_flutter/theme/constants.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:web3modal_flutter/widgets/lists/list_items/wallet_item_chip.dart';
import 'package:web3modal_flutter/widgets/lists/list_items/wallet_list_item.dart';
import 'package:web3modal_flutter/widgets/web3modal_provider.dart';

class WalletsList extends StatelessWidget {
  const WalletsList({
    super.key,
    required this.itemList,
    this.firstItem,
    this.bottomItems = const [],
    this.onTapWallet,
    this.isLoading = false,
  });
  final List<GridItem<W3MWalletInfo>> itemList;
  final Widget? firstItem;
  final List<Widget> bottomItems;
  final Function(W3MWalletInfo walletInfo)? onTapWallet;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final themeColors = Web3ModalTheme.colorsOf(context);
    final loadingList = [
      const WalletListItem(title: ''),
      const WalletListItem(title: ''),
      const WalletListItem(title: ''),
      const WalletListItem(title: ''),
      const WalletListItem(title: ''),
    ].map(
      (e) => Shimmer.fromColors(
        baseColor: themeColors.grayGlass100,
        highlightColor: themeColors.grayGlass025,
        child: e,
      ),
    );

    final walletsListItems = isLoading
        ? loadingList
        : itemList.map(
            (e) => WalletListItem(
              onTap: () => onTapWallet?.call(e.data),
              showCheckmark: e.data.installed,
              imageUrl: e.image,
              title: e.title,
              trailing: e.data.recent
                  ? const WalletItemChip(value: ' RECENT ')
                  : null,
            ),
          );
    final List<Widget> items = List<Widget>.from(walletsListItems);
    if (firstItem != null) {
      items.insert(0, firstItem!);
    }
    if (bottomItems.isNotEmpty) {
      items.addAll(bottomItems);
      items.add(
        TextButton(
          onPressed: Web3ModalProvider.of(context).service.loginWithoutWallet,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              "Login without wallet",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                decoration: TextDecoration.none,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding12,
        vertical: kPadding12,
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 1000.0,
          child: items[index],
        );
      },
      separatorBuilder: (_, index) => SizedBox.square(
        dimension: index == 0 ? 0.0 : kListViewSeparatorHeight,
      ),
      itemCount: items.length,
    );
  }
}
