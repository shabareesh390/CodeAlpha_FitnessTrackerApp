import 'package:flutter/material.dart';
import 'package:flutter_daily_fitness_app_ui/common/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> _workoutTypes = ["Cardio", "Strength", "Yoga", "HIIT", "Pilates"];
  final List<String> _difficultyLevels = ["Beginner", "Intermediate", "Advanced"];
  
  final Set<String> _selectedWorkouts = {};
  final Set<String> _selectedDifficulties = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filters",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            
            // Workout Type
            Text(
              "Workout Type",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _workoutTypes.map((type) {
                final isSelected = _selectedWorkouts.contains(type);
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedWorkouts.add(type);
                      } else {
                        _selectedWorkouts.remove(type);
                      }
                    });
                  },
                  selectedColor: ColorConstants.kDaysColor,
                  labelStyle: GoogleFonts.inter(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  backgroundColor: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  showCheckmark: false,
                );
              }).toList(),
            ),
            
            const SizedBox(height: 40),
            
            // Difficulty Level
            Text(
              "Difficulty",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _difficultyLevels.map((level) {
                final isSelected = _selectedDifficulties.contains(level);
                return ChoiceChip(
                  label: Text(level),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDifficulties.add(level);
                      } else {
                        _selectedDifficulties.remove(level);
                      }
                    });
                  },
                  selectedColor: ColorConstants.kDaysColor,
                  labelStyle: GoogleFonts.inter(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  backgroundColor: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  showCheckmark: false,
                );
              }).toList(),
            ),
            
            const Spacer(),
            
            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filters Applied successfully!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.kDaysColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100), // Padding for bottom nav
          ],
        ),
      ),
    );
  }
}
