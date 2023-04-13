import 'package:chatgpt/constant/constant.dart';
import 'package:chatgpt/models/model_model.dart';
import 'package:chatgpt/provider/model_provider.dart';
import 'package:chatgpt/services/api_services.dart';
import 'package:chatgpt/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelsDropDown extends StatefulWidget {
  const ModelsDropDown({Key? key}) : super(key: key);

  @override
  State<ModelsDropDown> createState() => _ModelsDropDownState();
}

class _ModelsDropDownState extends State<ModelsDropDown> {
  String? currentModels;

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModels = modelProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
      future: modelProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextWidgets(label: snapshot.error.toString()),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                          value: snapshot.data![index].id,
                          child: TextWidgets(
                            label: snapshot.data![index].id,
                            fontSize: 15,
                          ))),
                  value: currentModels,
                  onChanged: (value) {
                    setState(() {
                      currentModels = value.toString();
                      modelProvider.setCurrentModel(value.toString());
                    });
                  },
                ),
              );
      },
    );
  }
}
/*DropdownButton(
      dropdownColor: scaffoldBackgroundColor,
      iconEnabledColor: Colors.white,
      items: getModelsItem,
      value: currentModels,
      onChanged: (value) {
      setState(() {
        currentModels=value.toString();
      });
    },);*/
