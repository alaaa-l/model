import 'package:application/providers/all_meals_provider.dart';
import 'package:application/providers/cart_provider.dart';
import 'package:application/providers/favorites_provider.dart';
import 'package:application/providers/rating_provider.dart';
import 'package:flutter/material.dart';
import 'package:application/models/meal.dart';
import 'package:application/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetails extends ConsumerStatefulWidget {
  const MealDetails({super.key});

  @override
  ConsumerState<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends ConsumerState<MealDetails> {
  final Map<Category, String> map = {
    Category.healthyLife: 'Healthy Life',
    Category.asian: 'Asian',
    Category.fastFood: 'Fast Food',
  };

  @override
  Widget build(BuildContext context) {
    final allMeals = ref.watch(allmealsProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(dummy_data[0]);
    final meals = ref.watch(MealsProvider);
    final rating = ref.watch(RatingProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          247,
                          218,
                          175,
                        ).withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 6,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(child: Icon(Icons.close, color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dummy_data[0].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    map[Category.healthyLife]!,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 246, 227, 18),
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          final isFilled = index < rating;

                          return GestureDetector(
                            onTap: () {
                              ref.read(RatingProvider.notifier).state =
                                  index + 1;
                            },
                            child: Icon(
                              Icons.star,
                              size: 20,
                              color: isFilled
                                  ? Colors.orange
                                  : Color.fromARGB(255, 216, 212, 212),
                            ),
                          );
                        }),
                      ),
                      Text('(' + rating.toString() + ')'),
                    ],
                  ),

                  Text(
                    '\$ ' + dummy_data[0].price.toStringAsFixed(2),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 234, 208),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    ref
                        .read(favoriteMealsProvider.notifier)
                        .toggleMealFavoriteStatus(dummy_data[0]);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
          '   Description',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 7),

        Text(
          '   ${dummy_data[0].description}', //i belive i shouldn't adjust this by adding spaces to the string, it should be adjusted by using widgets in flutter like padding()
          style: TextStyle(color: Colors.grey, fontSize: 22),
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Similar Items',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 156, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: const Color.fromARGB(
                              255,
                              255,
                              156,
                              0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(8),
                    itemCount: allMeals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(right: 18),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(MealsProvider.notifier)
                                      .addToMeals(dummy_data[0]);
                                },
                                child: Container(
                                  width: 35.65,
                                  height: 35.65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Color.fromARGB(255, 255, 156, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Out of Stock',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
