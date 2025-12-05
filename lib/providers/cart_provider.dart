import 'package:application/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super([]);

  void addToMeals(Meal meal) {
    state = [...state, meal];
  }
}

final MealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
  return MealsNotifier();
});
