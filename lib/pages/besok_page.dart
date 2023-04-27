part of 'pages.dart';

class BesokPage extends StatefulWidget {
  final List<WilayahCuacaModel>? model;

  const BesokPage({super.key, this.model});

  @override
  State<BesokPage> createState() => _BesokPageState();
}

class _BesokPageState extends State<BesokPage> {
  final format = DateFormat.Hm();

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var tomorrow = DateTime(now.year, now.month, now.day + 1);

    var result = widget.model!
        .where((e) =>
            e.jamCuaca!.replaceRange(10, null, "") ==
            tomorrow.toString().replaceRange(10, null, ""))
        .toList();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: result.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    format.format(DateTime.parse(result[index].jamCuaca!)),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    result[index].jamCuaca!.replaceRange(10, null, ""),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ],
              ),
              kondisiCuaca(result[index]),
              Row(
                children: [
                  Text(
                    widget.model![index].tempC!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const Text("\u00B0")
                ],
              )
            ],
          ),
        );
      },
    );
  }

  kondisiCuaca(WilayahCuacaModel model) {
    return model.cuaca == "Cerah Berawan"
        ? const Icon(Iconsax.cloud_notif)
        : model.cuaca == "Berawan"
            ? const Icon(Iconsax.cloud)
            : model.cuaca == "Cerah"
                ? const Icon(Icons.brightness_low)
                : model.cuaca == "Hujan Ringan"
                    ? const Icon(Iconsax.cloud_snow)
                    : model.cuaca == "Berawan Tebal"
                        ? const Icon(Iconsax.cloud_minus)
                        : const Icon(Iconsax.cloud_lightning);
  }
}
