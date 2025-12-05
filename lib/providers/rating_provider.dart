import 'package:application/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RatingNotifier extends StateNotifier<int> {
  RatingNotifier() : super(0);
}

final RatingProvider = StateNotifierProvider<RatingNotifier, int>((ref) {
  return RatingNotifier();
});
