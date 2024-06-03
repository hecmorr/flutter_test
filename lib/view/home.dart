import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/bloc/favorites/favorites_bloc.dart';
import 'package:restaurantour/bloc/restaurants/restaurants_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantsBloc()..add(RestaurantsRequested()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
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
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('All Restaurants'),
              ),
              Tab(
                child: Text('Favorites'),
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (context, state) {
              if (state is RestaurantLoading) {
                return const Center(
                  child: SizedBox(
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
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
                  itemBuilder: (context, index) => InkWell(
                    child: Text(state.restaurants.elementAt(index).name!),
                    onTap: () {
                      context.read<FavoritesBloc>().add(
                            FavoritesNewAdded(
                              state.restaurants.elementAt(index),
                            ),
                          );
                    },
                  ),
                );
              }

              return const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
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
                itemBuilder: (context, index) =>
                    Text(state.restaurants.elementAt(index).name!),
                itemCount: state.restaurants.length,
              );
            },
          )
        ]),
      ),
    );
  }
}
