import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: SkeletonAnimation(
              child: Container(
                width: 300,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
          for (int i = 0; i < 3; i++) // Quantidade de Skeleton Cards
            Card(
              elevation: 8,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SkeletonAnimation(
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SkeletonAnimation(
                      child: Container(
                        width: 100,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    SkeletonAnimation(
                      child: Container(
                        width: 150,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SkeletonAnimation(
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
