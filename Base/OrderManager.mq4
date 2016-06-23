//+------------------------------------------------------------------+
//|                                                 OrderManager.mq4 |
//|                                                            d0as8 |
//|                                                             1.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version "1.00"
#property strict

#include "Base.mq4"

class Price {

    private:

    double mAsk;
    double mBid;
    double mStopLoss;
    double mTakeProfit;

    public:

    Price(double stopLoss = 0.0, double takeProfit = 0.0, double ask = 0.0, double bid = 0.0) {
            Update(stopLoss, takeProfit, ask, bid);
    }

    void Update(double stopLoss, double takeProfit, double ask, double bid) {
        this.mStopLoss = stopLoss;
        this.mTakeProfit = takeProfit;
        this.mAsk = ask;
        this.mBid = bid;
    }

    double GetBuyPrice() {
        return (mAsk);
    }

    double GetBuySL() {
        return (mBid - mStopLoss);
    }

    double GetBuyTP() {
        return (mBid + mTakeProfit);
    }

    double GetSellPrice() {
        return (mBid);
    }

    double GetSellSL() {
        return (mAsk + mStopLoss);
    }

    double GetSellTP() {
        return (mAsk - mTakeProfit);
    }
};

class Order {

    // todo hide
    public:

    int mType;
    datetime mExpiration;
    int mMagic;
    double mLot;
    Price * pPrice;

    public:

    Order() {
        this.mExpiration = 0;
        this.mMagic = 143432;
        this.mLot = 0;
        this.pPrice = new Price(0, 0, 0, 0);
    }

    void Update(double lot, double stopLoss, double takeProfit, double ask, double bid) {
        this.mLot = lot;
        this.pPrice.Update(stopLoss, takeProfit, ask, bid);
    }

    int GetType() {
        return (mType);
    }

    double GetLot() {
        return (mLot);
    }

    double GetPrice() {
        return (OP_BUY == mType ? pPrice.GetBuyPrice() : pPrice.GetSellPrice());
    }

    double GetSL() {
        return (OP_BUY == mType ? pPrice.GetBuySL() : pPrice.GetSellSL());
    }

    double GetTP() {
        return (OP_BUY == mType ? pPrice.GetBuyTP() : pPrice.GetSellTP());
    }

    datetime GetExpiration() {
        return (mExpiration);
    }

    int GetMagic() {
        return (mMagic);
    }

    ~Order() {
        delete(pPrice);
    }
};

class OrderManager: public Base {

    public:

    static int OpenOrder(Order * order) {

        ResetLastError();

        int orderId = OrderSend(
            NULL,
            order.GetType(),
            order.GetLot(),
            order.GetPrice(),
            0,
            order.GetSL(),
            order.GetTP(),
            "",
            order.GetMagic(),
            order.GetExpiration(),
            CLR_NONE);

        if (0 != GetLastError()) {
            PrintError(__FUNCTION__, GetLastError());
            return (0);
        }

        return (orderId);
    }

};