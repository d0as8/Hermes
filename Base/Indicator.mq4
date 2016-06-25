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

    protected:

    string NAME;

    public:

    Indicator() {
        this.NAME = this.GetClass(__FUNCTION__);
    }

    static string Decode(Operation o) {
        switch (o) {
            case NOP:
                return ("No operation");
            case NEXT:
                return ("Next indicator");
            case BUY:
                return ("Suppose BUY operation");
            case SELL:
                return ("Suppose SELL operation");
            default:
                return ("");
        }
    }

    virtual void Print(Operation o) {
        Print(this.NAME, " -> ", Indicator::Decode(o));
    }

    virtual Operation GetOperation() {
        Operation o = NEXT;

        this.Print(o);

        return (o);
    }

};