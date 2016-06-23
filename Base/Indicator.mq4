//+------------------------------------------------------------------+
//|                                                    Indicator.mq4 |
//|                                                            d0as8 |
//|                                                             1.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version "1.00"
#property strict

#include "Base.mq4"

enum Operation {
    NOP = 0,
    NEXT = 1,
    BUY = 2,
    SELL = 4
};

class Indicator: public Base {

    public:

    virtual Operation GetOperation() {
        return (NOP);
    }

};