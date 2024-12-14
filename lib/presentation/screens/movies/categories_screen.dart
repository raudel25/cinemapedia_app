import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  static const name = 'categories-screen';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            // title: CustomAppBar(),
            titlePadding: EdgeInsets.zero,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (context, index) => Column(
                      children: [],
                    )))
      ],
    );
  }
}
