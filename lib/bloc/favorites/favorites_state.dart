part of 'favorites_bloc.dart';

@JsonSerializable()
class FavoritesState extends Equatable {
  const FavoritesState({this.restaurants = const []});
  final List<Restaurant> restaurants;

  factory FavoritesState.fromJson(Map<String, dynamic> json) {
    return FavoritesState(restaurants: json['restaurants']);
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurants': restaurants,
    };
  }

  @override
  List<Object> get props => [restaurants];
}
