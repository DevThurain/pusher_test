import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pusher_test/consts/app_colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String bitCoinValue = '-';
  WebSocketChannel? bitCoinChannel;
  WebSocketChannel? ethCoinChannel;
  WebSocketChannel? usdtCoinChannel;
  WebSocketChannel? solCoinChannel;

  @override
  void initState() {
    super.initState();

    /// Create the WebSocket channel
    bitCoinChannel = WebSocketChannel.connect(
      Uri.parse('wss://ws-feed.pro.coinbase.com'),
    );

    ethCoinChannel = WebSocketChannel.connect(
      Uri.parse('wss://ws-feed.pro.coinbase.com'),
    );

    usdtCoinChannel = WebSocketChannel.connect(
      Uri.parse('wss://ws-feed.pro.coinbase.com'),
    );

    solCoinChannel = WebSocketChannel.connect(
      Uri.parse('wss://ws-feed.pro.coinbase.com'),
    );

    bitCoinChannel!.sink.add(
      jsonEncode(
        {
          "type": "subscribe",
          "channels": [
            {
              "name": "ticker",
              "product_ids": [
                "BTC-EUR",
              ]
            }
          ]
        },
      ),
    );

    ethCoinChannel!.sink.add(
      jsonEncode(
        {
          "type": "subscribe",
          "channels": [
            {
              "name": "ticker",
              "product_ids": [
                "ETH-EUR",
              ]
            }
          ]
        },
      ),
    );

    usdtCoinChannel!.sink.add(
      jsonEncode(
        {
          "type": "subscribe",
          "channels": [
            {
              "name": "ticker",
              "product_ids": [
                "USDT-EUR",
              ]
            }
          ]
        },
      ),
    );

    solCoinChannel!.sink.add(
      jsonEncode(
        {
          "type": "subscribe",
          "channels": [
            {
              "name": "ticker",
              "product_ids": [
                "SOL-EUR",
              ]
            }
          ]
        },
      ),
    );

    /// Listen for all incoming data
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: HeaderRow(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Good Morning,\nThurain.',
              style: TextStyle(fontSize: 28, height: 1.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration:
                        BoxDecoration(color: AppColors.darkTeal, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.bitcoin,
                              color: Colors.white,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "BitCoin",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(height: 18),
                        bitCoinChannel != null
                            ? StreamBuilder<dynamic>(
                                stream: bitCoinChannel?.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.active) {
                                    var raw = jsonDecode(snapshot.data);
                                    var price = raw['price'];

                                    return Text(
                                      "\$ $price",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    return Container();
                                  }
                                })
                            : Container()
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration:
                        BoxDecoration(color: AppColors.lightBg, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.ethereum,
                              color: AppColors.activeGrey,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "ETH",
                              style: TextStyle(color: AppColors.activeGrey),
                            )
                          ],
                        ),
                        SizedBox(height: 18),
                        bitCoinChannel != null
                            ? StreamBuilder<dynamic>(
                                stream: ethCoinChannel?.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.active) {
                                    var raw = jsonDecode(snapshot.data);
                                    var price = raw['price'];

                                    return Text(
                                      "\$ $price",
                                      style: TextStyle(color: AppColors.activeGrey),
                                    );
                                  } else {
                                    return Container();
                                  }
                                })
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration:
                        BoxDecoration(color: AppColors.lightBg, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/usdt.png',
                              width: 32,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "USDT",
                              style: TextStyle(color: AppColors.activeGrey),
                            )
                          ],
                        ),
                        SizedBox(height: 18),
                        bitCoinChannel != null
                            ? StreamBuilder<dynamic>(
                                stream: usdtCoinChannel?.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.active) {
                                    var raw = jsonDecode(snapshot.data);
                                    var price = raw['price'];

                                    return Text(
                                      "\$ $price",
                                      style: TextStyle(color: AppColors.activeGrey),
                                    );
                                  } else {
                                    return Container();
                                  }
                                })
                            : Container()
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration:
                        BoxDecoration(color: AppColors.lightBg, borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/sol.png',
                              width: 32,
                            ),
                            SizedBox(width: 12),
                            Text(
                              "SOL",
                              style: TextStyle(color: AppColors.activeGrey),
                            )
                          ],
                        ),
                        SizedBox(height: 18),
                        bitCoinChannel != null
                            ? StreamBuilder<dynamic>(
                                stream: solCoinChannel?.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.active) {
                                    var raw = jsonDecode(snapshot.data);
                                    var price = raw['price'];

                                    return Text(
                                      "\$ $price",
                                      style: TextStyle(color: AppColors.activeGrey),
                                    );
                                  } else {
                                    return Container();
                                  }
                                })
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          FontAwesomeIcons.bars,
          color: AppColors.activeGrey,
          size: 20,
        ),
        Spacer(),
        FaIcon(
          FontAwesomeIcons.slidersH,
          color: AppColors.activeGrey,
                    size: 20,

        ),
        SizedBox(width: 24),
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1604004555489-723a93d6ce74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Z2lybHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60'),
        )
      ],
    );
  }
}
