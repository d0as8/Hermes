//+------------------------------------------------------------------+
//|                                                  Application.mq4 |
//|                                                            d0as8 |
//|                                                             1.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version "1.00"
#property strict

#include "Base/Base.mq4"
#include "Base/Indicator.mq4"
#include "Base/MomeyManager.mq4"
#include "Base/OrderManager.mq4"

class Application: public Base {

    protected:

    Indicator * indicators[];
    MomeyManager * momeyManager;
    OrderManager * orderManager;

    public:

    Application(MomeyManager * mm, OrderManager * om) {
        momeyManager = mm;
        orderManager = om;
    }

    virtual void Add(Indicator * i) {
        ArrayResize(indicators, ArraySize(indicators) + 1);
        indicators[ArraySize(indicators) - 1] = i;
    }

    virtual Operation isActive() {
        Operation op = NOP;

        for (int i = 0; i < ArraySize(indicators); i++) {
            Operation o = indicators[i].isActive();

            if (NEXT == o)
                continue;

            if (NOP == o)
                return (NOP);

            if (NOP == op) {
                op = o;
            } else {
                if (op != o)
                    return (NOP);
            }

        }

        return (op);
    }

    virtual void Process() {
        Operation op = isActive();

        if (NOP == op)
            return;

        Order * order = momeyManager.GetOrder();

        order.mType = BUY == op ? OP_BUY : OP_SELL;

        orderManager.OpenOrder(order);

    }

};