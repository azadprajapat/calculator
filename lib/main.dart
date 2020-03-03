import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: Siform(),
    theme: ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.black,
      primaryColor: Colors.indigo,
    ),
  ));
}

class Siform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SiformState();
  }
}

class SiformState extends State<Siform> {
  var _currencies = ['rupees', 'Dollars', 'Pounds'];
  var _currentvalue = 'rupees';
  var _display = '';
  TextEditingController PrincipleControler;
  TextEditingController Roi=TextEditingController();
  TextEditingController Term=TextEditingController();

  @override
  void initState() {
    PrincipleControler=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   TextStyle textStyle =Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
         child: Column(
          children: <Widget>[
            getassetimage(),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: TextField(
                  style: textStyle,
                  controller: PrincipleControler,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Principle Amount',
                    hintText: 'Enter your principle Amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                controller: Roi,
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Rate of Interest',
                  hintText: 'Rate of Interest eg 2%',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: Term,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'number of years',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  Container(width: 30.0,),
                  Expanded(

                    child: DropdownButton<String>(
                      items: _currencies.map((String Dropitem) {
                        return DropdownMenuItem<String>(
                          value: Dropitem,
                          child: Text(Dropitem),
                        );
                      }).toList(),
                      onChanged: (String newvalue) {
                        setState(() {
                          this._currentvalue = newvalue;
                        });
                      },
                      value: _currentvalue,
                    ),
                  )
                ],
              ),
            ),
            Row(children: <Widget>[


              Expanded(child:
                  Padding(
                    padding: EdgeInsets.only(right: 10.0,left: 10.0),
                    child:
              RaisedButton(child: Text('Calculate',textScaleFactor: 1.5,),
                color: Theme.of(context).accentColor,
                onPressed: (){
                setState(() {
                  _display=_calculate();
                });

                },
                textColor: Theme.of(context).primaryColorDark,
                   )
                ),
              ),
              Expanded(child:
              Padding(
                padding: EdgeInsets.only(right: 10.0,),
                  child:
                  RaisedButton(child: Text('Reset',textScaleFactor: 1.5,),
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: (){
                    setState(() {
                      _reset();
                    });

                    },

                  )
              )
              ),

            ],),
            Padding(
              padding:EdgeInsets.all(10.0),
              child: Text(this._display ,style: textStyle,),
            )

          ],

        ),
      ),
    );
  }

  Widget getassetimage() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      padding: EdgeInsets.only(left: 30.0, top: 10.0, bottom: 20.0),
    );
  }
// ignore: missing_return
String _calculate (){
    double principle =double.parse(PrincipleControler.text);
    double rate =double.parse(Roi.text);
    double time =double.parse(Term.text);
    double total = principle + (principle*rate*time)/100;
    String statement = 'At the end of $time You have to pay a total amount of $total $_currentvalue';
    return statement;
}
void _reset(){
    PrincipleControler.text='';
    Roi.text='';
    Term.text='';
    _display='';
    _currentvalue=_currencies[0];
}
}
