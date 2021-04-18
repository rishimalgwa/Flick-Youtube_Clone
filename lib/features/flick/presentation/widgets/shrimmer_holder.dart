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
      baseColor: Colors.white54,
      highlightColor: Colors.grey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Placeholder(
                    fallbackHeight: 190,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.white54,
                        highlightColor: Colors.grey,
                        child: Container(
                          height: 10,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.black26,
                padding: const EdgeInsets.all(8),
                height: 60,
                child: Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.white54,
                      highlightColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text('Title'),
                        Row(
                          children: [
                            Text('chanel name'),
                            SizedBox(width: 7),
                            CircleAvatar(
                              radius: 1,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 7),
                            Text('views'),
                            SizedBox(width: 7),
                            CircleAvatar(
                              radius: 1,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 7),
                            Text('year'),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
