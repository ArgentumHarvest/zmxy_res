package export.level.StageListener151Child
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Stage151BossTime extends Sprite
   {
       
      
      public var timeTf:TextField;
      
      public var longhunTf:TextField;
      
      private var timeCount:uint = 0;
      
      private var ttf:TextFormat;
      
      public function Stage151BossTime()
      {
         super();
         this.ttf = new TextFormat();
         this.ttf.color = "0x000000";
         this.timeTf.defaultTextFormat = this.ttf;
         this.longhunTf.defaultTextFormat = this.ttf;
         this.timeTf.text = "0";
         this.longhunTf.text = "0";
      }
      
      public function updateTime() : void
      {
         this.timeCount++;
         this.timeTf.text = "" + int(this.timeCount / 24);
      }
      
      public function updateLonghun(longhun:uint) : void
      {
         this.longhunTf.text = longhun.toString();
      }
   }
}
