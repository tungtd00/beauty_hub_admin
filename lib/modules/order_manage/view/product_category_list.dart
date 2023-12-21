import 'package:flutter/material.dart';

import '../../../models/category.dart';

class ProductCategoryList extends StatefulWidget {
  final List<Category> categories;
  final List<Category>? productCategories;
  final Function(List<Category>) onChoose;

  const ProductCategoryList({
    super.key,
    required this.categories,
    required this.onChoose,
    this.productCategories,
  });

  @override
  State<ProductCategoryList> createState() => _ProductCategoryListState();
}

class _ProductCategoryListState extends State<ProductCategoryList> {
  List<Category> productCategoryList = [];
  List<Category> chooseCategoryList = [];

  @override
  void initState() {
    productCategoryList = widget.categories;
    chooseCategoryList = widget.productCategories ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
            text: const TextSpan(
                text: 'Sản phẩm của bạn thuộc nhóm nào ? ',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
              TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ))
            ])),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 4.0,
          children: productCategoryList
              .map((e) => InkWell(
                    onTap: () {
                      setState(() {
                        chooseCategoryList.add(e);
                        widget.onChoose(chooseCategoryList);
                      });
                    },
                    child: chooseCategoryList.contains(e)
                        ? Chip(
                            backgroundColor: Colors.green,
                            label: Text(
                              e.name,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onDeleted: () {
                              setState(() {
                                chooseCategoryList.remove(e);
                              });
                            },
                            deleteIconColor: Colors.white,
                          )
                        : Chip(
                            label: Text(e.name),
                            deleteIcon: const SizedBox(),
                            onDeleted: () {},
                          ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
