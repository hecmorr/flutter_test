part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsState {}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantLoading extends RestaurantsState {}

class RestaurantSuccess extends RestaurantsState {
  final List<Restaurant> restaurants;

  RestaurantSuccess({required this.restaurants});
}

class RestaurantFail extends RestaurantsState {}
