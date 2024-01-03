import 'package:flutter/material.dart';

class ItemAccount extends StatelessWidget {
  final int? index;
  final String? id;
  final String? fullName;
  final String? email;
  final String? birthDay;
  final String? role;
  final String? sex;
  final Function(String id) editAccount;
  final Function(String id) removeAccount;

  const ItemAccount({
    super.key,
    this.birthDay,
    this.email,
    this.fullName,
    required this.id,
    this.index,
    this.role,
    this.sex,
    required this.editAccount,
    required this.removeAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              _getSequenceColor(index ?? 0).withOpacity(.3).withOpacity(.7)
            ],
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
          ),
          color: _getSequenceColor(index ?? 0).withOpacity(.3),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.blue)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email ?? "",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(fullName ?? "",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                Text(birthDay ?? "",
                    style: TextStyle(color: Colors.black, fontSize: 16))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sex == "1" ? "Nam" : "Nữ",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                Text("Nhân viên",
                    style: TextStyle(color: Colors.black, fontSize: 16))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          removeAccount(id ?? "");
                        },
                        child: Icon(Icons.restore_from_trash)),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                        onTap: () {
                          editAccount(id ?? "");
                        },
                        child: Icon(Icons.edit))
                  ],
                )
              ],
            ),
          ]),
    );
  }
}

Color _getSequenceColor(int index) {
  int val = index % 3;
  if (val == 2) {
    return Colors.indigo;
  } else if (val == 1) {
    return Colors.grey;
  } else {
    return Colors.lightBlue;
  }
}
