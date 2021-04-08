import 'package:flutter/material.dart';

class ThumbnailHolder extends StatelessWidget {
  const ThumbnailHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Placeholder(
                  // TODO: thumbnail here
                  fallbackHeight: 190,
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //TODO: video length here
                      height: 10,
                      width: 20,
                      color: Colors.white,
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
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
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
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      switch (value) {
                        case 'Logout':
                          break;
                        case 'Settings':
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Save to playlist', 'Share'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
