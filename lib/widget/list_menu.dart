import 'package:flutter/material.dart';

class PageListTile extends StatelessWidget {
  const PageListTile({
    Key? key,
    this.selectedPageName,
    required this.pageName,
    this.onPressed,
  }) : super(key: key);
  final String? selectedPageName;
  final String pageName;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color:
              Colors.amber.withOpacity(selectedPageName == pageName ? 0.5 : 0)),
      child: ListTile(
        // show a check icon if the page is currently selected
        // note: we use Opacity to ensure that all tiles have a leading widget
        // and all the titles are left-aligned
        leading: Opacity(
          opacity: selectedPageName == pageName ? 1.0 : 0.0,
          child: const Icon(Icons.check),
        ),
        title: Text(pageName),
        onTap: onPressed,
      ),
    );
  }
}
