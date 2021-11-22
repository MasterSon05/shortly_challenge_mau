import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mau_shortly_challange/data/api_client.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController linkController = TextEditingController();
  List linkItems = [];
  bool _validate = false;
  bool _indicator = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: _indicator
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          color: const Color(0xffF0F1F6),
                          child: linkItems.isNotEmpty
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: linkItems.length,
                                  reverse: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Card(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      linkItems[index]
                                                          ["fulLink"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff35323E),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            linkItems.removeAt(
                                                                index);
                                                          });
                                                        },
                                                        child: SvgPicture.asset(
                                                            'images/del.svg'),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              height: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                linkItems[index]["sortLink"],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff2ACFCF),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: linkItems[
                                                                    index]
                                                                ["button"] ==
                                                            "COPY"
                                                        ? MaterialStateProperty
                                                            .all<
                                                                    Color>(
                                                                const Color(
                                                                    0xff2ACFCF))
                                                        : MaterialStateProperty
                                                            .all<
                                                                    Color>(
                                                                const Color(
                                                                    0xff35323E))),
                                                onPressed: () {
                                                  setState(() {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: linkItems[
                                                                    index]
                                                                ["sortLink"]));

                                                    linkItems[index]["button"] =
                                                        "COPIED!";
                                                  });
                                                },
                                                child: Text(
                                                  linkItems[index]["button"],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Column(
                                  children: [
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                        flex: 1,
                                        child: SvgPicture.asset(
                                            'images/logo.svg')),
                                    Expanded(
                                        flex: 4,
                                        child: SvgPicture.asset(
                                            'images/illustration.svg')),
                                    const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Let's get started!",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Color(0xff35323E),
                                              fontWeight: FontWeight.bold),
                                        )),
                                    const Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          child: Text(
                                            "Paste your first link into the field to shorten it",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff35323E),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                  ],
                                ),
                        )),
              Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        color: const Color(0xff3B3054),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset('images/shape.svg')),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: linkController,
                                    textAlign: TextAlign.center,
                                    // ignore: prefer_const_constructors
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: _validate
                                          ? 'Please add a link here'
                                          : 'Shorten a link here ...',
                                      focusColor: Colors.red,
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: _validate
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff2ACFCF))),
                                    onPressed: linkMaker,
                                    child: const Text(
                                      "SHORTEN IT!",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  linkMaker() async {
    if (linkController.text.isEmpty) {
      setState(() {
        _validate = true;
      });
    } else {
      setState(() {
        _validate = false;
      });
      _indicator = true;
      String fullLink = linkController.text;
      String shrtLink = await ShrtCoderApiClient().getShortLink(fullLink);
      setState(() {
        linkController.text.isEmpty ? _validate = true : _validate = false;
        linkItems.add(Map.from(
            {"sortLink": shrtLink, "fulLink": fullLink, "button": "COPY"}));
        linkController.clear();
        _indicator = false;
      });
    }
  }
}
