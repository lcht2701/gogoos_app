import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../utils/app_color.dart';

class SearchWithFilter extends StatefulWidget {
  final Function(String) onSearch;
  const SearchWithFilter({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<SearchWithFilter> createState() => _SearchWithFilterState();
}

class _SearchWithFilterState extends State<SearchWithFilter> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      widget.onSearch('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _searchController,
              cursorColor: AppColor.darkColor,
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 24,
                ),
                hintText: 'Search Recipe',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
                suffixIcon: IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(
                    LineAwesomeIcons.times,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.filter_list,
              size: 24,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
