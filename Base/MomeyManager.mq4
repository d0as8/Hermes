//+------------------------------------------------------------------+
//|                                                 MomeyManager.mq4 |
//|                                                            d0as8 |
//|                                                             1.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version "1.00"
#property strict

#include "Base.mq4"
#include "OrderManager.mq4"

class MomeyManager: public Base {

    public:

    virtual Order * GetOrder() {
        return (new Order());
    }

};