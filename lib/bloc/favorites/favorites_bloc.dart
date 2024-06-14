import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../models/restaurant.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<FavoritesNewAdded>
        // (_onFavoriteNewsAdded);
        // on<FavoritesNewAdded>(_onFavoriteNewsRemoved);
        ((event, emit) {
      final restaurant = event.restaurant;
      final index = state.restaurants.indexOf(restaurant);
      final restaurants = [...state.restaurants];
      if (index < 0) {
        restaurants.add(restaurant);
      } else {
        restaurants.removeAt(index);
      }
      emit(FavoritesState(restaurants: restaurants));
    });
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) =>
      FavoritesState.fromJson(json);

//  Actual state
  @override
  Map<String, dynamic>? toJson(FavoritesState state) => state.toJson();
}
