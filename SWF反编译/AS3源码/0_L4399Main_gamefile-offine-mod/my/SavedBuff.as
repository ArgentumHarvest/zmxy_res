package my
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SavedBuff extends Sprite
   {
       
      
      private var infoSprite:SavedBuffInfoSprite;
      
      private var buffArray:Array;
      
      private var gc:Config;
      
      public function SavedBuff()
      {
         buffArray = [];
         super();
         gc = Config.getInstance();
      }
      
      public function step() : void
      {
         var idx:int = 0;
         var temp:Array = [];
         for each(var ssb in this.buffArray)
         {
            if(!ssb.isDestroyed)
            {
               ssb.step();
            }
            if(ssb.isDestroyed)
            {
               temp.push(ssb);
            }
         }
         if(temp.length > 0)
         {
            for each(ssb in temp)
            {
               idx = this.buffArray.indexOf(ssb);
               if(idx != -1)
               {
                  this.buffArray.splice(idx,1);
               }
            }
            this.refreshDisplay();
         }
      }
      
      private function refreshDisplay() : void
      {
         var idx:int = 0;
         for each(var ssb in this.buffArray)
         {
            idx = this.buffArray.indexOf(ssb);
            ssb.idx = idx;
         }
      }
      
      public function setFromMemory(data:String) : void
      {
         var dataArr:* = null;
         var len:* = 0;
         var i:* = 0;
         var str:* = null;
         var arr:* = null;
         var type:* = 0;
         var value:int = 0;
         var time:int = 0;
         if(!data || data == "")
         {
            return;
         }
         if(this.buffArray)
         {
            for each(var ssb in this.buffArray)
            {
               if(this.contains(ssb))
               {
                  this.removeChild(ssb);
               }
            }
            this.buffArray.length = 0;
            dataArr = data.split(",");
            if(dataArr.length > 0)
            {
               len = uint(dataArr.length);
               for(i = uint(0); i < len; )
               {
                  str = dataArr[i];
                  arr = str.split("|");
                  if(arr.length == 3)
                  {
                     type = uint(arr[0]);
                     value = arr[1];
                     if(type == SingleSavedBuff.BUFF_EXP_ADD)
                     {
                        if(value > 3)
                        {
                           value = 3;
                        }
                     }
                     else if(type == SingleSavedBuff.BUFF_ATK_ADD)
                     {
                        if(value > 300)
                        {
                           value = 300;
                        }
                     }
                     else if(type == SingleSavedBuff.BUFF_MID_BUFF)
                     {
                        if(value > 500)
                        {
                           value = 500;
                        }
                     }
                     time = arr[2];
                     if(time > 3600 * gc.frameClips)
                     {
                        time = 3600 * gc.frameClips;
                     }
                     this.addBuff(type,value,time);
                  }
                  i++;
               }
            }
         }
      }
      
      public function getMemoryString() : String
      {
         var i:* = 0;
         var ssb:* = null;
         var returnString:String = "";
         var len:uint = this.buffArray.length;
         for(i = uint(0); i < len; )
         {
            ssb = this.buffArray[i] as SingleSavedBuff;
            returnString += ssb.type + "|" + ssb.value + "|" + ssb.time;
            if(i < len - 1)
            {
               returnString += ",";
            }
            i++;
         }
         return returnString;
      }
      
      public function addBuff(type:uint, value:int, time:int) : void
      {
         var isNew:Boolean = false;
         var ssb:* = null;
         if(time > 0)
         {
            isNew = true;
            for each(ssb in this.buffArray)
            {
               if(ssb.type == type)
               {
                  isNew = false;
                  ssb.value = value;
                  ssb.time = time;
                  break;
               }
            }
            if(isNew)
            {
               ssb = new SingleSavedBuff(type,value,time,this.buffArray.length);
               this.addChild(ssb);
               this.buffArray.push(ssb);
            }
         }
         gc.savedBuffString = gc.savedBuff.getMemoryString();
      }
      
      public function getBuffByType(type:uint) : SingleSavedBuff
      {
         for each(var ssb in this.buffArray)
         {
            if(ssb.type == type)
            {
               return ssb;
            }
         }
         return null;
      }
      
      private function __showInfo(evt:MouseEvent) : void
      {
         var ssb:* = null;
         if(evt.target is SingleSavedBuff)
         {
            ssb = evt.target as SingleSavedBuff;
            if(!this.infoSprite)
            {
               this.infoSprite = new SavedBuffInfoSprite(ssb);
               this.infoSprite.x = ssb.x + ssb.width - 20;
               this.infoSprite.y = ssb.y;
               this.addChild(this.infoSprite);
            }
         }
      }
      
      private function __hideInfo(evt:MouseEvent) : void
      {
         if(this.infoSprite)
         {
            if(this.contains(this.infoSprite))
            {
               this.removeChild(this.infoSprite);
            }
            this.infoSprite = null;
         }
      }
      
      public function removeBuffByType(type:uint) : void
      {
         for each(var ssb in this.buffArray)
         {
            if(ssb.type == type)
            {
               ssb.destroy();
               break;
            }
         }
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
