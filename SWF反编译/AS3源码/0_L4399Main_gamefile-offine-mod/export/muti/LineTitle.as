package export.muti
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class LineTitle extends Sprite
   {
       
      
      public var playerNumTxt:TextField;
      
      public var lineNameMc:MovieClip;
      
      public var lineIdxMc:MovieClip;
      
      public function LineTitle()
      {
         super();
      }
      
      public function setLineIdxMc(idx:uint) : void
      {
         this.lineIdxMc.gotoAndStop(idx);
      }
      
      public function setLineNameMc(idx:uint) : void
      {
         this.lineNameMc.gotoAndStop(idx);
      }
      
      public function setPlayerNum(cur:uint, max:uint) : void
      {
         this.playerNumTxt.text = cur + "/" + max;
      }
   }
}
