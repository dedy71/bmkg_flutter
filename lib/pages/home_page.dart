part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final searchCtl = TextEditingController();
  final fJam = DateFormat.Hm();
  final fHari = DateFormat.yMMMMEEEEd();
  var timeNow = DateTime.now().hour;

  late TabController tabCtl;
  final List<Tab> topTabs = <Tab>[
    const Tab(text: 'Hari Ini'),
    const Tab(text: 'Besok'),
  ];

  List<WilayahCuacaModel> listCuaca = [];
  List<WilayahModel> listWilayah = [];

  String? id, txtDropdownWilayah, txtResultWilayah, txtResultSuhu, messageError;

  Future<void> getWilayah() async {
    listWilayah = await ServiceBmkg().getWilayah();
  }

  Future<void> getCuaca() async {
    listCuaca = await ServiceBmkg().getCuaca(id ?? "501266");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabCtl = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Future.wait([
            getCuaca(),
            getWilayah(),
          ]),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  header(),
                  SizedBox(
                    height: 60,
                    child: TabBar(
                      tabs: topTabs,
                      controller: tabCtl,
                      isScrollable: true,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: TabBarView(controller: tabCtl, children: [
                      HariIniPage(model: listCuaca),
                      BesokPage(model: listCuaca),
                    ]),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget header() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: dropdown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${txtDropdownWilayah ?? "Jawa Tengah"} ",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                const Icon(Icons.arrow_drop_down, color: Colors.white)
              ],
            ),
          ),
          Text(txtResultWilayah ?? "Kota Surakarta",
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 20),
          cuacaPerjam(),
        ],
      ),
    );
  }

  cuacaPerjam() {
    if (listCuaca.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      var result = listCuaca.firstWhere((e) {
        if ((timeNow > 6) && (timeNow <= 12)) {
          return fJam.format(DateTime.parse(e.jamCuaca!)) == "6:00";
        } else if ((timeNow > 12) && (timeNow <= 18)) {
          return fJam.format(DateTime.parse(e.jamCuaca!)) == "12:00";
        } else if ((timeNow > 18) && (timeNow < 24)) {
          return fJam.format(DateTime.parse(e.jamCuaca!)) == "18:00";
        } else {
          return fJam.format(DateTime.parse(e.jamCuaca!)) == "0:00";
        }
      });

      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${result.tempC!}\u00B0",
              style: const TextStyle(fontSize: 70, color: Colors.white),
            ),
            const SizedBox(height: 30),
            Text(
              fHari.format(DateTime.parse(result.jamCuaca!)),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              result.cuaca!,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            result.cuaca == "Cerah Berawan"
                ? const Icon(Iconsax.cloud_notif,
                    size: 100, color: Colors.white)
                : result.cuaca == "Berawan"
                    ? const Icon(Iconsax.cloud, size: 100, color: Colors.white)
                    : result.cuaca == "Cerah"
                        ? const Icon(Icons.brightness_low,
                            size: 100, color: Colors.white)
                        : result.cuaca == "Hujan Ringan"
                            ? const Icon(Iconsax.cloud_snow,
                                size: 100, color: Colors.white)
                            : result.cuaca == "Berawan Tebal"
                                ? const Icon(Iconsax.cloud_minus,
                                    size: 100, color: Colors.white)
                                : const Icon(Iconsax.cloud_lightning,
                                    size: 100, color: Colors.white)
          ],
        ),
      );
    }
  }

  dropdown() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: searchForm(searchCtl),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listWilayah.length,
                itemBuilder: (_, index) {
                  return listWilayah[index]
                          .kota!
                          .toLowerCase()
                          .contains(searchCtl.text)
                      ? ListTile(
                          onTap: () {
                            setState(() {
                              id = listWilayah[index].id!;
                              txtDropdownWilayah = listWilayah[index].propinsi!;
                              txtResultWilayah = listWilayah[index].kota!;
                            });
                            Navigator.pop(context);
                          },
                          title: Text(listWilayah[index].kota!),
                          subtitle: Text(listWilayah[index].propinsi!),
                        )
                      : const SizedBox();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget searchForm(TextEditingController ctl) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: ctl,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Cari ...",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
