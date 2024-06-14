import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/favorites/favorites_bloc.dart';
import 'package:restaurantour/bloc/restaurants/restaurants_bloc.dart';
import 'package:restaurantour/view/restaurant_details.dart';
import 'package:restaurantour/widgets/restaurant_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantsBloc()..add(RestaurantsRequested()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'All Restaurants',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text('Favorites', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<RestaurantsBloc, RestaurantsState>(
              builder: (context, state) {
                if (state is RestaurantLoading) {
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is RestaurantFail) {
                  return const Center(
                    child: Text('No restaurants were found'),
                  );
                }

                if (state is RestaurantSuccess) {
                  return ListView.builder(
                      itemCount: state.restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = state.restaurants.elementAt(index);
                        final isFavorite =
                            state.restaurants.contains(restaurant);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: InkWell(
                            onDoubleTap: () {
                              context.read<FavoritesBloc>().add(
                                    FavoritesNewAdded(
                                      state.restaurants.elementAt(index),
                                    ),
                                  );
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantView(
                                    isFavorite: isFavorite,
                                    restaurant: restaurant,
                                  ),
                                ),
                              );

                              // context.read<FavoritesBloc>().add(
                              //       FavoritesNewAdded(
                              //         state.restaurants.elementAt(index),
                              //       ),
                              //     );
                            },
                            child: RestaurantCard(
                              restaurant: restaurant,
                            ),
                          ),
                        );
                      });
                }

                return const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state.restaurants.isEmpty) {
                  return const Center(
                    child: Text('No restaurants have been added yet'),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final restaurant = state.restaurants.elementAt(index);
                    final isFavorite = state.restaurants.contains(restaurant);

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantView(
                                isFavorite: isFavorite,
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                        child: RestaurantCard(restaurant: restaurant));
                  },
                  itemCount: state.restaurants.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
