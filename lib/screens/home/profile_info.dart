import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasks/models/profile.dart';
import 'package:tasks/shared/color.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<Profile>>(context) ?? [];
    var profileData;
    profiles.forEach((profile) {
      profileData = profile;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileData != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      child: CircleAvatar(
                        backgroundColor: cWhite,
                        backgroundImage: NetworkImage(profileData.avatar),
                        radius: 55.0,
                      ),
                      foregroundColor: cWhite,
                      backgroundColor: cDarkPink3,
                    ),
                    width: 60.0,
                    height: 60.0,
                    padding: EdgeInsets.all(2.0), // borde width
                    decoration: BoxDecoration(
                      color: cDarkPink1, // border color
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Hi",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            profileData.firstname,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            profileData.surname,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Here are you tasks as at today",
                        style: TextStyle(
                          color: cWhite,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Shimmer.fromColors(
                baseColor: cWhite,
                highlightColor: cDarkPink2,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 65.0,
                      height: 65.0,
                      margin: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 0.0),
                      child: Icon(
                        Icons.person_pin,
                        size: 60,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: cDarkPink2,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: 160.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              color: cDarkPink2,
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
