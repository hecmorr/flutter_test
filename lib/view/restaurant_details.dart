import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/favorites/favorites_bloc.dart';
import 'package:restaurantour/widgets/widgets.dart';

import '../models/restaurant.dart';

class RestaurantView extends StatelessWidget {
  final Restaurant restaurant;
  final bool isFavorite;

  const RestaurantView({
    Key? key,
    required this.restaurant,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    restaurant.name!,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<FavoritesBloc>()
                      .add(FavoritesNewAdded(restaurant));
                  print(isFavorite);
                },
                child: Icon(
                  isFavorite ? Icons.favorite_border : Icons.favorite,
                  color: isFavorite ? Colors.black : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Image.network(
              restaurant.heroImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(restaurant.displayCategory),
                Row(
                  children: [
                    const Text('Open now'),
                    SizedBox(
                      height: 10,
                      child: CircleAvatar(
                        backgroundColor:
                            restaurant.isOpen ? Colors.green : Colors.red,
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Overall Rating'),
          const SizedBox(height: 20),
          Text(restaurant.rating.toString()),
          const SizedBox(height: 20),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewInfo(
                        userPhoto: restaurant.reviews!.first.user!.imageUrl ??
                            'https://louisville.edu/history/images/noimage.jpg/image',
                        username: restaurant.reviews!.first.user!.name!),
                    const SizedBox(height: 20),
                    ReviewInfo(
                        userPhoto: restaurant.reviews!.first.user!.imageUrl ??
                            'https://louisville.edu/history/images/noimage.jpg/image',
                        username: restaurant.reviews!.first.user!.name!),
                    const SizedBox(height: 20),
                    ReviewInfo(
                        userPhoto: restaurant.reviews!.first.user!.imageUrl ??
                            'https://louisville.edu/history/images/noimage.jpg/image',
                        username: restaurant.reviews!.first.user!.name ??
                            'https://louisville.edu/history/images/noimage.jpg/image'),
                    const SizedBox(height: 20),
                    ReviewInfo(
                        userPhoto: restaurant.reviews!.first.user!.imageUrl ??
                            'https://louisville.edu/history/images/noimage.jpg/image',
                        username: restaurant.reviews!.first.user!.name ??
                            'https://louisville.edu/history/images/noimage.jpg/image'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
