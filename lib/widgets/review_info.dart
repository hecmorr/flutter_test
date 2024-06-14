import 'package:flutter/material.dart';

class ReviewInfo extends StatelessWidget {
  const ReviewInfo({
    Key? key,
    required this.userPhoto,
    required this.username,
  }) : super(key: key);

  final String userPhoto;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reviews'),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              height: 40,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userPhoto),
              ),
            ),
            const SizedBox(width: 20),
            Text(username),
          ],
        ),
      ],
    );
  }
}
