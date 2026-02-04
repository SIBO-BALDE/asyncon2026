import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';


class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  final _formkey = GlobalKey<FormState>();
  final confNameController = TextEditingController();
  final confNameSpeakerController = TextEditingController();
  String selectedType = 'Takk';
  DateTime selectedConfDate = DateTime.now();

  @override
  void dispose() {
    confNameController.dispose();
    confNameSpeakerController.dispose();
    super.dispose();
  }

  Future<void> saveEvent() async {
    try {
      final confName = confNameController.text;
      final speakerName = confNameSpeakerController.text;

      // Ajout dans la base de données
      CollectionReference collectRef = FirebaseFirestore.instance.collection("Events");

      await collectRef.add({
        'speaker': speakerName,
        'date': Timestamp.fromDate(selectedConfDate),
        'subject': confName,
        'type': selectedType,
        'avatar': 'lior',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Événement ajouté avec succès !"),
              backgroundColor: Colors.green,
            )
        );

        // Réinitialiser le formulaire
        confNameController.clear();
        confNameSpeakerController.clear();
        setState(() {
          selectedType = 'Takk';
          selectedConfDate = DateTime.now();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erreur : $e"),
              backgroundColor: Colors.red,
            )
        );
      }
      print("Erreur lors de l'ajout : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nom conference",
                    hintText: "Entrer le nom",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Champ vide";
                    }
                    return null;
                  },
                  controller: confNameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nom du speaker",
                    hintText: "Entrer le nom du speaker",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Champ vide";
                    }
                    return null;
                  },
                  controller: confNameSpeakerController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(value:'Takk', child: Text("Talk show")),
                      DropdownMenuItem(value:'Demo', child: Text("Demo code")),
                      DropdownMenuItem(value:'Partener', child: Text("Partener")),
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder()
                    ),
                    value: selectedType,
                    onChanged: (value){
                      setState(() {
                        selectedType = value!;
                      });
                    }
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: 'Entrer la date',
                    border: OutlineInputBorder(),
                  ),
                  firstDate: DateTime.now().add(const Duration(days: 10)),
                  lastDate: DateTime.now().add(const Duration(days: 40)),
                  initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                  onChanged: (DateTime? value) {
                    selectedConfDate = value!;
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      if(_formkey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Envoi en cours ..."))
                        );

                        await saveEvent();
                      }
                    },
                    child: const Text("Envoyer")
                ),
              )
            ],
          )
      ),
    );
  }
}