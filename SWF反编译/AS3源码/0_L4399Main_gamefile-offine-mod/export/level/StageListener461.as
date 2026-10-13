package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import export.level.StageListener461Children.StageListener461Guihua;
   import export.level.StageListener461Children.StageListener461Guihuashu;
   import flash.display.MovieClip;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener461 extends BaseLevelListenering
   {
       
      
      private var guihuashu:StageListener461Guihuashu;
      
      private var guihuaArray:Array;
      
      private var xiongshou:BaseMonster;
      
      private var daji:BaseMonster;
      
      public function StageListener461()
      {
         guihuaArray = [];
         super();
         waitForRegisterDataArray = [];
      }
      
      override public function step() : void
      {
         var temp:* = null;
         var idx:int = 0;
         super.step();
         if(gc.stage461Type == 0)
         {
            if(this.xiongshou)
            {
               if(this.xiongshou.isDead())
               {
                  if(this.summon && !this.summon.isDead())
                  {
                     if(!this.daji)
                     {
                        if(gc.diffWeeks % 2 == 1)
                        {
                           this.daji = MainGame.getInstance().createMonster(180,600,300);
                        }
                        else
                        {
                           this.daji = MainGame.getInstance().createMonster(216,600,300);
                        }
                     }
                  }
                  else
                  {
                     this.showTransferDoor();
                  }
                  this.xiongshou = null;
               }
            }
            if(this.daji)
            {
               if(this.daji.isDead())
               {
                  this.showTransferDoor();
                  this.daji = null;
               }
            }
         }
         else
         {
            temp = [];
            for each(var gh in this.guihuaArray)
            {
               if(!gh.isDestroy)
               {
                  gh.step();
               }
               if(gh.isDestroy)
               {
                  temp.push(gh);
               }
            }
            for each(gh in temp)
            {
               idx = this.guihuaArray.indexOf(gh);
               if(idx != -1)
               {
                  this.guihuaArray.splice(idx,1);
               }
            }
            if(this.guihuashu)
            {
               this.guihuashu.step();
            }
         }
      }
      
      private function showTransferDoor() : void
      {
         var i:int = 0;
         var mc:* = null;
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(i = 0; i < ta.length; )
         {
            mc = ta[i];
            mc.visible = true;
            i++;
         }
      }
      
      override public function start() : void
      {
         if(gc.stage461Type == 1)
         {
            guihuashu = new StageListener461Guihuashu();
            guihuashu.x = 90;
            guihuashu.y = 370;
            gc.gameSence.addChild(guihuashu);
         }
         super.start();
         this.xiongshou = MainGame.getInstance().createMonster(gc.guoqingMonsterId,500,200);
      }
      
      public function fallGuihua() : void
      {
         var guihua:StageListener461Guihua = new StageListener461Guihua();
         guihua.x = 200 + RandomControllor.getIns().getRandom() * 800;
         guihua.y = 100;
         gc.gameSence.addChild(guihua);
         this.guihuaArray.push(guihua);
      }
      
      override public function destroy() : void
      {
         this.guihuaArray.length = 0;
         super.destroy();
         this.xiongshou = null;
         this.daji = null;
      }
   }
}
