package base
{
   import config.Config;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BaseGameSence extends MovieClip
   {
       
      
      protected var gc:Config;
      
      public var bgContainer:MovieClip;
      
      private var bgBitmapDataSprite:Sprite;
      
      protected var bgSprite:Sprite;
      
      private var bgBitmapData:BitmapData;
      
      public function BaseGameSence()
      {
         var i:int = 0;
         super();
         gc = Config.getInstance();
         this.bgSprite = AUtils.getNewObj("bg" + gc.curStageAndCurLevel.curStage + gc.curStageAndCurLevel.curLevel);
         this.bgSprite.x = -20;
         this.bgSprite.cacheAsBitmap = true;
         this.bgContainer.addChildAt(this.bgSprite,0);
         for(i = 0; i < this.numChildren; )
         {
            gc.pWorld.addSubObj(this.getChildAt(i));
            i++;
         }
         this.addEventListener("click",__click);
      }
      
      protected function __click(evt:MouseEvent) : void
      {
         stage.focus = stage;
      }
      
      public function getChildByNameInBgSprite(name:String) : DisplayObject
      {
         var i:* = 0;
         var dis:* = null;
         for(i = uint(0); i < this.bgSprite.numChildren; )
         {
            dis = this.bgSprite.getChildByName(name);
            if(dis)
            {
               return dis;
            }
            i++;
         }
         return null;
      }
      
      public function getBgSprite() : Sprite
      {
         return this.bgSprite;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var j:int = 0;
         this.removeEventListener("click",__click);
         if(this.bgBitmapData)
         {
            this.bgBitmapData.dispose();
            this.bgBitmapData = null;
         }
         this.bgBitmapDataSprite = null;
         this.bgSprite = null;
         for(i = 0; i < this.bgContainer.numChildren; )
         {
            this.bgContainer.removeChild(this.bgContainer.getChildAt(0));
            i++;
         }
         for(j = 0; j < this.numChildren; )
         {
            this.removeChild(this.getChildAt(0));
            j++;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
