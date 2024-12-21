import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_func/core/theme/my_theme.dart';
import '../../viewmodels/filter_viewmodel.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({super.key});

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  // Biến lưu tạm thời bộ lọc
  String tempSelectedLocation = "";
  String tempSelectedTime = "";
  String tempSelectedCategory = "";

  final List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.sports_basketball,
      "label": "Sports",
      "id": "6723279cc3a82cebab0e4e8e"
    },
    {
      "icon": Icons.music_note,
      "label": "Music",
      "id": "672327aec3a82cebab0e4e94"
    },
    {"icon": Icons.brush, "label": "Art", "id": "6729ce47282459d66e9e9c13"},
    {
      "icon": Icons.restaurant,
      "label": "Food",
      "id": "67232787c3a82cebab0e4e8c"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 27, 27, 31),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() => tempSelectedCategory = category['id']);
                  },
                  child: _buildCategoryIcon(
                    category['icon'],
                    category['label'],
                    isSelected: tempSelectedCategory == category['id'],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Time Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeButton('Today', 'today'),
                _buildTimeButton('Tomorrow', 'tomorrow'),
                _buildTimeButton('This week', 'this_week'),
              ],
            ),
            const SizedBox(height: 30),

            // Location Input
            TextField(
              decoration: InputDecoration(
                hintText: "Location",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) => tempSelectedLocation = value,
            ),
            const SizedBox(height: 50),

            // Apply Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Provider.of<FilterViewModel>(context, listen: false)
                    .fetchFilteredEvents(
                  categoryId: tempSelectedCategory,
                  dateOption: tempSelectedTime,
                  location: tempSelectedLocation,
                );
                Navigator.of(context).pop();
              },
              child: Text(
                'APPLY',
                style: AppTextStyles.subheading,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label,
      {bool isSelected = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: isSelected
              ? MyTheme.primaryColor
              : const Color.fromARGB(255, 255, 255, 255),
          child: Icon(icon,
              size: 30,
              color: isSelected ? Colors.white : MyTheme.primaryColor),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.subheading,
        ),
      ],
    );
  }

  Widget _buildTimeButton(String label, String value) {
    return OutlinedButton(
      onPressed: () => setState(() => tempSelectedTime = value),
      style: OutlinedButton.styleFrom(
        backgroundColor:
            tempSelectedTime == value ? MyTheme.primaryColor : Colors.white,
        foregroundColor:
            tempSelectedTime == value ? Colors.white : Colors.black,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
