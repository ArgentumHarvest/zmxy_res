package export.level.StageListener411Children
{
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Clock extends Sprite
   {
       
      
      private var gc:Config;
      
      private var bgBm:Bitmap;
      
      private var lightArray:Array;
      
      private var lightPointArray:Array;
      
      public function Clock()
      {
         lightArray = [];
         lightPointArray = [[18,-6],[43,9],[39,33],[20,44],[-3,32],[-6,8]];
         super();
         gc = Config.getInstance();
      }
      
      public function showByTime() : void
      {
         var i:* = 0;
         var newBm:* = null;
         if(this.bgBm)
         {
            this.bgBm.bitmapData.dispose();
            if(this.bgBm.parent)
            {
               this.bgBm.parent.removeChild(bgBm);
            }
            this.bgBm = null;
         }
         for each(var bm in lightArray)
         {
            bm.bitmapData.dispose();
            if(bm.parent)
            {
               bm.parent.removeChild(bm);
            }
         }
         this.lightArray.length = 0;
         var isDay:Boolean = false;
         var hour:uint = (gc.dataObjectInstance.curTime as String).split(":")[0];
         trace("hour:" + hour);
         if(hour >= 6 && hour < 18)
         {
            isDay = true;
         }
         if(isDay)
         {
            this.bgBm = AUtils.getImageObj("StageLister411DayClockBG") as Bitmap;
         }
         else
         {
            this.bgBm = AUtils.getImageObj("StageLister411NightClockBG") as Bitmap;
         }
         if(this.bgBm)
         {
            this.addChild(this.bgBm);
         }
         var lightCount:uint = 0;
         if(isDay)
         {
            lightCount = int((hour - 6) / 2) + 1;
         }
         else if(hour >= 18)
         {
            lightCount = int((hour - 18) / 2) + 1;
         }
         else
         {
            lightCount = int((hour + 6) / 2) + 1;
         }
         trace("lightCount:" + lightCount);
         for(i = uint(0); i < lightCount; )
         {
            if(isDay)
            {
               newBm = AUtils.getImageObj("StageLister411DayClockLight") as Bitmap;
            }
            else
            {
               newBm = AUtils.getImageObj("StageLister411NightClockLight") as Bitmap;
            }
            newBm.x = this.lightPointArray[i][0];
            newBm.y = this.lightPointArray[i][1];
            this.addChild(newBm);
            this.lightArray.push(newBm);
            i++;
         }
      }
      
      public function destroy() : void
      {
         if(this.bgBm)
         {
            this.bgBm.bitmapData.dispose();
            if(this.bgBm.parent)
            {
               this.bgBm.parent.removeChild(bgBm);
            }
            this.bgBm = null;
         }
         for each(var bm in lightArray)
         {
            bm.bitmapData.dispose();
            if(bm.parent)
            {
               bm.parent.removeChild(bm);
            }
         }
         this.lightArray.length = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
