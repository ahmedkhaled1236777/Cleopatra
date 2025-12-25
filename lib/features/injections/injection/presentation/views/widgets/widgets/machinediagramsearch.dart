

/*class Machinediagramsearch extends StatefulWidget {
  @override
  State<Machinediagramsearch> createState() => _MachinediagramsearchtState();
}

class _MachinediagramsearchtState extends State<Machinediagramsearch> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,

          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                title: Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        BlocProvider.of<DateCubit>(context).cleardates();

                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close)),
                ),
                content: Showdiagram());
          },
        );
      },
      child: const Icon(
        Icons.show_chart_sharp,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}*/