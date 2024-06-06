import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/chat_screen/view/chat_screen.dart';
import 'package:socialmedia/presentation/message_screen/controller/message_screen_controller.dart';

import '../../../core/constants/text_styles.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    Provider.of<MessageScreenController>(context, listen: false).fetchMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List profile = [
      {
        'dp': 'https://www.filmibeat.com/img/2019/02/kerala-state-film-awards-best-actors-2-1551245856.jpg',
        'title': 'Mammookka',
        'sub': 'Evidaanu',
        'time': '11:10',
      },
      {
        'dp': 'https://static.toiimg.com/photo/78766905.cms?imgsize=367804',
        'title': 'Prithviraj Sukumaran',
        'sub': 'hi',
        'time': '11:20',
      },
      {
        'dp': 'https://th.bing.com/th/id/OIP.Hl1u_ZFNgChMXcGlttBPlgHaFj?pid=ImgDet&rs=1',
        'title': 'Sundar Pichai',
        'sub': "i'm CEO of Google",
        'time': '10:30',
      },
      {
        'dp': 'https://starswiki.in/wp-content/uploads/2020/02/John-Cena.jpeg',
        'title': 'john cena',
        'sub': 'Hi Buddy... How r u ?',
        'time': '10:30',
      },
      {
        'dp': 'https://www.bollywoodhungama.com/wp-content/uploads/2024/04/Rashmika-Mandanna-3-3.jpg',
        'title': 'Reshmika',
        'sub': 'Evidaanu',
        'time': '11:10',
      },
      {
        'dp': 'https://images.businessupturn.com/wp-content/uploads/2020/09/vijay-1.jpg',
        'title': 'Vijay Actor',
        'sub': 'Hi, Anand',
        'time': '11:20',
      },
      {
        'dp':
            'https://th.bing.com/th/id/R.f69a53246c6169cf192749c36298b465?rik=B7A1jWaNkaDcvQ&riu=http%3a%2f%2fwww.forbesindia.com%2fmedia%2fimages%2f2018%2fNov%2fimg_110693_mukesh_ambani.jpg&ehk=bJG53U3OUUN4NS3GhzKu0In2E9x0xR6hfohu9ws5wTc%3d&risl=&pid=ImgRaw&r=0',
        'title': 'Mukesh Ambani',
        'sub': 'Where r u?',
        'time': '10:30',
      },
      {
        'dp': 'https://th.bing.com/th/id/OIP.bYYPVYG9irJsLEN5FJb2mQHaGx?pid=ImgDet&rs=1',
        'title': 'Air Chief Rakesh Kumar Singh',
        'sub': 'mission accomplished',
        'time': '10:30',
      },
      {
        'dp': 'https://i.insider.com/59f8dc483e9d25db458b5dfc?width=2400',
        'title': 'Elon Musk',
        'sub': "i'm Going to united states Today",
        'time': '11:10',
      },
      {
        'dp': 'https://th.bing.com/th/id/OIP.AKORIRJpEBG-C3ISO3RmOgHaJQ?pid=ImgDet&rs=1',
        'title': 'Kiran Das IPS',
        'sub': "Don't go outside",
        'time': '11:20',
      },
      {
        'dp': 'https://www.chitramala.in/wp-content/uploads/2014/11/kamal-hassan-birthday-2014.jpg',
        'title': 'Kamal Hasan',
        'sub': "You can't see me",
        'time': '10:30',
      },
      {
        'dp':
            'https://1.bp.blogspot.com/-o9hAWjBzaJI/Xg-XKAcGQII/AAAAAAAAAGs/IG-ZtmyYNx4ZZxfGCkxFUkB7YvEhcDGGgCLcBGAsYHQ/s1600/Can%2BYaman%2B2.jpg',
        'title': 'Shihab K Saleem',
        'sub': 'Flutter Nokkiyaa',
        'time': '10:30',
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThingShare",
          style: GLTextStyles.leagueSpartan(size: 25, weight: FontWeight.w500, color: ColorTheme.brown),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
      body: Consumer<MessageScreenController>(builder: (context, controller, _) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () =>
                    Provider.of<MessageScreenController>(context, listen: false).fetchMessage(context),
                child: ListView.separated(
                  itemCount: controller.messageSendersModel.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(id: controller.messageSendersModel.data![index].id!),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                controller.messageSendersModel.data?[index].image ?? AppConfig.noImage),
                          ),
                          title: Text(
                            controller.messageSendersModel.data?[index].username ?? "",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              );
      }),
    );
  }
}
