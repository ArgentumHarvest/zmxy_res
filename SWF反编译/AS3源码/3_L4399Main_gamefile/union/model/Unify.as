package union.model
{
   import config.Config;
   import export.rank.RankPropertyCount;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import manager.PayManager;
   import union.utils.UnionConfig;
   import union.view.AgainView;
   
   public class Unify
   {
       
      
      public function Unify()
      {
         super();
      }
      
      public static function objectToArray(obj:Object) : Array
      {
         var arr:Array = [];
         for(var name in obj)
         {
            arr.push(obj[name]);
         }
         return arr;
      }
      
      public static function getRect(w:Number, h:Number, c:Number = 0, x:Number = 0, y:Number = 0, a:Number = 1) : Sprite
      {
         var s:Sprite = new Sprite();
         s.graphics.beginFill(c);
         s.graphics.drawRect(x,y,w,h);
         s.graphics.endFill();
         s.alpha = a;
         return s;
      }
      
      public static function getSprBtn(parent:DisplayObjectContainer, str:String, x:int, y:int) : Sprite
      {
         var rect:Sprite = getRect(90,25,16777215);
         var txt:TextField = TextManager.createTextField(0,0,90,25,"center",16);
         txt.text = str;
         rect.addChild(txt);
         rect.x = x;
         rect.y = y;
         parent.addChild(rect);
         return rect;
      }
      
      public static function show(... arg) : void
      {
         var i:int = 0;
         if(arg[0] is Array)
         {
            for(i = 0; i < arg[0].length; arg[0][i].visible = true,i++)
            {
            }
         }
         else
         {
            for(i = 0; i < arg.length; arg[i].visible = true,i++)
            {
            }
         }
      }
      
      public static function hide(... arg) : void
      {
         var i:int = 0;
         if(arg[0] is Array)
         {
            for(i = 0; i < arg[0].length; arg[0][i].visible = false,i++)
            {
            }
         }
         else
         {
            for(i = 0; i < arg.length; arg[i].visible = false,i++)
            {
            }
         }
      }
      
      public static function arraySortByParam(array:Array, param:String, isReverse:Boolean = false) : void
      {
         array.sortOn(param,16);
         if(isReverse)
         {
            array.reverse();
         }
      }
      
      public static function showUnionNum(count:int, level:int) : String
      {
         return count + "/" + UnionConfig.getUnionMembers(level);
      }
      
      public static function getDateByTime(time:Number) : Date
      {
         return new Date(time);
      }
      
      public static function dateToFormat(time:*, type:String = "-") : String
      {
         if(String(time).length < 13)
         {
            time *= 1000;
         }
         var date:Date = getDateByTime(time);
         return date.fullYear + type + (int(date.month + 1)) + type + date.date;
      }
      
      public static function arrayPart(array:Array, pageCurr:int, onePageNum:* = 6) : Array
      {
         var i:int = 0;
         var j:int = 0;
         var arr:Array = [];
         for(i = 0; i < onePageNum; )
         {
            j = (pageCurr - 1) * onePageNum + i;
            if(j < array.length)
            {
               arr.push(array[j]);
            }
            i++;
         }
         return arr;
      }
      
      public static function alert(tip:String) : void
      {
         gc.ts.setTxt(tip);
         gc.stage.addChild(gc.ts);
      }
      
      public static function getTeam(extra:String) : String
      {
         var da:* = null;
         try
         {
            da = JSON.parse(extra);
            return getTeamByIndex(da.team);
         }
         catch(errObject:Error)
         {
            return "无";
         }
      }
      
      public static function getTeamByIndex(index:int) : String
      {
         var teamName:Array = ["白虎","朱雀","玄武","青龙"];
         return teamName[index] || "无";
      }
      
      public static function get gc() : Config
      {
         return Config.getInstance();
      }
      
      public static function get uid() : int
      {
         return gc.logInfo.uid;
      }
      
      public static function uidIsMySelf(uid:Number) : Boolean
      {
         return uid == Unify.uid;
      }
      
      public static function log(... value) : void
      {
         try
         {
            ExternalInterface.call("console.log",value);
         }
         catch(errObject:Error)
         {
            trace(value);
         }
      }
      
      public static function get ticket() : Number
      {
         return gc.gameVip.dataObject.lastMoney;
      }
      
      public static function get sprite() : Number
      {
         return gc.player1.getLhValue();
      }
      
      public static function get showTicket() : String
      {
         return "点券：" + ticket;
      }
      
      public static function get showSprite() : String
      {
         return "灵魂：" + sprite;
      }
      
      public static function checkSprite(value:int) : Boolean
      {
         if(sprite >= value)
         {
            return true;
         }
         alert("灵魂不足");
         return false;
      }
      
      public static function checkTicket(value:int) : Boolean
      {
         if(ticket >= value)
         {
            return true;
         }
         alert("点券不足");
         return false;
      }
      
      public static function getJsonData(str:String) : Object
      {
         try
         {
            return JSON.parse(str);
         }
         catch(e:*)
         {
            return {};
         }
      }
      
      public static function removeTicket(value:int) : void
      {
         gc.gameVip.dataObject.lastMoney = ticket - value;
         gc.pay.money = value;
         PayManager.getInstance().pay(34,"道具34",value,1);
      }
      
      public static function removeSprite(value:int) : void
      {
         gc.player1.setLhValue(sprite - value);
      }
      
      public static function addItem(name:String, num:int = 1) : void
      {
         gc.putQhsInBackPack(gc.player1,name,num);
      }
      
      public static function removeItem(name:String, num:int = 1) : void
      {
         gc.player1.removeSomeEquip(name,num);
      }
      
      public static function bagHasItem(name:String) : Boolean
      {
         return Unify.gc.player1.getSomeEquipInPackBackByName(name);
      }
      
      public static function saveData() : void
      {
         if(gc.luanqibazaojiami)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      public static function get fightPower() : int
      {
         return RankPropertyCount.getFightingForce(Unify.gc.player1);
      }
      
      public static function message(value:String, ... newVal) : String
      {
         var name:String = "num";
         if(newVal is String || newVal is Number)
         {
            value = value.replace(name,newVal);
         }
         else if(newVal is Array)
         {
            value = getReplaces(value,newVal);
         }
         return value;
      }
      
      public static function getReplaces(value:String, names:Array, name:String = "num") : String
      {
         var i:int = 0;
         var name2:* = null;
         for(i = 0; i < names.length; )
         {
            name2 = names[i];
            value = value.replace(name,name2);
            i++;
         }
         return value;
      }
      
      public static function again(tips:String, callBack:Function, assetName:String = "Union.swf") : void
      {
         var view:AgainView = new AgainView(assetName);
         view.callBack = callBack;
         view.message = tips;
         GMain.getInstance().getTopSence().addChild(view);
      }
   }
}
