import 'package:flutter/material.dart';

Future<void> showEditFieldDialog({
  required BuildContext context,
  required String title,
  required String initialValue,
  required Future<void> Function(String newValue) onSave,
}) async {
  final controller = TextEditingController(text: initialValue);
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('Edit $title'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: title),
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: isLoading ? null : () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      setState(() => isLoading = true);
                      try {
                        await onSave(controller.text.trim());
                        if (context.mounted) Navigator.pop(context);
                      } catch (e) {
                        setState(() => isLoading = false);
                        // Error already shown in onSave, no need to show again
                      }
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
    ),
  );
}