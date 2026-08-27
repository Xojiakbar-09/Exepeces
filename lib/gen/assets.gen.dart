// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/inter.ttf
  String get inter => 'assets/fonts/inter.ttf';

  /// List of all assets
  List<String> get values => [inter];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/chaqmo.svg
  String get chaqmo => 'assets/icons/chaqmo.svg';

  /// File path: assets/icons/choy.svg
  String get choy => 'assets/icons/choy.svg';

  /// File path: assets/icons/hamyon.svg
  String get hamyon => 'assets/icons/hamyon.svg';

  /// File path: assets/icons/manu.svg
  String get manu => 'assets/icons/manu.svg';

  /// File path: assets/icons/moshina.svg
  String get moshina => 'assets/icons/moshina.svg';

  /// File path: assets/icons/onbord.svg
  String get onbord => 'assets/icons/onbord.svg';

  /// File path: assets/icons/oqchaqmo.svg
  String get oqchaqmo => 'assets/icons/oqchaqmo.svg';

  /// File path: assets/icons/oqsumka.svg
  String get oqsumka => 'assets/icons/oqsumka.svg';

  /// File path: assets/icons/oquy.svg
  String get oquy => 'assets/icons/oquy.svg';

  /// File path: assets/icons/profile.svg
  String get profile => 'assets/icons/profile.svg';

  /// File path: assets/icons/pul.svg
  String get pul => 'assets/icons/pul.svg';

  /// File path: assets/icons/qogoz.svg
  String get qogoz => 'assets/icons/qogoz.svg';

  /// File path: assets/icons/qorahome.svg
  String get qorahome => 'assets/icons/qorahome.svg';

  /// File path: assets/icons/setting.svg
  String get setting => 'assets/icons/setting.svg';

  /// File path: assets/icons/sumka.svg
  String get sumka => 'assets/icons/sumka.svg';

  /// File path: assets/icons/uchnuq.svg
  String get uchnuq => 'assets/icons/uchnuq.svg';

  /// File path: assets/icons/vilka.svg
  String get vilka => 'assets/icons/vilka.svg';

  /// File path: assets/icons/x.svg
  String get x => 'assets/icons/x.svg';

  /// List of all assets
  List<String> get values => [
    chaqmo,
    choy,
    hamyon,
    manu,
    moshina,
    onbord,
    oqchaqmo,
    oqsumka,
    oquy,
    profile,
    pul,
    qogoz,
    qorahome,
    setting,
    sumka,
    uchnuq,
    vilka,
    x,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

abstract final class Assets {
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
