import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final yelpRepo = YelpRepository();
  RestaurantsBloc() : super(RestaurantsInitial()) {
    on<RestaurantsRequested>((event, emit) async {
      try {
        final result = await yelpRepo.getRestaurants();
        if (result != null) {
          emit(RestaurantSuccess(restaurants: result.restaurants!));
        } else {
          throw Exception('No restaurants were found');
        }
      } catch (e) {
        print('Este es el error: $e');
        emit(RestaurantFail());
      }
    });
  }
}
