import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cam_1/reminder/global_bloc.dart';
import 'package:test_cam_1/reminder/medicine.dart';
import 'package:test_cam_1/reminder/medicine_details.dart';
import 'package:test_cam_1/reminder/new_entry.dart';

class reminder_screen extends StatelessWidget {
  const reminder_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
            ),
            centerTitle: false,
            title: const Text(
              'Back',
              style: TextStyle(color: Colors.black),
            )),
        body: Padding(
          //roof
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: const [
              top_container(),
              Flexible(child: bottom_container()),
            ],
          ),
        ),
        floatingActionButton: InkResponse(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SafeArea(
                          child: new_entry(),
                        )));
            // Navigator.pop(context)
          },
          child: SizedBox(
            width: 70,
            height: 70,
            child: Card(
              color: Colors.blue,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20)
                  // BorderRadius.circular(40)
                  ),
              // ignore: prefer_const_constructors
              child: Icon(
                Icons.add_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class top_container extends StatelessWidget {
  const top_container({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Worry less.\nlive better.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Your dose',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            })
      ],
    );
  }
}

class bottom_container extends StatelessWidget {
  const bottom_container({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder(
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Medicine',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        } else {
          return
           GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MedicineCard(
                  medicine: snapshot.data![index],
                );
              });
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.medicine});
  final Medicine medicine;

  Hero makeIcon() {
    if (medicine.medicineType == 'bottle') {
      return Hero(
          tag: medicine.medicineName! + medicine.medicineType!,
          child: Image.asset('lib/counter/bottle1.png'));
    }

    if (medicine.medicineType == 'injection') {
      return Hero(
          tag: medicine.medicineName! + medicine.medicineType!,
          child: Image.asset('lib/counter/inge.png'));
    }

    if (medicine.medicineType == 'pill') {
      return Hero(
          tag: medicine.medicineName! + medicine.medicineType!,
          child: Image.asset('lib/counter/pills1.png'));
    }
    return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: const Icon(Icons.error));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.blue,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MedicineDetails(medicine)));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 158, 199, 233),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              child: makeIcon(),
              height: 80,
            ),
            Text(medicine.medicineName!),
            Text(
              medicine.interval == 1
                  ? "Every ${medicine.interval} hour"
                  : "Every ${medicine.interval} hour",
            )
          ],
        ),
      ),
    );
  }
}
