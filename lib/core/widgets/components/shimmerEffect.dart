import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerContainer extends StatelessWidget {
  final double width;
  final double height;

  CustomShimmerContainer({super.key,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      // Base shimmer color
      highlightColor: Colors.white,
      // Highlight shimmer color
      direction: ShimmerDirection.ltr,
      // Shimmer direction (left to right)
      period: Duration(seconds: 1),
      // Shimmer speed
      child: Container(
        width: width, // Width set to 15
        height: height, // Height set to 15
        decoration: BoxDecoration(
          color: Colors.grey[300], // Background color of the container
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
      ),
    );
    ;
  }
}


class DetailPageShimmer extends StatelessWidget {
  const DetailPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // Top image shimmer
            // Shimmer.fromColors(
            //   baseColor: Colors.grey.shade300,
            //   highlightColor: Colors.grey.shade100,
            //   child: Container(
            //     height: 250,
            //     width: double.infinity,
            //     color: Colors.white,
            //   ),
            // ),
            //
            // const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 20,
                      width: 200,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 16,
                      width: 150,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description shimmer (multiple lines)
                  Column(
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 14,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),

                  // Button shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

    );
  }
}


class ListShimmerLoader extends StatelessWidget {
  final int itemCount;
  final double itemHeight;

  const ListShimmerLoader({
    super.key,
    this.itemCount = 10,
    this.itemHeight = 80,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}


class GridShimmerLoader extends StatelessWidget {
  final int itemCount;

  const GridShimmerLoader({
    super.key,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 👈 2 items per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1, // 👈 square shape
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15), // 👈 radius 15
            ),
          ),
        );
      },
    );
  }
}
class GridShimmerLoader2 extends StatelessWidget {
  final int itemCount;

  const GridShimmerLoader2({
    super.key,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: itemCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 👈 2 items per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1, // 👈 square shape
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15), // 👈 radius 15
            ),
          ),
        );
      },
    );
  }
}