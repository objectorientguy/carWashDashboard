import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
          totalPages,
          (index) => InkWell(
            onTap: () => onPageChanged(index + 1),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color:
                    (currentPage == index + 1) ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color:
                      (currentPage == index + 1) ? Colors.white : Colors.black,
                  fontWeight: (currentPage == index + 1)
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
