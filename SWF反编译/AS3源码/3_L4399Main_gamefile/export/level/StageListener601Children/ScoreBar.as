package export.level.StageListener601Children
{
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ScoreBar extends Sprite
   {
      
      public static const OVER:String = "over";
      
      public static const BALL:String = "ball";
       
      
      private var djs:TextField;
      
      private var score:TextField;
      
      private var time:int;
      
      private var sc:int = 0;
      
      private var gc:Config;
      
      public function ScoreBar()
      {
         djs = new TextField();
         score = new TextField();
         time = Config.getInstance().frameClips * 140;
         super();
         gc = Config.getInstance();
         var ttf:TextFormat = new TextFormat();
         ttf.size = 20;
         djs.defaultTextFormat = ttf;
         score.defaultTextFormat = ttf;
         var bg:Bitmap = AUtils.getImageObj("scorebar");
         this.addChild(bg);
         djs.selectable = false;
         djs.x = 80;
         djs.y = 12;
         this.addChild(djs);
         score.selectable = false;
         score.text = sc + "";
         score.x = 80;
         score.y = 58;
         this.addChild(score);
      }
      
      public function step() : void
      {
         if(time <= 0)
         {
            return;
         }
         if(time % (gc.frameClips * 8) == 0)
         {
            this.dispatchEvent(new Event("ball"));
         }
         time--;
         djs.text = int(time / gc.frameClips) + "";
         djs.width = djs.textWidth + 10;
         djs.height = djs.textHeight + 5;
         if(time == 0)
         {
            this.dispatchEvent(new Event("over"));
         }
      }
      
      public function addScore() : void
      {
         sc++;
         score.text = sc + "";
         score.width = score.textWidth + 10;
         score.height = score.textHeight + 5;
      }
      
      public function getRateAdd() : Number
      {
         return sc / 10;
      }
   }
}
