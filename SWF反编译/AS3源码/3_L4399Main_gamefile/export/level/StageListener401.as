package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.StageListener401Children.StageListener401Daojishi;
   import export.level.StageListener401Children.StageListener401Light;
   import export.mapObject.StageListener401WoodThron;
   import export.monster.Monster114;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import my.MainGame;
   
   public class StageListener401 extends BaseLevelListenering
   {
       
      
      private var daojishiCount:int = 0;
      
      private var isStartDaojishi:Boolean = false;
      
      private var daojishi:StageListener401Daojishi;
      
      private var m114:Monster114;
      
      private var lightArray:Array;
      
      private var woodThronArray:Array;
      
      public function StageListener401()
      {
         lightArray = [];
         woodThronArray = [];
         super();
         waitForRegisterDataArray = [];
         this.daojishiCount = gc.frameClips * 101;
      }
      
      override public function step() : void
      {
         super.step();
         for each(light in this.lightArray)
         {
            light.step();
         }
         if(this.isStartDaojishi)
         {
            if(this.daojishiCount >= 0)
            {
               this.daojishiCount--;
               if(this.daojishiCount == 0)
               {
                  for each(bh in gc.getPlayerArray())
                  {
                     var afterdead:* = AUtils.getNewObj("PlayerDeadMc");
                     afterdead.x = bh.x;
                     afterdead.y = bh.y;
                     gc.gameSence.addChild(afterdead);
                     bh.isAlreadyDead = true;
                     bh.destroy();
                  }
                  TweenMax.delayedCall(2.5,function():*
                  {
                     MainGame.getInstance().destroyGame();
                     gc.eventManger.dispatchEvent(new CommonEvent("GameOver"));
                  });
               }
            }
         }
         if(this.daojishiCount >= 0)
         {
            if(this.daojishi)
            {
               this.daojishi.updateDisplay(this.daojishiCount);
            }
         }
         for each(it in this.woodThronArray)
         {
            it.step();
         }
      }
      
      override public function start() : void
      {
         super.start();
         var len:uint = gc.gameSence.numChildren;
         for(var i:uint = 0; i < len; )
         {
            var obj:Object = gc.gameSence.getChildAt(i);
            if(obj is MovieClip)
            {
               if(MovieClip(obj).getChildByName("isWoodThron"))
               {
                  woodThronArray.push(obj);
               }
            }
            i++;
         }
         this.addLightMC(new Point(626,72));
         TweenMax.delayedCall(3,function(_self:StageListener401):*
         {
            _self.daojishi = new StageListener401Daojishi();
            _self.daojishi.x = 470;
            _self.daojishi.y = 100;
            gc.gameSence.addChild(_self.daojishi);
            _self.daojishi.light(-1);
            if(gc.dataObject.whichSaints == 1)
            {
               _self.startDaojishi();
            }
            else
            {
               _self.daojishi.timeTf.text = "∞";
            }
            _self.m114 = MainGame.getInstance().createMonster(114,500,300) as Monster114;
         },[this]);
      }
      
      public function startDaojishi() : void
      {
         this.isStartDaojishi = true;
      }
      
      public function stopDaojishi() : void
      {
         this.isStartDaojishi = false;
      }
      
      private function addLightMC(pos:Point) : void
      {
         var light:StageListener401Light = new StageListener401Light();
         light.addEventListener("hurt",__lightHurt);
         light.x = pos.x;
         light.y = pos.y;
         gc.gameSence.addChild(light);
         this.lightArray.push(light);
      }
      
      private function __lightHurt(evt:Event) : void
      {
         var hurt:int = 0;
         if(this.m114)
         {
            if(!this.m114.isDead())
            {
               hurt = this.m114.getHp() * 0.08;
               this.m114.reduceHp(hurt);
               this.m114.addMonHurtMc(hurt,false);
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.m114 = null;
         this.daojishi = null;
         this.woodThronArray.length = 0;
         for each(var light in this.lightArray)
         {
            light.removeEventListener("hurt",__lightHurt);
         }
         this.lightArray.length = 0;
      }
   }
}
