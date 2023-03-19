import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/screens/widgets/animated/animated_bar.dart';

class Categories extends StatefulWidget {
  final List<String> categories;
  final ValueNotifier<int> categorySelected;
  const Categories(
      {Key? key, required this.categories, required this.categorySelected})
      : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Widget> categories = [];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.categorySelected,
      builder: (BuildContext context, int categorySelected, _) {
        categories = [];
        for (int index = 0; index < widget.categories.length; index++) {
          categories.add(
            GestureDetector(
              onTap: () {
                widget.categorySelected.value = index;
              },
              child: _CategoryItem(
                  name: widget.categories[index],
                  isSelected: index == categorySelected),
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: categories),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View more',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: accentColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  const _CategoryItem({Key? key, required this.name, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? accentColor : null),
          ),
          AnimatedBar(isActive: isSelected),
        ],
      ),
    );
  }
}
