part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class FavoritesNewAdded extends FavoritesEvent {
  const FavoritesNewAdded(this.restaurant);

  final Restaurant restaurant;

  @override
  List<Object> get props => [restaurant];
}
