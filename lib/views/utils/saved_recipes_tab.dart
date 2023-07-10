import 'package:flutter/material.dart';
import 'package:gogoos_app/controllers/user_controller.dart';
import 'package:gogoos_app/views/widgets/tab_item.dart';

class SavedRecipesTab extends StatelessWidget {
  const SavedRecipesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return TabItem(
      future: UserController().getSavedRecipes(),
    );
  }
}
