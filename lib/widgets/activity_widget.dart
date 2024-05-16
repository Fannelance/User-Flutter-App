import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class roactivity extends StatelessWidget {
  const roactivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
               children: [
            Padding(
              padding:  EdgeInsets.all(12.0),
               child:SvgPicture.asset(
                 'assets/icons/worker.svg',
                 width: 50,
                  height: 50,
)
,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Column(
                    children:  [
                      Text.rich(
                        TextSpan
                      (text: "Ahmed Hassan ",style: 
                      TextStyle(fontFamily: "Gilroy-Bold",fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(text: "| Carpenter",style: TextStyle(fontFamily: "Gilroy-Meduim",fontSize: 18))
                      ]
                      
                      ),
                      
                      
                      ),                
                     Padding(
                       padding: EdgeInsets.only(right: 150),
                       child: Row(
                         children: [
                           Text("50/hour",style: TextStyle(fontFamily: "Gilroy-Meduim",fontSize: 18),),    
                         ], 
                       ),
                       
                     ),                    
                    ],
                     
                  ),
                  
                ],
                
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text('5th Jan 11:00', style: TextStyle(fontFamily: "Gilroy-Meduim",fontSize: 16),),
            ),
            
          ],
          
          
            );
}
}