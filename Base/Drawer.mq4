//+------------------------------------------------------------------+
//|                                                       Drawer.mq4 |
//|                                                            d0as8 |
//|                                                             1.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version "1.00"
#property strict

#include "Base.mq4"

class Drawer: public Base {

   public:

   static bool DrawLine(int clr) {
       string id = TimeToString(TimeCurrent());

      ResetLastError();

      if(!ObjectCreate(0,id,OBJ_VLINE,0,TimeCurrent(),0)) {
          PrintError(__FUNCTION__, GetLastError());

          return(false);
     }

        ObjectSetInteger(0, id, OBJPROP_COLOR,     clr);
        ObjectSetInteger(0, id, OBJPROP_STYLE,     STYLE_DOT);
        ObjectSetInteger(0, id, OBJPROP_WIDTH,     1);
        ObjectSetInteger(0, id, OBJPROP_BACK,      true);
        ObjectSetInteger(0, id, OBJPROP_SELECTABLE,false);
        ObjectSetInteger(0, id, OBJPROP_SELECTED,  false);
        ObjectSetInteger(0, id, OBJPROP_HIDDEN,    true);

        return(true);
      }
};