//+------------------------------------------------------------------+
//|                                              ObjetosGraficos.mqh |
//|                                                  Christian Kedor |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Christian Kedor"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "EnumsEStructs.mqh"


class CObjetosGraficos
{
private:

public:
   CObjetosGraficos();
   ~CObjetosGraficos();
   
   string listaObjetos[];
   
   //Linhas
   void DesenhaLinhaHorizontal(string nome, color cor, datetime x1, datetime x2, double y);
   void DesenhaLinhaHorizontalFull(string nome, color cor, double price);
   void DesenhaLinhaVertical(string nome, color cor, double y1, double y2, datetime x);
   void DesenhaLinhaVerticalFull(string nome, color cor, datetime dt);
   
   //Escrita
   void EscreveNaTela(string nome, color cor, string conteudo, datetime x, double y);
   
   //Especificicos
   void DesenhaLinhaReferencia(datetime time, double valor, color cor);
   void DesenhaStops(double stopLoss, double takeProfit1, double takeProfit2, datetime time);
   void DesenhaLinhaDia(string nome, datetime time);
};


CObjetosGraficos::CObjetosGraficos()
{
}
CObjetosGraficos::~CObjetosGraficos()
{
}


/*==================================== Genéricos ========================================*\ 
\*=======================================================================================*/    

void CObjetosGraficos::DesenhaLinhaHorizontal(string nome, color cor, datetime x1, datetime x2, double y)
{
   ObjectDelete(0, nome);
   ObjectCreate(0, nome, OBJ_TREND, 0, x1, y, x2, y);
   ObjectSetInteger(0,nome, OBJPROP_COLOR, cor);  
}

void CObjetosGraficos::DesenhaLinhaHorizontalFull(string nome, color cor, double price)
{  
   ObjectDelete(0, nome);
   ObjectCreate(0, nome, OBJ_HLINE, 0, 0, price);
   ObjectSetInteger(0,nome, OBJPROP_COLOR, cor); 
}

void CObjetosGraficos::DesenhaLinhaVertical(string nome, color cor, double y1, double y2, datetime x)
{ 
   ObjectDelete(0, nome);
   ObjectCreate(0, nome, OBJ_TREND, 0, x, y1, x, y1);
   ObjectSetInteger(0,nome, OBJPROP_COLOR, cor); 

}

void CObjetosGraficos::DesenhaLinhaVerticalFull(string nome, color cor, datetime dt)
{ 
   ObjectCreate(0, nome, OBJ_VLINE, 0, dt, 0);
   ObjectSetInteger(0,nome, OBJPROP_COLOR, cor); 
}

void CObjetosGraficos::EscreveNaTela(string nome, color cor, string conteudo, datetime x, double y)
{
   ObjectDelete(0, nome);
   ObjectCreate(0, nome, OBJ_TEXT, 0, x, y);
   ObjectSetString(0, nome, OBJPROP_TEXT, conteudo);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor);
}


/*==================================== Especificos ========================================*\ 
\*=======================================================================================*/  
void CObjetosGraficos::DesenhaLinhaReferencia(datetime time, double valor, color cor)
{
   this.DesenhaLinhaHorizontal(REFERENCIA, cor, time, time+_Period*60*2, valor);
   ObjectSetInteger(0,REFERENCIA, OBJPROP_WIDTH, 3);
}

void CObjetosGraficos::DesenhaStops(double stopLoss, double takeProfit1, double takeProfit2, datetime time)
{ 
   color cor;
   if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY){
      cor = CLR_COMPRA;
   }
   else{
      cor = CLR_VENDA;
   }
   
   this.DesenhaLinhaHorizontal(STOP_LOSS, cor, time - _Period*60, time + _Period*60, stopLoss);
   ObjectSetInteger(0,STOP_LOSS, OBJPROP_WIDTH, 3);
   this.DesenhaLinhaHorizontal(TAKE_PROFIT_1, cor, time - _Period*60, time + _Period*60, takeProfit1);
   ObjectSetInteger(0,STOP_LOSS, OBJPROP_WIDTH, 3);
   this.DesenhaLinhaHorizontal(TAKE_PROFIT_2, cor, time - _Period*60, time + _Period*60, takeProfit2); 
   ObjectSetInteger(0,STOP_LOSS, OBJPROP_WIDTH, 3); 
}

void CObjetosGraficos::DesenhaLinhaDia(string nome, datetime time)
{
   this.DesenhaLinhaVerticalFull(nome, clrAntiqueWhite, time);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 4);
}

////void SetPanel(string name, int sub_window, int xx, int yy, int width, int height, color borderColor, color backgroundColor, int borderWidth)
////{
////   ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, sub_window, 0, 0);
////   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, xx);
////   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, yy);
////   ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
////   ObjectSetInteger(0, name, OBJPROP_YSIZE, height);
////   ObjectSetInteger(0, name, OBJPROP_COLOR, borderColor);
////   ObjectSetInteger(0, name, OBJPROP_BGCOLOR, backgroundColor);
////   ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE, BORDER_FLAT);
////   ObjectSetInteger(0, name, OBJPROP_WIDTH, borderWidth);
////   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
////   ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
////   ObjectSetInteger(0, name, OBJPROP_BACK, false);
////   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,0);
////   ObjectSetInteger(0, name, OBJPROP_SELECTED,0);
////   ObjectSetInteger(0, name, OBJPROP_HIDDEN, true);
////   ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
////}
////
//void SetText(string name, string text, string font, int sub_window, int xx, int yy, color cor, int fontSize)
//{
//   ObjectCreate(0, name, OBJ_LABEL, sub_window, 0, 0);
//   ObjectSetInteger(0, name, OBJPROP_XDISTANCE, xx);
//   ObjectSetInteger(0, name, OBJPROP_YDISTANCE, yy);
//   ObjectSetString(0, name, OBJPROP_TEXT, text);
//   ObjectSetInteger(0, name, OBJPROP_COLOR, cor);
//   ObjectSetInteger(0, name, OBJPROP_FONTSIZE, fontSize);
//   ObjectSetString(0, name, OBJPROP_FONT, font);
//   ObjectSetInteger(0, name, OBJPROP_BACK, false);
//   ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
//   ObjectSetInteger(0, name, OBJPROP_ZORDER, 1);
//}


//   if (_id == CHARTEVENT_OBJECT_CLICK){
//      bool pressed = ObjectGetInteger(0, "Button_1", OBJPROP_STATE);
//      
//      if(pressed && _sparam == "Button_1")
//      {
//         Print("O objeto clicado é o buton 1");
//      }
//
//   }



//   //panel.Create(0, "Painel_B", 0, 200, 200, 250, 250);
//   //panel.ColorBackground(clrRed);
//   //panel.Activate();
// 
//   appdialog.Create(0, "painel", 0, 40, 40, 400, 400);
//   
//   
//   label.Create(0, "Preco", 0, 10, 10, 40, 40);
//   label.Text("Meu Texto");
//   label.Color(clrRed);
//   appdialog.Add(label);
//   
//   label2.Create(0, "Valor", 0, 10, 30, 40, 40);
//   label2.Text(DoubleToString(candles[1].high));
//   label2.Color(clrBlue);
//   appdialog.Add(label2);
//   
//   ButtonCreate(0, "Button_1", 0, 20, 20, 200, 50, CORNER_LEFT_UPPER, "CLIQUE AQUI ", "Tahoma", 12);
//   SetText("Label", "Meu texto", "Tahoma", 0, 200, 200, clrRed, 14);
//   
//   
//   appdialog.Run();



//bool ButtonCreate(const long              chart_ID=0, 
//                  const string            name="Button",
//                  const int               subwindow=0, 
//                  const int               x=0,
//                  const int               y=0, 
//                  const int               width = 50,
//                  const int               height=18, 
//                  const ENUM_BASE_CORNER  corner = CORNER_LEFT_UPPER,
//                  const string            text="Button",
//                  const string            font="Arial",
//                  const int               font_size=10,
//                  const color             clr=clrBlack,
//                  const color             back_clr=C'236,233,216',
//                  const color             border_clr=clrNONE,  
//                  const bool             state=false,
//                  const bool              back=false,
//                  const bool              selection=false,
//                  const bool              hidden=true,
//                  const long              z_order=0)
//{
//   ResetLastError();
//   
//   if(!ObjectCreate(chart_ID, name, OBJ_BUTTON, subwindow, 0,0))
//   {
//      Print(__FUNCTION__, ": failed to create the button! Error code = ", GetLastError());
//      return(false);
//   }
//
//   ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
//   ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, x);
//   ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
//   ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
//   ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
//   ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
//   ObjectSetString(chart_ID, name, OBJPROP_FONT, font);
//   ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);
//   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
//   ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
//   ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);
//   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
//   ObjectSetInteger(chart_ID, name, OBJPROP_STATE, state);
//   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
//   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
//   ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
//   
//   return(true);
//
//}
//                  
  

