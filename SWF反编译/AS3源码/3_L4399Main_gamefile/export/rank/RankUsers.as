package export.rank
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   
   public class RankUsers
   {
       
      
      private var rankUserArray:Array;
      
      private var _anti:Antiwear;
      
      private var gc:Config;
      
      public function RankUsers()
      {
         rankUserArray = [];
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this.setIndex(0);
         this.setUid(0);
         this.setGongXun(0);
         this.setScore(0);
         this.setArea("火星");
         this.setRank(0);
         this.setUserName("尼玛");
         this.setRankDiff(0);
         this.setWinGongxun(0);
      }
      
      public function setRankObject(obj:Object) : void
      {
         var str:* = null;
         var arr:* = null;
         var userInfoArr:* = null;
         var ru:* = null;
         ru = null;
         if(!obj)
         {
            return;
         }
         this.rankUserArray.length = 0;
         this._anti.rankObject = obj;
         this.setIndex(obj.index);
         this.setUid(obj.uId);
         this.setScore(obj.score);
         this.setArea(obj.area);
         this.setRank(obj.rank);
         this.setUserName(obj.userName);
         if(obj.extra != undefined)
         {
            str = obj.extra;
            arr = str.split("^");
            if(arr.length == 3)
            {
               if(gc.logInfo)
               {
                  if(this.getUid() == gc.logInfo.uid && this.getIndex() == gc.luanqibazaojiami.saveId)
                  {
                     gc.dataObject.challengeRankTimes = int(arr[0]);
                  }
               }
               this.setGongXun(arr[1]);
               userInfoArr = (arr[2] as String).split("&");
               for each(var s in userInfoArr)
               {
                  ru = new RankUser(s);
                  ru.setUserName(this.getUserName());
                  ru.setRankDiff(this.getRankDiff());
                  ru.setGongXun(this.getGongXun());
                  ru.setScore(this.getScore());
                  this.rankUserArray.push(ru);
               }
            }
            else
            {
               ru = new RankUser("");
               this.rankUserArray.push(ru);
            }
         }
      }
      
      public function getRankUserArray() : Array
      {
         return this.rankUserArray;
      }
      
      public function setWinGongxun(incr:int) : void
      {
         if(incr > 55)
         {
            incr = 55;
         }
         this._anti.wingongxun = incr;
      }
      
      public function getWinGongxun() : int
      {
         return this._anti.wingongxun;
      }
      
      private function setRank(incr:int) : void
      {
         this._anti.rank = incr;
      }
      
      public function getRank() : int
      {
         return this._anti.rank;
      }
      
      private function setArea(incr:String) : void
      {
         this._anti.area = incr;
      }
      
      public function getArea() : String
      {
         return this._anti.area;
      }
      
      private function setUserName(incr:String) : void
      {
         this._anti.userName = incr;
      }
      
      public function getUserName() : String
      {
         return this._anti.userName;
      }
      
      private function setScore(incr:int) : void
      {
         this._anti.score = incr;
      }
      
      public function getScore() : int
      {
         return this._anti.score;
      }
      
      public function setRankDiff(eb:int) : void
      {
         this._anti.rankDiff = eb;
      }
      
      public function getRankDiff() : int
      {
         return this._anti.rankDiff;
      }
      
      private function setGongXun(incr:int) : void
      {
         this._anti.gongXun = incr;
         if(gc.rankHasPassOneMin == true)
         {
            if(gc.logInfo)
            {
               if(this.getUid() == gc.logInfo.uid && this.getIndex() == gc.luanqibazaojiami.saveId)
               {
                  trace("设置自身功勋");
                  gc.dataObject.gongxun = incr;
               }
            }
         }
      }
      
      public function getGongXun() : int
      {
         return this._anti.gongXun;
      }
      
      private function setIndex(incr:int) : void
      {
         this._anti.index = incr;
      }
      
      public function getIndex() : int
      {
         return this._anti.index;
      }
      
      private function setUid(incr:int) : void
      {
         this._anti.uid = incr;
      }
      
      public function getUid() : int
      {
         return this._anti.uid;
      }
   }
}
