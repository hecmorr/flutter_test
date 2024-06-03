import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../models/restaurant.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<FavoritesNewAdded>((event, emit) {
      final restaurant = event.restaurant;
      emit(FavoritesState(restaurants: [...state.restaurants, restaurant]));
    });
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) =>
      FavoritesState.fromJson(json);

//  Actual state
  @override
  Map<String, dynamic>? toJson(FavoritesState state) => state.toJson();
}
