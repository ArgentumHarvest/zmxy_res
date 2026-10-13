package export.level.StageListener221Children
{
   import com.greensock.TweenMax;
   import config.Config;
   import export.level.StageListener221;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class MusicSprite extends Sprite
   {
       
      
      private var sMusicSprite:MovieClip;
      
      public var currentState:uint = 0;
      
      private var currentIndex:uint = 0;
      
      private var kingArray:Array;
      
      private var currentKindArray:Array;
      
      private var gc:Config;
      
      public function MusicSprite()
      {
         var i:* = 0;
         kingArray = [[1,1,5,5,6,6,5],[3,1,6,5,6,1,5],[5,4,3,3,4,3]];
         super();
         gc = Config.getInstance();
         this.currentKindArray = this.kingArray[int(RandomControllor.getIns().getRandom() * this.kingArray.length)] as Array;
         trace("this.currentKindArray:" + this.currentKindArray);
         this.sMusicSprite = AUtils.getNewObj("stage221MusicSprite") as MovieClip;
         this.addChild(this.sMusicSprite);
         for(i = uint(1); i <= 7; )
         {
            (this.sMusicSprite["mubg" + i] as MovieClip).visible = false;
            (this.sMusicSprite["mu" + i] as MovieClip).gotoAndStop(8);
            if(i > this.currentKindArray.length)
            {
               (this.sMusicSprite["mu" + i] as MovieClip).visible = false;
            }
            i++;
         }
      }
      
      public function addRandomMusicByPoint(p:Point) : void
      {
         if(this.currentState == 0)
         {
            if(this.currentIndex < this.currentKindArray.length)
            {
               this.showMu(p);
               this.currentIndex++;
               if(this.currentIndex >= this.currentKindArray.length)
               {
                  this.currentIndex = 0;
                  this.currentState = 1;
               }
            }
         }
      }
      
      public function addMusic(kind:uint) : void
      {
         var k:* = 0;
         var mc:* = null;
         var i:* = 0;
         if(this.currentState == 1)
         {
            if(this.currentIndex < this.currentKindArray.length)
            {
               k = uint(this.currentKindArray[this.currentIndex]);
               if(k == kind)
               {
                  this.currentIndex++;
                  mc = this.sMusicSprite["mubg" + this.currentIndex] as MovieClip;
                  mc.visible = true;
               }
               else
               {
                  this.currentIndex = 0;
                  for(i = uint(1); i <= 7; )
                  {
                     (this.sMusicSprite["mubg" + i] as MovieClip).visible = false;
                     i++;
                  }
               }
            }
            if(this.currentIndex >= this.currentKindArray.length)
            {
               this.currentState = 2;
               if(gc.pWorld.getBaseLevelListener() is StageListener221)
               {
                  (gc.pWorld.getBaseLevelListener() as StageListener221).addBoss();
               }
            }
         }
      }
      
      private function showMu(p:Point) : void
      {
         p = p;
         var muIdx:uint = this.currentKindArray[this.currentIndex];
         var gloabPoint:Point = gc.gameSence.parent.localToGlobal(p);
         var newP:Point = this.globalToLocal(gloabPoint);
         var bm:Bitmap = AUtils.getImageObj("muBmd" + muIdx);
         bm.x = newP.x;
         bm.y = newP.y;
         this.addChild(bm);
         TweenMax.to(bm,1,{
            "x":0 - bm.width / 2 - (3 - this.currentIndex) * 40,
            "y":0 - bm.height / 2,
            "onComplete":function(_self:MusicSprite, _idx:uint, _bm:Bitmap):*
            {
               var frame:uint = _self.currentKindArray[_idx];
               (_self.sMusicSprite["mu" + (_idx + 1)] as MovieClip).gotoAndStop(frame);
               if(_bm.parent)
               {
                  _bm.parent.removeChild(_bm);
               }
            },
            "onCompleteParams":[this,this.currentIndex,bm]
         });
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.sMusicSprite = null;
      }
   }
}
