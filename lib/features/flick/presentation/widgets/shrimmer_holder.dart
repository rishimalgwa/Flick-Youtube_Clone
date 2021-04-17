import 'package:flick/features/flick/presentation/widgets/thumnail_holder.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerThumbnailHolder extends StatelessWidget {
  const ShimmerThumbnailHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: ThumbnailHolder(),
        baseColor: Colors.white54,
        highlightColor: Colors.grey);
  }
}
