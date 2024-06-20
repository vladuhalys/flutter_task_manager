import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_manager/feature/models/table.dart';
import 'package:get/get.dart';

class DropDawnController extends GetxController {
  final _selectedTableId = 0.obs;
  final _selectedItemText = ''.obs;
  final _selectedItem = const ModelTable.empty().obs;
  final _items = <DropdownMenuItem<ModelTable>>[].obs;

  void setItems(List<ModelTable> items) {
    _items.value = items
        .map((e) => DropdownMenuItem<ModelTable>(
              value: e,
              child: Text(e.tableName),
            ))
        .toList();
    update();
  }

  void setSelectedItemText(String text) {
    _selectedItemText.value = text;
    update();
  }

  void setSelectedTableId(int id) {
    _selectedTableId.value = id;
    update();
  }

  void setSelectedItem(ModelTable item) {
    _selectedItem.value = item;
    update();
  }

  List<DropdownMenuItem<ModelTable>> get getItems => _items;
  int get getSelectedTableId => _selectedTableId.value;
  String get getSelectedItemText => _selectedItemText.value;
  ModelTable get getSelectedItem => _selectedItem.value;
}

class AppDropDawn extends StatelessWidget {
  const AppDropDawn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DropDawnController>(
      builder: (controller) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<ModelTable>(
            isExpanded: true,
            items: controller.getItems,
            value: controller.getSelectedItem,
            onChanged: (value) {
              controller.setSelectedItem(value!);
              controller.setSelectedItemText(value.tableName);
              controller.setSelectedTableId(value.id);
            },
            style: context.theme.textTheme.headlineMedium!.copyWith(
              fontSize: 30,
              color: Colors.blue,
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.all(10),
              height: 75,
            ),
            dropdownStyleData: DropdownStyleData(
             padding: const EdgeInsets.only(left:10),
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  ),
                border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
