package export
{
   import base.MonsterAppearPoint;
   import config.Config;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class StopPoint extends MovieClip
   {
      
      public static const DESTROY:String = "destroy";
       
      
      [Inspectable(defaultValue="1150")]
      public var betweenRandL:int = 1150;
      
      [Inspectable(defaultValue="5")]
      public var idx:int;
      
      [Inspectable(defaultValue="false")]
      public var isBoss:Boolean;
      
      private var data:Point;
      
      public var isSendMonster:Boolean = false;
      
      private var gc:Config;
      
      private var isFirstZero:Boolean = true;
      
      public var stophere:MovieClip;
      
      public var isAlive:Boolean = true;
      
      private var isTouch:Boolean = false;
      
      public function StopPoint()
      {
         data = new Point();
         super();
         gc = Config.getInstance();
         if(gc.curStageAndCurLevel.curStage == 8 && gc.curStageAndCurLevel.curLevel == 1)
         {
            this.betweenRandL = 1400;
         }
         else if(gc.curStageAndCurLevel.curStage == 10 && gc.curStageAndCurLevel.curLevel == 7)
         {
            this.betweenRandL = 2500;
         }
      }
      
      public function setXY(_x:Number, _y:Number) : void
      {
         this.data.x = _x;
         this.data.y = _y;
      }
      
      public function touch() : void
      {
         var i:int = 0;
         var map:* = null;
         if(!this.isSendMonster)
         {
            this.isSendMonster = true;
            this.isAlive = true;
            for(i = 0; i < gc.pWorld.getMonsterAppearArray().length; )
            {
               map = MonsterAppearPoint(gc.pWorld.getMonsterAppearArray()[i]);
               if(map.stopPointIdx == this.idx)
               {
                  map.start();
               }
               i++;
            }
         }
         this.isTouch = true;
      }
      
      public function step() : void
      {
         var i:int = 0;
         var map:* = null;
         if(!this.isTouch)
         {
            return;
         }
         var over:Boolean = true;
         for(i = 0; i < gc.pWorld.getMonsterAppearArray().length; )
         {
            map = MonsterAppearPoint(gc.pWorld.getMonsterAppearArray()[i]);
            if(map.stopPointIdx == this.idx)
            {
               if(!map.isOver)
               {
                  over = false;
                  break;
               }
            }
            i++;
         }
         if(over && gc.pWorld.monsterArray.length == 0)
         {
            this.destroy();
         }
      }
      
      public function destroy() : void
      {
         var go:* = null;
         this.dispatchEvent(new Event("destroy"));
         var sp:Array = gc.pWorld.getStopPointArray();
         var idx:int = sp.indexOf(this);
         if(idx != gc.pWorld.getStopPointArray().length - 1)
         {
            if(!gc.isInHost())
            {
               gc.vControllor.setAutoCamera();
               if(this.idx < 4)
               {
                  go = AUtils.getNewObj("GOGO");
                  go.x = 860;
                  go.y = 300;
                  go.scaleX = 0.7;
                  go.scaleY = 0.7;
                  gc.gameInfo.addChild(go);
               }
            }
         }
         if(idx != -1)
         {
            sp.splice(idx,1);
         }
         this.isAlive = false;
      }
      
      public function getLeftDataX() : Number
      {
         return betweenRandL - 940;
      }
      
      public function getDataX() : Number
      {
         return this.data.x;
      }
   }
}
