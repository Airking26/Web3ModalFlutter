import 'package:flutter/material.dart';
import 'package:qr_flutter_wc/qr_flutter.dart';

import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/theme/theme.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'package:web3modal_flutter/widgets/miscellaneous/content_loading.dart';
import 'package:web3modal_flutter/widgets/miscellaneous/responsive_container.dart';
import 'package:web3modal_flutter/widgets/web3modal_provider.dart';

class QRCodeWidget extends StatefulWidget {
  const QRCodeWidget({
    super.key,
    this.logoPath = '',
  });

  final String logoPath;

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  IW3MService? _service;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _service = Web3ModalProvider.of(context).service;
      await _service?.rebuildConnectionUri();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_service == null) {
      return const ContentLoading();
    }

    final responsiveData = ResponsiveData.of(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final imageSize = isPortrait ? 90.0 : 60.0;
    return Container(
      constraints: BoxConstraints(
        maxWidth: isPortrait
            ? responsiveData.maxWidth
            : (responsiveData.maxHeight - kNavbarHeight - 32.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kRadiusL),
      ),
      padding: const EdgeInsets.all(16.0),
      child: QrImageView(
        data: _service!.wcUri!,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.Q,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.circle,
          color: Colors.black,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.circle,
          color: Colors.black,
        ),
        embeddedImage: widget.logoPath.isNotEmpty
            ? AssetImage(widget.logoPath, package: 'web3modal_flutter')
            : null,
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(imageSize, imageSize),
        ),
        embeddedImageEmitsError: true,
      ),
    );
  }
}
