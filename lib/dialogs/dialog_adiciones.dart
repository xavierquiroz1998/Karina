import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:tesis_karina/entity/detalle_planificacion.dart';
import 'package:tesis_karina/entity/insumo.dart';
import 'package:tesis_karina/entity/maquinaria.dart';
import 'package:tesis_karina/entity/personas.dart';
import 'package:tesis_karina/provider/task_provider.dart';

Future<bool> dialogAdiciones(
    BuildContext context, TaskProvider provider) async {
  bool op = false;

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_box_rounded,
                        color: Colors.blueGrey[700], size: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("AGREGAR INSUMO/MAQUINARIA/PERSONAL",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: provider.valueI,
                      onChanged: (value) {
                        setState(() {
                          provider.valueI = value!;
                        });
                      },
                    ),
                    const Text("Insumo",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Checkbox(
                      value: provider.valueM,
                      onChanged: (value) {
                        setState(() {
                          provider.valueM = value!;
                        });
                      },
                    ),
                    const Text("Maqui",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Checkbox(
                      value: provider.valueP,
                      onChanged: (value) {
                        setState(() {
                          provider.valueP = value!;
                        });
                      },
                    ),
                    const Text("Personal",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ],
                ),
                if (provider.valueP)
                  Row(
                    children: [
                      const SizedBox(
                          width: 80,
                          child: Text("Personas",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))),
                      Expanded(
                        child: DropdownSearch<Persona>.multiSelection(
                          items: provider.listPersonas,
                          compareFn: (i, s) => i.isEqual(s),
                          onChanged: (value) {
                            provider.listPersonasSelect = value;
                          },
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            showSearchBox: true,
                            itemBuilder: _customPopupItemBuilderPersona,
                            favoriteItemProps: FavoriteItemProps(
                              showFavoriteItems: true,
                              favoriteItems: (us) {
                                return us
                                    .where((e) => e.nombre.contains("Mrs"))
                                    .toList();
                              },
                              favoriteItemBuilder: (context, item, isSelected) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        item.nombre,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.indigo),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 8)),
                                      isSelected
                                          ? const Icon(Icons.check_box_outlined)
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (provider.valueI)
                  Row(
                    children: [
                      const SizedBox(
                          width: 80,
                          child: Text("Insumos",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))),
                      Expanded(
                        child: DropdownSearch<Insumos>.multiSelection(
                          items: provider.listInsumo,
                          compareFn: (i, s) => i.isEqual(s),
                          onChanged: (value) {
                            provider.listInsumoSelect = value;
                          },
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            showSearchBox: true,
                            itemBuilder: _customPopupItemBuilderInsumos,
                            favoriteItemProps: FavoriteItemProps(
                              showFavoriteItems: true,
                              favoriteItems: (us) {
                                return us
                                    .where((e) => e.nombre.contains("Mrs"))
                                    .toList();
                              },
                              favoriteItemBuilder: (context, item, isSelected) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        item.nombre,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 8)),
                                      isSelected
                                          ? Icon(Icons.check_box_outlined)
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (provider.valueM)
                  Row(
                    children: [
                      const SizedBox(
                          width: 80,
                          child: Text("Maquinarias",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))),
                      Expanded(
                        child: DropdownSearch<Maquinaria>.multiSelection(
                          items: provider.listMaquinarias,
                          compareFn: (i, s) => i.isEqual(s),
                          onChanged: (value) {
                            provider.listMaquinariasSelect = value;
                          },
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            showSearchBox: true,
                            itemBuilder: _customPopupItemBuilderMaquinarias,
                            favoriteItemProps: FavoriteItemProps(
                              showFavoriteItems: true,
                              favoriteItems: (us) {
                                return us
                                    .where((e) => e.nombre.contains("Mrs"))
                                    .toList();
                              },
                              favoriteItemBuilder: (context, item, isSelected) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        item.nombre,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 8)),
                                      isSelected
                                          ? Icon(Icons.check_box_outlined)
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            actions: [
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.black12;
                    }
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    op = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar', style: TextStyle(fontSize: 14))),
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.black12;
                    }
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    op = false;
                    Navigator.of(context).pop();
                  },
                  child:
                      const Text('Cancelar', style: TextStyle(fontSize: 14))),
            ],
          );
        });
      });
  return op;
}

Widget _customPopupItemBuilderPersona(
  BuildContext context,
  Persona? item,
  bool isSelected,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.nombre ?? ''),
    ),
  );
}

Widget _customPopupItemBuilderMaquinarias(
  BuildContext context,
  Maquinaria? item,
  bool isSelected,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.nombre ?? ''),
    ),
  );
}

Widget _customPopupItemBuilderInsumos(
  BuildContext context,
  Insumos? item,
  bool isSelected,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.nombre ?? ''),
    ),
  );
}
