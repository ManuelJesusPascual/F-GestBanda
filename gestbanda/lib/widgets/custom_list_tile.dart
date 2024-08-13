import 'package:flutter/material.dart';
import '../utils/string_utilites.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.text,
    this.dateCreated,
    this.dateEnd,
    this.ca = false,
    this.editButtons = false,
    this.textColor,
    this.onEdit,
    this.onDelete,
  });

  final bool? ca;
  final bool? editButtons;
  final String text;
  final DateTime? dateCreated;
  final DateTime? dateEnd;
  final Color? textColor;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            blurRadius: 1.0,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (ca ?? false)
            CircleAvatar(
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(getInitials(text)),
            ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Theme.of(context).colorScheme.onSurface,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (dateCreated != null && dateEnd != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "${formatDateTime(dateCreated!, "dd/MM/yy")} - ${formatDateTime(dateEnd!, "dd/MM/yy")}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (editButtons ?? false)
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onEdit ?? () {},
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: onDelete ?? () {},
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
