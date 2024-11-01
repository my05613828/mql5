//+------------------------------------------------------------------+
//|                                                        symbol_trade.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "江苏鑫起点信息技术服务有限公司出品@大树My05613828"
#property link      "https://www.eahub.cn/space-uid-8564.html"
#property version   "1.0"
#property  icon     "//include//m5_class//logo.ico"
class symbol_trade
  {

                     symbol_trade(string _symbol,double _lot,ulong _magic,string _long_comment,string _short_comment,ENUM_TIMEFRAMES _period);
                     symbol_trade(string _symbol,double _lot,ulong _magic,ENUM_TIMEFRAMES _period);
                     symbol_trade(double _lot,ulong _magic,ENUM_TIMEFRAMES _period);
                     symbol_trade(double _lot,ENUM_TIMEFRAMES _period);
                     symbol_trade();
                    ~symbol_trade();
private:
   //---私有成员变量
   string            symbol;          //---交易品种
   double            lot;             //---手数
   ulong             magic;           //---EA魔术号
   ENUM_TIMEFRAMES   period;
   string            prefix;          //---注释前缀
   string            long_comment;       //---多注释
   string            short_comment;       //---空注释
   double            point;
   ulong             dev;              //---滑点
   long              digit;//---小数点
   datetime          time_k_chk1,time_k_chk2;//---一k一信号时间检测

   MqlTradeRequest   request;         //用于发送交易请求的MQL5交易请求结构体
   MqlTradeResult    result;          //用于获取交易结果的MQL5交易结果结构体
   ENUM_ORDER_TYPE_FILLING       type_filling;//---交易指令类型
   string            err_msg;         // 存储报错信息的变量
   int               err_code;        // 存储错误代码的变量
   //---私有成员函数
   void              do_init();     //用于EA交易系统初始化的函数
   void              do_uninit();   //用于EA交易系统去初始化的函数

   //+------------------------------------------------------------------+
   long              stop_loss(long _point=0);//---停损
   long              condense(long _point=0);//---凝结
   //---
   double            long_small_sl_price(double _sl_price=0);
   double            long_small_tp_price(double _tp_price=0);
   double            short_small_sl_price(double _sl_price=0);
   double            short_small_tp_price(double _tp_price=0);
   //+------------------------------------------------------------------+
   double            long_small_sl_price(long _sl_point=0);
   double            long_small_tp_price(long _tp_point=0);
   double            short_small_sl_price(long _sl_point=0);
   double            short_small_tp_price(long _tp_point=0);
   //+------------------------------------------------------------------+
   //--- 保护成员函数
protected:
   void              print_error(string _msg);
   bool              marginOK(double _tradePct = 30) ;    //检查交易所需预付款是否OK的函数

public:
   //---私有成员变量接口
   string             get_symbol() {return this.symbol;};
   double             get_lot() {return this.lot;};
   ulong              get_magic() {return this.magic;};
   ENUM_TIMEFRAMES    get_period() {return this.period;};
   string             get_prefix() {return this.prefix;};
   string             get_long_comment() {return this.long_comment;};
   string             get_short_comment() {return this.short_comment;};
   double             get_point() {return this.point;};
   ulong              get_dev() {return this.dev;};
   long               get_digit() {return this.digit;};
   ENUM_ORDER_TYPE_FILLING    get_type_filling() {return this.type_filling;};
   datetime           get_time_k_chk1() {return this.time_k_chk1;};
   datetime           get_time_k_chk2() {return this.time_k_chk2;};
   //---
   void              set_symbol(string _symbol="");
   void              set_lot(double _lot) {this.lot = _lot;};
   void              set_magic(ulong _magic) {this.magic = _magic;};
   void              set_prefix(string _prefix) {this.prefix = _prefix;};
   void              set_long_comment(string _long_comment) {this.long_comment = this.prefix + _long_comment;};
   void              set_short_comment(string _short_comment) {this.short_comment = this.prefix + _short_comment;};
   void              set_point() {this.point = SymbolInfoDouble(this.symbol,SYMBOL_POINT);};
   void              set_dev(ulong  _dev=5) { this.dev = SymbolInfoInteger(this.symbol,SYMBOL_SPREAD) + _dev;};
   void              set_digit() { this.digit = SymbolInfoInteger(this.symbol,SYMBOL_DIGITS);};
   void              set_type_filling();
   void              set_time_k_chk1(datetime _time) {this.time_k_chk1 = _time;};
   void              set_time_k_chk2(datetime _time) {this.time_k_chk2 = _time;};
   //---成员函数
   //+--开仓  自定义注释
   bool              open_buy(double _lot,long _sl_point,long _tp_point,string comment);
   bool              open_sell(double _lot,long _sl_point,long _tp_point,string comment);
   bool              open_buy(double _lot,double _sl_price,double _tp_price,string comment);
   bool              open_sell(double _lot,double _sl_price,double _tp_price,string comment);

   bool              open_buy(long _sl_point,long _tp_point,string comment);
   bool              open_sell(long _sl_point,long _tp_point,string comment);
   bool              open_buy(double _sl_price,double _tp_price,string comment);
   bool              open_sell(double _sl_price,double _tp_price,string comment);

   bool              open_buy(double _lot,long _sl_point,long _tp_point);
   bool              open_sell(double _lot,long _sl_point,long _tp_point);
   bool              open_buy(double _lot,double _sl_price,double _tp_price);
   bool              open_sell(double _lot,double _sl_price,double _tp_price);

   bool              open_buy(long _sl_point,long _tp_point);
   bool              open_sell(long _sl_point,long _tp_point);
   bool              open_buy(double _sl_price,double _tp_price);
   bool              open_sell(double _sl_price,double _tp_price);
   //---平对象注释comment
   void              close_order_comment();
   void              close_long_order_comment();
   void              close_short_order_comment();
   //---平所有
   void              close_order();
   void              close_long_order();
   void              close_short_order();
   //---平自定义注释comment
   void              close_order(string _comment);
   void              close_long_order(string _comment);
   void              close_short_order(string _comment);

   double            ask();
   double            bid();
   //---一k一单时间检测
   bool              tim_k_chk1(ENUM_TIMEFRAMES _period = PERIOD_CURRENT);
   bool              tim_k_chk2(ENUM_TIMEFRAMES _period = PERIOD_CURRENT);
   //---订单类型选择 -1 选择所有  0 选择多 1选择空
   bool              position_order_type_choose(int _type_choose);
   //---获取持仓订单号
   long              position_last_order_ticket(long _start_tim,long _end_tim,int _type_choose=-1);
   long              position_last_order_ticket(int _type_choose=-1);
   long              position_first_order_ticket(long _start_tim,long _end_tim,int _type_choose=-1);
   long              position_first_order_ticket(int _type_choose=-1);
   //---获取订单属性
   long              position_order_integer_property(long _ticket,ENUM_POSITION_PROPERTY_INTEGER _integer_property);
   double            position_order_double_property(long _ticket,ENUM_POSITION_PROPERTY_DOUBLE _double_property);
   string            position_order_string_property(long _ticket,ENUM_POSITION_PROPERTY_STRING _string_property);
   //---订单类型选择 -1 选择所有  0 选择多 1选择空  内部使用
   bool              history_order_type_choose(ulong _deal_ticket,int _type_choose=-1);
   //+---获取历史订单号
   ulong             history_last_order_ticket(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1);
   ulong             history_last_order_position_id(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1);
   ulong             history_first_order_ticket(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1);
   ulong             history_first_order_position_id(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1);
   //---获取历史订单属性
   ulong             history_order_integer_property(ulong _deal_ticket,ENUM_DEAL_PROPERTY_INTEGER _integer_property);
   double            history_order_double_property(ulong _deal_ticket,ENUM_DEAL_PROPERTY_DOUBLE _double_property);
   string            history_order_string_property(ulong _deal_ticket,ENUM_DEAL_PROPERTY_STRING _string_property);
   //+------------------------------------------------------------------+
   //---持仓单数统计 double属性值统计
   int               position_order_sum(int _type_choose=-1);
   double            position_order_double_property_sum(ENUM_POSITION_PROPERTY_DOUBLE _double_property,int _type_choose=-1);
   //--- 手数自适应
   double            lot_adaptive(double _lots);
   double            lot_adaptive_zero(double _lots);
   double            NormalizeVolume(double _lot);
   //---锁仓
   void              lots_lock(double _long_lots,double _short_lots,long _sl_point,long _tp_point,string _comment);
   void              long_lots_lock(double _long_lots,double _short_lots,long _sl_point,long _tp_point,string _comment);
   void              short_lots_lock(double _long_lots,double _short_lots,long _sl_point,long _tp_point,string _comment);

   //+------------------------------------------------------------------+
   //---k阴阳判断
   bool              yin_yang_chk(int _choose_yin_yang,int _index=1);
   bool              yin_yang_2_chk(int _choose_yin_yang,int _index=1);
   bool              yin_yang_3_chk(int _choose_yin_yang,int _index=1);
   bool              continuous_yin_yang_2_chk(int _choose_yin_yang,int _index=1);
   bool              continuous_yin_yang_3_chk(int _choose_yin_yang,int _index=1);
   //---总盈利 总亏损平单
   bool              tp_profits_close_orders(double _profits,double _tp_profits);
   bool              tp_profits_close_long_orders(double _profits,double _tp_profits);
   bool              tp_profits_close_short_orders(double _profits,double _tp_profits);
   bool              sl_profits_close_orders(double _profits,double _sl_profits);
   bool              sl_profits_close_long_orders(double _profits,double _sl_profits);
   bool              sl_profits_close_short_orders(double _profits,double _sl_profits);
   //+------------------------------------------------------------------+
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
symbol_trade::~symbol_trade()
  {
   this.do_uninit();
  }
//----
symbol_trade::symbol_trade(string _symbol,double _lot,ulong _magic,string _long_comment,string _short_comment,ENUM_TIMEFRAMES _period)
  {
   this.do_init();
   this.set_symbol(_symbol);
   this.set_lot(_lot);
   this.set_magic(_magic);
   this.set_long_comment(_long_comment);
   this.set_short_comment(_short_comment);
   this.set_time_k_chk1(iTime(this.get_symbol(),_period,0));
   this.set_time_k_chk2(iTime(this.get_symbol(),_period,0));
  }
//---
symbol_trade::symbol_trade(string _symbol,double _lot,ulong _magic,ENUM_TIMEFRAMES _period)
  {
   this.do_init();
   this.set_symbol(_symbol);
   this.set_lot(_lot);
   this.set_magic(_magic);
   this.set_long_comment("");
   this.set_short_comment("");
   this.set_time_k_chk1(iTime(this.get_symbol(),_period,0));
   this.set_time_k_chk2(iTime(this.get_symbol(),_period,0));
  }
//---
symbol_trade::symbol_trade(double _lot,ulong _magic,ENUM_TIMEFRAMES _period)
  {
   this.do_init();
   this.set_symbol(Symbol());
   this.set_lot(_lot);
   this.set_magic(_magic);
   this.set_long_comment("");
   this.set_short_comment("");
   this.set_time_k_chk1(iTime(Symbol(),_period,0));
   this.set_time_k_chk2(iTime(Symbol(),_period,0));
  }
//---
symbol_trade::symbol_trade(double _lot,ENUM_TIMEFRAMES _period)
  {
   this.do_init();
   this.set_symbol(Symbol());
   this.set_lot(_lot);
   this.set_magic(0);
   this.set_long_comment("");
   this.set_short_comment("");
   this.set_time_k_chk1(iTime(Symbol(),_period,0));
   this.set_time_k_chk2(iTime(Symbol(),_period,0));
  }
//+------------------------------------------------------------------+
symbol_trade::symbol_trade()
  {
   this.do_init();
   this.set_symbol(Symbol());
   this.set_lot(0.01);
   this.set_magic(0);
   this.set_long_comment("");
   this.set_short_comment("");
   this.set_time_k_chk1(iTime(Symbol(),PERIOD_CURRENT,0));
   this.set_time_k_chk2(iTime(Symbol(),PERIOD_CURRENT,0));
  }
//+------------------------------------------------------------------+
void symbol_trade::do_init()
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
   this.set_prefix("Π.EA ");
   this.set_point();
   this.set_dev();
   this.set_digit();
   this.set_type_filling();
   this.err_msg="";         // 存储报错信息的变量
   this.err_code=0;        // 存储错误代码的变量
  }
//+------------------------------------------------------------------+
void symbol_trade::do_uninit()
  {

  };
//+------------------------------------------------------------------+
void symbol_trade::set_symbol(string _symbol="")
  {
   if(_symbol=="")
      this.symbol = Symbol();
   else
      this.symbol = _symbol;
  };
//+------------------------------------------------------------------+
//|私有权限 设置交易量指令类型                                                                  |
//+------------------------------------------------------------------+
void symbol_trade::set_type_filling()
  {
   this.type_filling=ORDER_FILLING_FOK;
   if(SymbolInfoInteger(this.get_symbol(),SYMBOL_FILLING_MODE)==SYMBOL_FILLING_IOC)
      this.type_filling=ORDER_FILLING_IOC;
   if(SymbolInfoInteger(this.get_symbol(),SYMBOL_FILLING_MODE)==SYMBOL_FILLING_FOK)
      this.type_filling=ORDER_FILLING_FOK;
  };
//+------------------------------------------------------------------+
long  symbol_trade::stop_loss(long _point=0)
  {
   if(_point==0)
      return 0;
   if(_point>0 && _point<SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_STOPS_LEVEL))
      _point = SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_STOPS_LEVEL);
   return _point;
  }
//+------------------------------------------------------------------+
long  symbol_trade::condense(long _point=0)
  {
   if(_point==0)
      return 0;
   if(_point>0 && _point<SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_FREEZE_LEVEL))
      _point= SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_FREEZE_LEVEL);
   return _point;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double symbol_trade::ask()
  {
   return SymbolInfoDouble(this.get_symbol(),SYMBOL_ASK);
  }
//+------------------------------------------------------------------+
double symbol_trade::bid()
  {
   return SymbolInfoDouble(this.get_symbol(),SYMBOL_BID);
  }
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(double _lot,long _sl_point,long _tp_point,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_point);
   this.request.tp= this.long_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(double _lot,long _sl_point,long _tp_point,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_point);
   this.request.tp= this.short_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(double _lot,double _sl_price,double _tp_price,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_price);
   this.request.tp= this.long_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(double _lot,double _sl_price,double _tp_price,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_price);
   this.request.tp= this.short_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(long _sl_point,long _tp_point,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_point);
   this.request.tp= this.long_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(long _sl_point,long _tp_point,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_point);
   this.request.tp= this.short_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(double _sl_price,double _tp_price,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_price);
   this.request.tp= this.long_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(double _sl_price,double _tp_price,string _comment)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_price);
   this.request.tp= this.short_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=_comment;
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(double _lot,long _sl_point,long _tp_point)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_point);
   this.request.tp= this.long_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=this.get_long_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(double _lot,long _sl_point,long _tp_point)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_point);
   this.request.tp= this.short_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=this.get_short_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(double _lot,double _sl_price,double _tp_price)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_price);
   this.request.tp= this.long_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=this.get_long_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(double _lot,double _sl_price,double _tp_price)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_price);
   this.request.tp= this.short_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= _lot;
   this.request.comment=this.get_short_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(long _sl_point,long _tp_point)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_point);
   this.request.tp= this.long_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=this.get_long_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(long _sl_point,long _tp_point)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_point);
   this.request.tp= this.short_small_tp_price(_tp_point);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=this.get_short_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool    symbol_trade::open_buy(double _sl_price,double _tp_price)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_BUY;
   this.request.symbol= this.get_symbol();
   this.request.price=this.ask();
   this.request.sl= this.long_small_sl_price(_sl_price);
   this.request.tp= this.long_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=this.get_long_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
bool  symbol_trade::open_sell(double _sl_price,double _tp_price)
  {
   ZeroMemory(this.request);
   ZeroMemory(this.result);
//--填充交易参数
   this.request.action= TRADE_ACTION_DEAL;
   this.request.type = ORDER_TYPE_SELL;
   this.request.symbol= this.get_symbol();
   this.request.price= this.bid();
   this.request.sl= this.short_small_sl_price(_sl_price);
   this.request.tp= this.short_small_tp_price(_tp_price);
   this.request.type_filling= this.get_type_filling();
   this.request.deviation = this.get_dev();
   this.request.magic= this.get_magic();
   this.request.volume= this.get_lot();
   this.request.comment=this.get_short_comment();
   bool res = OrderSend(this.request,this.result);
   if(!res)
      res = OrderSend(this.request,this.result);
   if(!res)
      print_error(__FUNCTION__);
   return res;
  };
//+------------------------------------------------------------------+
double    symbol_trade::long_small_sl_price(double _sl_price=0)
  {
   if(_sl_price==0)
      return 0;
   double price = this.ask() - (double)SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_STOPS_LEVEL)*this.get_point();
   if(_sl_price>0 && _sl_price>price)
      _sl_price = price;
   return  _sl_price;
  }
//+------------------------------------------------------------------+
double    symbol_trade::long_small_tp_price(double _tp_price=0)
  {
   if(_tp_price==0)
      return 0;
   double price = this.ask() + (double)SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_STOPS_LEVEL)*this.get_point();
   if(_tp_price>0 && _tp_price<price)
      _tp_price = price;
   return  _tp_price;
  }
//+------------------------------------------------------------------+
double   symbol_trade::short_small_sl_price(double _sl_price=0)
  {
   if(_sl_price==0)
      return 0;
   double price = this.bid() + (double)SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_STOPS_LEVEL)*this.get_point();
   if(_sl_price>0 && _sl_price<price)
      _sl_price = price;
   return  _sl_price;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double   symbol_trade::short_small_tp_price(double _tp_price=0)
  {
   if(_tp_price==0)
      return 0;
   double price = this.bid() - (double)SymbolInfoInteger(this.get_symbol(),SYMBOL_TRADE_STOPS_LEVEL)*this.get_point();
   if(_tp_price>0 && _tp_price>price)
      _tp_price = price;
   return  _tp_price;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double    symbol_trade::long_small_sl_price(long _sl_point=0)
  {
   if(_sl_point==0)
      return 0;
   return  this.ask() - this.stop_loss(_sl_point) * this.get_point();
  }
//+------------------------------------------------------------------+
double    symbol_trade::long_small_tp_price(long _tp_point=0)
  {
   if(_tp_point==0)
      return 0;
   return this.ask() + this.stop_loss(_tp_point) *this.get_point();
  }
//+------------------------------------------------------------------+
double   symbol_trade::short_small_sl_price(long _sl_point=0)
  {
   if(_sl_point==0)
      return 0;
   return this.bid() + this.stop_loss(_sl_point) *this.get_point();
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double   symbol_trade::short_small_tp_price(long _tp_point=0)
  {
   if(_tp_point==0)
      return 0;
   return this.bid() - this.stop_loss(_tp_point) *this.get_point();
  }
//+------------------------------------------------------------------+
void symbol_trade::print_error(string _msg)
  {
   Print(_msg,"__last-error: ",IntegerToString(GetLastError()),"__return-error:",IntegerToString(this.result.retcode),"!!!"); // 显示错误
  }
//+------------------------------------------------------------------+
bool symbol_trade::marginOK(double _tradePct = 30)
  {
   double one_lot_price;                                                //交易一手所需的预付款
   double act_f_mag     = AccountInfoDouble(ACCOUNT_MARGIN_FREE);        //帐户的可用预付款
   long   levrage       = AccountInfoInteger(ACCOUNT_LEVERAGE);          //帐户的杠杆
   double contract_size = SymbolInfoDouble(this.get_symbol(),SYMBOL_TRADE_CONTRACT_SIZE);  //一手合约的大小
   string base_currency = SymbolInfoString(this.get_symbol(),SYMBOL_CURRENCY_BASE);        //当前货币对的基础货币                                                                          //
   if(base_currency=="USD")
      one_lot_price=contract_size/levrage;
   else
     {
      double bprice= SymbolInfoDouble(this.get_symbol(),SYMBOL_BID);
      one_lot_price=bprice*contract_size/levrage;
     }
// 根据设置，检查交易所需的预付款是否足够
   if(MathFloor(this.lot*one_lot_price)>MathFloor(act_f_mag*_tradePct))
      return false;
   else
      return true;
  }
//----
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void         symbol_trade::close_order_comment()
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY&&PositionGetString(POSITION_COMMENT)==this.get_long_comment())
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_SELL;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_BID);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL&&PositionGetString(POSITION_COMMENT)==this.get_short_comment())
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_BUY;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_ASK);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+
void         symbol_trade::close_long_order_comment()
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY&&PositionGetString(POSITION_COMMENT)==this.get_long_comment())
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_SELL;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_BID);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void         symbol_trade::close_short_order_comment()
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL&&PositionGetString(POSITION_COMMENT)==this.get_short_comment())
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_BUY;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_ASK);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void         symbol_trade::close_order()
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_SELL;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_BID);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_BUY;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_ASK);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+
void         symbol_trade::close_long_order()
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_SELL;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_BID);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void         symbol_trade::close_short_order()
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_BUY;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_ASK);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+
void         symbol_trade::close_order(string _comment)
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY&&PositionGetString(POSITION_COMMENT)== _comment)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_SELL;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_BID);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL&&PositionGetString(POSITION_COMMENT)== _comment)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_BUY;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_ASK);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+
void         symbol_trade::close_long_order(string _comment)
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY&&PositionGetString(POSITION_COMMENT)==_comment)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_SELL;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_BID);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void         symbol_trade::close_short_order(string _comment)
  {
   int total =PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
        {
         if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL&&PositionGetString(POSITION_COMMENT)==_comment)
           {
            ZeroMemory(this.request);
            ZeroMemory(this.result);
            this.request.action=TRADE_ACTION_DEAL;
            this.request.type=ORDER_TYPE_BUY;
            this.request.position=PositionGetInteger(POSITION_TICKET);
            this.request.symbol=PositionGetString(POSITION_SYMBOL);
            this.request.volume=PositionGetDouble(POSITION_VOLUME);
            this.request.magic=PositionGetInteger(POSITION_MAGIC);
            this.request.comment=PositionGetString(POSITION_COMMENT);
            this.request.price=SymbolInfoDouble(this.request.symbol,SYMBOL_ASK);
            this.request.type_filling=this.get_type_filling();
            this. request.deviation=this.get_dev();
            bool res=OrderSendAsync(this.request,this.result);
            if(!res)
               res=OrderSendAsync(this.request,this.result);
            if(!res)
               this.print_error(__FUNCTION__);
           }
        }
  };
//+------------------------------------------------------------------+
bool  symbol_trade::tim_k_chk1(ENUM_TIMEFRAMES _period=PERIOD_CURRENT)
  {
   datetime tim_c = iTime(this.get_symbol(),_period,0);
   if(tim_c > this.get_time_k_chk1())
     {
      return true;
      this.set_time_k_chk1(tim_c);
     }
   return false;
  }
//+------------------------------------------------------------------+
bool  symbol_trade::tim_k_chk2(ENUM_TIMEFRAMES _period=PERIOD_CURRENT)
  {
   datetime tim_c = iTime(this.get_symbol(),_period,0);
   if(tim_c > this.get_time_k_chk2())
     {
      return true;
      this.set_time_k_chk2(tim_c);
     }
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//---订单类型选择 -1 选择所有  0 选择多 1选择空
//+------------------------------------------------------------------+
bool symbol_trade::position_order_type_choose(int _type_choose)
  {
   if(_type_choose == -1)
      return true;
   if((int)PositionGetInteger(POSITION_TYPE)== _type_choose)
      return true;
   if((int)PositionGetInteger(POSITION_TYPE)== _type_choose)
      return true;
   return false;
  }
//+------------------------------------------------------------------+
//获取订单integer属性
//+------------------------------------------------------------------+
long  symbol_trade::position_last_order_ticket(long _start_tim,long _end_tim,int _type_choose=-1)
  {
   int total = PositionsTotal()-1;
   for(int i = total; i>=0; i--)
      if(PositionGetTicket(i)>0&&position_order_type_choose(_type_choose)&&PositionGetInteger(POSITION_TIME)>_start_tim&&PositionGetInteger(POSITION_TIME)<_end_tim)
         if(PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
            return PositionGetInteger(POSITION_TICKET);
   return 0;
  }
//+------------------------------------------------------------------+
long  symbol_trade::position_last_order_ticket(int _type_choose=-1)
  {
   int total = PositionsTotal()-1;
   for(int i=total; i>=0; i--)
      if(PositionGetTicket(i)>0&&position_order_type_choose(_type_choose))
         if(PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
            return PositionGetInteger(POSITION_TICKET);
   return 0;
  }
//+------------------------------------------------------------------+
long  symbol_trade::position_first_order_ticket(long _start_tim,long _end_tim,int _type_choose=-1)
  {
   int total =PositionsTotal()-1;
   for(int i=0; i<=total; i++)
      if(PositionGetTicket(i)>0&&position_order_type_choose(_type_choose)&&PositionGetInteger(POSITION_TIME)>_start_tim&&PositionGetInteger(POSITION_TIME)<_end_tim)
         if(PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
            return PositionGetInteger(POSITION_TICKET);
   return 0;
  }
//+------------------------------------------------------------------+
long  symbol_trade::position_first_order_ticket(int _type_choose=-1)
  {
   int total =PositionsTotal()-1;
   for(int i=0; i<=total; i++)
      if(PositionGetTicket(i)>0&&position_order_type_choose(_type_choose))
         if(PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
            return PositionGetInteger(POSITION_TICKET);
   return 0;
  }
//+------------------------------------------------------------------+
//获取订单integer属性
//+------------------------------------------------------------------+
long  symbol_trade::position_order_integer_property(long _ticket,ENUM_POSITION_PROPERTY_INTEGER _integer_property)
  {
   int total = PositionsTotal()-1;
   for(int i = total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetInteger(POSITION_TICKET)==_ticket)
         return PositionGetInteger(_integer_property);
   if(_integer_property==POSITION_TYPE)
      return -1;
   return 0;
  }
//+------------------------------------------------------------------+
//获取订单double属性
//+------------------------------------------------------------------+
double   symbol_trade::position_order_double_property(long _ticket,ENUM_POSITION_PROPERTY_DOUBLE _double_property)
  {
   int total = PositionsTotal()-1;
   for(int i = total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetInteger(POSITION_TICKET)==_ticket)
         return PositionGetDouble(_double_property);
   return 0;
  }
//+------------------------------------------------------------------+
//获取订单string属性
//+------------------------------------------------------------------+
string   symbol_trade::position_order_string_property(long _ticket,ENUM_POSITION_PROPERTY_STRING _string_property)
  {
   int total = PositionsTotal()-1;
   for(int i = total; i>=0; i--)
      if(PositionGetTicket(i)>0&&PositionGetInteger(POSITION_TICKET)==_ticket)
         return PositionGetString(_string_property);
   return "-1";
  }
//----
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool symbol_trade::history_order_type_choose(ulong _deal_ticket,int _type_choose=-1)
  {
   if(_type_choose == -1)
      return true;
   if((int)HistoryDealGetInteger(_deal_ticket,DEAL_TYPE)== _type_choose)
      return true;
   if((int)HistoryDealGetInteger(_deal_ticket,DEAL_TYPE)== _type_choose)
      return true;
   return false;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//---获取历史尾单订单号
//+------------------------------------------------------------------+
ulong  symbol_trade:: history_last_order_ticket(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=history_total; i>=0; i--)
     {
      ulong  ticket = HistoryDealGetTicket(i);
      if(ticket>0&&HistoryDealGetInteger(ticket,DEAL_ENTRY)==_deal_int_out&&history_order_type_choose(ticket,_type_choose))
         if(HistoryDealGetString(ticket,DEAL_SYMBOL)==this.get_symbol()&&HistoryDealGetInteger(ticket,DEAL_MAGIC)==this.get_magic())
            return HistoryDealGetInteger(ticket,DEAL_TICKET);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//---获取历史尾单订单号
//+------------------------------------------------------------------+
ulong  symbol_trade:: history_last_order_position_id(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=history_total; i>=0; i--)
     {
      ulong  ticket = HistoryDealGetTicket(i);
      if(ticket>0&&HistoryDealGetInteger(ticket,DEAL_ENTRY)==_deal_int_out&&history_order_type_choose(ticket,_type_choose))
         if(HistoryDealGetString(ticket,DEAL_SYMBOL)==this.get_symbol()&&HistoryDealGetInteger(ticket,DEAL_MAGIC)==this.get_magic())
            return HistoryDealGetInteger(ticket,DEAL_POSITION_ID);
     }
   return 0;
  }
//---
ulong  symbol_trade:: history_first_order_ticket(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=0; i<=history_total; i++)
     {
      ulong  ticket = HistoryDealGetTicket(i);
      if(ticket>0&&HistoryDealGetInteger(ticket,DEAL_ENTRY)==_deal_int_out&&history_order_type_choose(ticket,_type_choose))
         if(HistoryDealGetString(ticket,DEAL_SYMBOL)==this.get_symbol()&&HistoryDealGetInteger(ticket,DEAL_MAGIC)==this.get_magic())
            return HistoryDealGetInteger(ticket,DEAL_TICKET);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//---获取历史尾单订单号
//+------------------------------------------------------------------+
ulong  symbol_trade:: history_first_order_position_id(ENUM_DEAL_ENTRY _deal_int_out=DEAL_ENTRY_OUT,int _type_choose=-1)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=0; i<=history_total; i++)
     {
      ulong  ticket = HistoryDealGetTicket(i);
      if(ticket>0&&HistoryDealGetInteger(ticket,DEAL_ENTRY)==_deal_int_out&&history_order_type_choose(ticket,_type_choose))
         if(HistoryDealGetString(ticket,DEAL_SYMBOL)==this.get_symbol()&&HistoryDealGetInteger(ticket,DEAL_MAGIC)==this.get_magic())
            return HistoryDealGetInteger(ticket,DEAL_POSITION_ID);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//---历史订单属性值
//+------------------------------------------------------------------+
ulong  symbol_trade::history_order_integer_property(ulong _deal_ticket,ENUM_DEAL_PROPERTY_INTEGER _integer_property)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=history_total; i>=0; i--)
      if(HistoryDealGetTicket(i)>0&&HistoryDealGetTicket(i)== _deal_ticket)
         return HistoryDealGetInteger(_deal_ticket,_integer_property);
   if(_integer_property == DEAL_TYPE)
      return -1;
   return 0;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double symbol_trade::history_order_double_property(ulong _deal_ticket,ENUM_DEAL_PROPERTY_DOUBLE _double_property)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=history_total; i>=0; i--)
      if(HistoryDealGetTicket(i)>0&&HistoryDealGetTicket(i)== _deal_ticket)
         return HistoryDealGetDouble(_deal_ticket,_double_property);
   return 0;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string symbol_trade::history_order_string_property(ulong _deal_ticket,ENUM_DEAL_PROPERTY_STRING _string_property)
  {
   int history_total = HistoryDealsTotal()-1;
   for(int i=history_total; i>=0; i--)
      if(HistoryDealGetTicket(i)>0&&HistoryDealGetTicket(i) == _deal_ticket)
         return  HistoryDealGetString(_deal_ticket,_string_property);
   return "-1";
  }
//+------------------------------------------------------------------+
//---持仓属性值之和
//+------------------------------------------------------------------+
int symbol_trade::position_order_sum(int _type_choose=-1)
  {
   int total=PositionsTotal()-1;
   int cnt=0;
   for(int i=total; i>=0; i--)
     {
      if(PositionGetTicket(i)>0&&position_order_type_choose(_type_choose))
         if(PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
            cnt++;
     }
   return cnt;
  };
//+------------------------------------------------------------------+
//---double属性值之和
//+------------------------------------------------------------------+
double symbol_trade::position_order_double_property_sum(ENUM_POSITION_PROPERTY_DOUBLE _double_property,int _type_choose=-1)
  {
   int total=PositionsTotal()-1;
   double sum=0;
   for(int i=total; i>=0; i--)
     {
      if(PositionGetTicket(i)>0&&position_order_type_choose(_type_choose))
         if(PositionGetString(POSITION_SYMBOL)==this.get_symbol()&&PositionGetInteger(POSITION_MAGIC)==this.get_magic())
            sum = sum + PositionGetDouble(_double_property);
     }
   return sum;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double   symbol_trade::lot_adaptive(double _lots)
  {
   _lots = NormalizeDouble(_lots,2);
   double  mini_lots= SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_MIN);
   if(_lots < mini_lots)
      return mini_lots;
   double  max_lots= SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_MAX);
   if(_lots > max_lots)
      return max_lots;
   _lots = NormalizeVolume(_lots);
   return _lots;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
double   symbol_trade::lot_adaptive_zero(double _lots)
  {
   _lots = NormalizeDouble(_lots,2);
   double  mini_lots= SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_MIN);
   if(_lots < mini_lots)
      return 0;
   double  max_lots= SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_MAX);
   if(_lots > max_lots)
      return max_lots;
   _lots = NormalizeVolume(_lots);
   return _lots;
  }
//+------------------------------------------------------------------+
//---手数自适应
//+------------------------------------------------------------------+
double symbol_trade::NormalizeVolume(double _lot)
  {
   if(lot<0.1)
      return(MathCeil(_lot/SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_MIN))*SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_MIN));
   if(lot>=0.1)
     {
      int j=0;
      if(SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_STEP)<10)
         j=0;
      if(SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_STEP)<1)
         j=1;
      if(SymbolInfoDouble(this.get_symbol(),SYMBOL_VOLUME_STEP)<0.1)
         j=2;
      return(NormalizeDouble(_lot,j));
     }
   return(0);
  }
//+------------------------------------------------------------------+
//锁仓
//+------------------------------------------------------------------+
void symbol_trade::lots_lock(double _long_lots,double _short_lots,long _sl_point,long _tp_point,string _comment)
  {
   if(_long_lots - _short_lots>0)
      open_sell(lot_adaptive_zero(_long_lots - _short_lots),_sl_point,_tp_point,_comment);
   if(_short_lots - _long_lots>0)
      open_buy(lot_adaptive_zero(_short_lots - _long_lots),_sl_point,_tp_point,_comment);
  }
//+------------------------------------------------------------------+
void symbol_trade::long_lots_lock(double _long_lots,double _short_lots,long _sl_point,long _tp_point,string _comment)
  {
   if(_long_lots - _short_lots>0)
      open_sell(lot_adaptive_zero(_long_lots - _short_lots),_sl_point,_tp_point,_comment);
  }
//+------------------------------------------------------------------+
void symbol_trade::short_lots_lock(double _long_lots,double _short_lots,long _sl_point,long _tp_point,string _comment)
  {
   if(_short_lots - _long_lots>0)
      open_buy(lot_adaptive_zero(_short_lots - _long_lots),_sl_point,_tp_point,_comment);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool symbol_trade::yin_yang_chk(int _choose_yin_yang,int _index=1)
  {
   if(_choose_yin_yang==1&&iClose(this.get_symbol(),this.get_period(),_index)<iOpen(this.get_symbol(),this.get_period(),_index))
      return true;
   if(_choose_yin_yang==2&&iClose(this.get_symbol(),this.get_period(),_index)>iOpen(this.get_symbol(),this.get_period(),_index))
      return true;
   return false;
  }
//---
//+------------------------------------------------------------------+
bool symbol_trade::yin_yang_2_chk(int _choose_yin_yang,int _index=1)
  {
   if(_choose_yin_yang==1&&this.yin_yang_chk(_choose_yin_yang,_index)&&this.yin_yang_chk(_choose_yin_yang,_index+1))
      return true;
   if(_choose_yin_yang==2&&this.yin_yang_chk(_choose_yin_yang,_index)&&this.yin_yang_chk(_choose_yin_yang,_index+1))
      return true;
   return false;
  }
//-------
bool symbol_trade::yin_yang_3_chk(int _choose_yin_yang,int _index=1)
  {
   if(_choose_yin_yang==1&&this.yin_yang_chk(_choose_yin_yang,_index)&&this.yin_yang_chk(_choose_yin_yang,_index+1)&&this.yin_yang_chk(_choose_yin_yang,_index+2))
      return true;
   if(_choose_yin_yang==2&&this.yin_yang_chk(_choose_yin_yang,_index)&&this.yin_yang_chk(_choose_yin_yang,_index+1)&&this.yin_yang_chk(_choose_yin_yang,_index+2))
      return true;
   return false;
  }
//+------------------------------------------------------------------+
bool symbol_trade::continuous_yin_yang_2_chk(int _choose_yin_yang,int _index=1)
  {
   if(_choose_yin_yang==1&&yin_yang_2_chk(_choose_yin_yang,_index)&&iClose(this.get_symbol(),this.get_period(),_index)<iClose(this.get_symbol(),this.get_period(),_index+1))
      return true;
   if(_choose_yin_yang==2&&yin_yang_2_chk(_choose_yin_yang,_index)&&iClose(this.get_symbol(),this.get_period(),_index)>iClose(this.get_symbol(),this.get_period(),_index+1))
      return true;
   return false;
  }
//-------
bool symbol_trade::continuous_yin_yang_3_chk(int _choose_yin_yang,int _index=1)
  {
   if(_choose_yin_yang==1&&yin_yang_3_chk(_choose_yin_yang, _index)
      &&iClose(this.get_symbol(),this.get_period(),_index)<iClose(this.get_symbol(),this.get_period(),_index+1)
      &&iClose(this.get_symbol(),this.get_period(),_index+1)<iClose(this.get_symbol(),this.get_period(),_index+2))
      return true;
   if(_choose_yin_yang==2&&yin_yang_3_chk(_choose_yin_yang, _index)
      &&iClose(this.get_symbol(),this.get_period(),_index)>iClose(this.get_symbol(),this.get_period(),_index+1)
      &&iClose(this.get_symbol(),this.get_period(),_index+1)>iClose(this.get_symbol(),this.get_period(),_index+2))
      return true;
   return false;
  }
//+------------------------------------------------------------------+
bool       symbol_trade::tp_profits_close_orders(double _profits,double _tp_profits)
  {
   if(_tp_profits>0)
      if(_profits >=_tp_profits)
        {
         close_order();
         return true;
        }
   return false;
  };
//+------------------------------------------------------------------+
bool       symbol_trade::tp_profits_close_long_orders(double _profits,double _tp_profits)
  {
   if(_tp_profits>0)
      if(_profits >=_tp_profits)
        {
         close_long_order();
         return true;
        }
   return false;
  };
//+------------------------------------------------------------------+
bool       symbol_trade::tp_profits_close_short_orders(double _profits,double _tp_profits)
  {
   if(_tp_profits>0)
      if(_profits >=_tp_profits)
        {
         close_short_order();
         return true;
        }
   return false;
  };
//+------------------------------------------------------------------+
bool           symbol_trade::sl_profits_close_orders(double _profits,double _sl_profits)
  {
   if(_sl_profits<0)
      if(_profits<=_sl_profits)
        {
         close_order();
         return true;
        }
   return false;
  };
//+------------------------------------------------------------------+
bool           symbol_trade::sl_profits_close_long_orders(double _profits,double _sl_profits)
  {
   if(_sl_profits<0)
      if(_profits<=_sl_profits)
        {
         close_long_order();
         return true;
        }
   return false;
  };
//+------------------------------------------------------------------+
bool           symbol_trade::sl_profits_close_short_orders(double _profits,double _sl_profits)
  {
   if(_sl_profits<0)
      if(_profits<=_sl_profits)
        {
         close_short_order();
         return true;
        }
   return false;
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
