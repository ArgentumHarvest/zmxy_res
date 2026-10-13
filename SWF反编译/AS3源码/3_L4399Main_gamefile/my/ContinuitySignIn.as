package my
{
   import config.Config;
   
   public class ContinuitySignIn extends Singleton
   {
       
      
      private var gc:Config;
      
      private var _signedArray:Array;
      
      private const startDate:String = "2016-07-14";
      
      private var _continue5Times:Boolean = false;
      
      private var _continue15Times:Boolean = false;
      
      private var _continue30Times:Boolean = false;
      
      private var _continue50Times:Boolean = false;
      
      private var __sign5:uint = 5;
      
      private var __sign15:uint = 15;
      
      private var __sign30:uint = 30;
      
      private var __sign45:uint = 45;
      
      private var __totalDay:uint = 49;
      
      public function ContinuitySignIn()
      {
         _signedArray = [];
         super();
         gc = Config.getInstance();
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
      }
      
      public static function getIns() : ContinuitySignIn
      {
         return Singleton.getIns(ContinuitySignIn);
      }
      
      public function init() : void
      {
         signedArray.length = 0;
         this._continue5Times = false;
         this._continue15Times = false;
         this._continue30Times = false;
         this._continue50Times = false;
      }
      
      public function getMemData() : String
      {
         var prize:String = "" + (this._continue5Times == true ? "1" : "0") + (this._continue15Times == true ? "1" : "0") + (this._continue30Times == true ? "1" : "0") + (this._continue50Times == true ? "1" : "0");
         return prize + "|" + this.signedArray.join(",");
      }
      
      public function setMemData(data:String) : void
      {
         var i:* = 0;
         var len:* = 0;
         if(data == "")
         {
            this.init();
            return;
         }
         var ary:Array = data.split("|");
         var prize:String = ary[0];
         this._continue5Times = prize.charAt(0) == "1" ? true : false;
         this._continue15Times = prize.charAt(1) == "1" ? true : false;
         this._continue30Times = prize.charAt(2) == "1" ? true : false;
         this._continue50Times = prize.charAt(3) == "1" ? true : false;
         DebugArea.getIns().traceOut("ContinuitySignIn--setMemData-->prize.length:" + prize.length);
         if(ary[1] != "")
         {
            this._signedArray = ary[1].split(",");
         }
         else
         {
            this._signedArray = [];
         }
         for(i = uint(0),len = uint(this._signedArray.length); i < len; )
         {
            this._signedArray[i] = int(this._signedArray[i]);
            i++;
         }
      }
      
      public function signInToday() : Boolean
      {
         var today:String = gc.dataObjectInstance.curDate;
         trace("今天签到！日期：" + today);
         var dayDiff:int = this.getDayDiffFromStartDayToToday();
         if(dayDiff >= this.__totalDay || dayDiff < 0)
         {
            return false;
         }
         trace("距离签到的第一天有：" + dayDiff);
         if(this.signedArray.indexOf(dayDiff) == -1)
         {
            this.signedArray.push(dayDiff);
         }
         return true;
      }
      
      public function getDayDiffFromStartDayToToday() : int
      {
         return AUtils.getDayBetweenTwoDate("2016-07-14",gc.dataObjectInstance.curDate);
      }
      
      public function hasSignInToday() : Boolean
      {
         var today:int = this.getDayDiffFromStartDayToToday();
         var sit:int = this.signedArray.indexOf(today);
         if(sit != -1)
         {
            return true;
         }
         return false;
      }
      
      public function signInOld() : Boolean
      {
         var i:* = 0;
         var dayDiff:int = this.getDayDiffFromStartDayToToday();
         for(i = uint(0); i < dayDiff; )
         {
            if(this.signedArray.indexOf(i) == -1)
            {
               this.signedArray.push(i);
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function getSigninDays() : int
      {
         return this.signedArray.length;
      }
      
      public function getLeftSignOldDays() : int
      {
         if(this.hasSignInToday())
         {
            return this.getDayDiffFromStartDayToToday() - this.getSigninDays() + 1;
         }
         return this.getDayDiffFromStartDayToToday() - this.getSigninDays();
      }
      
      public function get5DaysPrize() : Boolean
      {
         if(this.canGet5DaysPrize())
         {
            this._continue5Times = true;
            return true;
         }
         return false;
      }
      
      public function get15DaysPrize() : Boolean
      {
         if(this.canGet15DaysPrize())
         {
            this._continue15Times = true;
            return true;
         }
         return false;
      }
      
      public function get30DaysPrize() : Boolean
      {
         if(this.canGet30DaysPrize())
         {
            this._continue30Times = true;
            return true;
         }
         return false;
      }
      
      public function get50DaysPrize() : Boolean
      {
         if(this.canGet50DaysPrize())
         {
            this._continue50Times = true;
            return true;
         }
         return false;
      }
      
      public function get signedArray() : Array
      {
         return _signedArray;
      }
      
      public function canGet5DaysPrize() : Boolean
      {
         return !this._continue5Times && this._signedArray.length >= this.__sign5;
      }
      
      public function hasArrive5DaysPrize() : Boolean
      {
         if(this._signedArray.length >= this.__sign5)
         {
            return true;
         }
         return false;
      }
      
      public function hasGet5DaysPrize() : Boolean
      {
         return this._continue5Times;
      }
      
      public function canGet15DaysPrize() : Boolean
      {
         return !this._continue15Times && this._signedArray.length >= this.__sign15;
      }
      
      public function hasArrive15DayPrize() : Boolean
      {
         if(this._signedArray.length >= this.__sign15)
         {
            return true;
         }
         return false;
      }
      
      public function hasGet15DayPrize() : Boolean
      {
         return this._continue15Times;
      }
      
      public function canGet30DaysPrize() : Boolean
      {
         return !this._continue30Times && this._signedArray.length >= this.__sign30;
      }
      
      public function hasArrive30DaysPrize() : Boolean
      {
         if(this._signedArray.length >= this.__sign30)
         {
            return true;
         }
         return false;
      }
      
      public function hasGet30DaysPrize() : Boolean
      {
         return this._continue30Times;
      }
      
      public function canGet50DaysPrize() : Boolean
      {
         return !this._continue50Times && this._signedArray.length >= this.__sign45;
      }
      
      public function hasArrive50DaysPrize() : Boolean
      {
         if(this._signedArray.length >= this.__sign45)
         {
            return true;
         }
         return false;
      }
      
      public function hasGet50DaysPrize() : Boolean
      {
         return this._continue50Times;
      }
   }
}
