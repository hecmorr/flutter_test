import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    restaurant.heroImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? 'name restaurant',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      restaurant.displayCategory,
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.star),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Open now'),
                            const SizedBox(width: 4),
                            SizedBox(
                              height: 10,
                              width: 10,
                              child: CircleAvatar(
                                backgroundColor:
                                    restaurant.hours!.first.isOpenNow!
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
