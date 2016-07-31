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

    private:

    int mType;
    datetime mExpiration;
    int mMagic;
    double mLot;
    Price * pPrice;
    bool mEnableSL;
    bool mEnableTP;
    int mColor;
    string mComment;
    int mSlippage;

    public:

    Order(bool enableSL = true, bool enableTP = true) {
        mExpiration = 0;
        mMagic = 143432;
        mLot = 0;
        pPrice = new Price(0, 0, 0, 0);
        mEnableSL = enableSL;
        mEnableTP = enableTP;
        mColor = CLR_NONE;
        mSlippage = 0;
    }

    void Update(double lot, double stopLoss, double takeProfit, double ask, double bid) {
        mLot = lot;
        pPrice.Update(stopLoss, takeProfit, ask, bid);
    }

    void SetSlippage(int slippage) {
        mSlippage = slippage;
    }

    int GetSlippage() {
        return (mSlippage);
    }

    void SetComment(string comment) {
        mComment = comment;
    }

    string GetComment() {
        return (mComment);
    }

    void SetColor(int clr) {
        mColor = clr;
    }

    int GetColor() {
        return (mColor);
    }

    bool EnableSL(bool enable) {
        return (mEnableSL = enable);
    }

    bool EnableTP(bool enable) {
        return (mEnableTP = enable);
    }

    void SetType(int type) {
        mType = type;
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
        return ( mEnableSL
            ? OP_BUY == mType
                ? pPrice.GetBuySL()
                : pPrice.GetSellSL()
            : 0
        );
    }

    double GetTP() {
        return ( mEnableTP
            ? OP_BUY == mType
                ? pPrice.GetBuyTP()
                : pPrice.GetSellTP()
            : 0
        );
    }

    void SetExpiration(datetime expiration) {
        mExpiration = expiration;
    }

    datetime GetExpiration() {
        return (mExpiration);
    }

    void SetMagic(int magic) {
        mMagic = magic;
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
            order.GetSlippage(),
            order.GetSL(),
            order.GetTP(),
            order.GetComment(),
            order.GetMagic(),
            order.GetExpiration(),
            order.GetColor());

        if (0 != GetLastError()) {
            PrintError(__FUNCTION__, GetLastError());
            return (0);
        }

        return (orderId);
    }

};