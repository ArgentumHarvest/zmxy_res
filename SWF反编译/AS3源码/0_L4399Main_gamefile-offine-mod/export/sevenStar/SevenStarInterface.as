package export.sevenStar
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class SevenStarInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var intobtn:SimpleButton;
      
      public var fbbgmc:MovieClip;
      
      private var gc:Config;
      
      private var initialized:Boolean = false;
      
      private var entering:Boolean = false;
      
      public function SevenStarInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         entering = false;
         if(xbtn && !xbtn.hasEventListener(MouseEvent.CLICK))
         {
            xbtn.addEventListener(MouseEvent.CLICK,xClick,false,0,true);
         }
         if(intobtn && !intobtn.hasEventListener(MouseEvent.CLICK))
         {
            intobtn.addEventListener(MouseEvent.CLICK,intoClick,false,0,true);
         }
         initializeDungeonDisplay();
      }
      
      private function initializeDungeonDisplay() : void
      {
         if(initialized)
         {
            if(fbbgmc)
            {
               fbbgmc.visible = true;
            }
            return;
         }
         initialized = true;
         if(fbbgmc)
         {
            fbbgmc.visible = true;
         }
         if(gc.dataObject.beidouqixing >= 1)
         {
            var random:int = int(RandomControllor.getIns().getRandom() * 3);
            if(random < 0)
            {
               random = 0;
            }
            else if(random > 2)
            {
               random = 2;
            }
            gc.qixingMonsterId = 177 + random;
            if(fbbgmc)
            {
               fbbgmc.gotoAndStop(4);
            }
         }
         else if(gc.dataObject.guoqingFB >= 1)
         {
            var names:Array = ["醉翁","白面猿猴","七香车","聚宝天官"];
            gc.randomMonster = int(RandomControllor.getIns().getRandom() * 4);
            if(gc.randomMonster < 0)
            {
               gc.randomMonster = 0;
            }
            else if(gc.randomMonster > 3)
            {
               gc.randomMonster = 3;
            }
            if(fbbgmc)
            {
               fbbgmc.gotoAndStop(names[gc.randomMonster]);
            }
            switch(int(gc.randomMonster))
            {
               case 0:
                  gc.guoqingMonsterId = 183;
                  break;
               case 1:
                  gc.guoqingMonsterId = 182;
                  break;
               case 2:
                  gc.guoqingMonsterId = 184;
                  break;
               case 3:
                  gc.guoqingMonsterId = 185;
            }
         }
         else
         {
            random = int(RandomControllor.getIns().getRandom() * 3);
            if(random < 0)
            {
               random = 0;
            }
            else if(random > 2)
            {
               random = 2;
            }
            gc.qixingMonsterId = 177 + random;
            if(fbbgmc)
            {
               fbbgmc.gotoAndStop(4);
            }
         }
         trace("[SevenStarInterface] initialized; " + "beidouqixing=" + gc.dataObject.beidouqixing + ", guoqingFB=" + gc.dataObject.guoqingFB + ", qixingMonsterId=" + gc.qixingMonsterId + ", guoqingMonsterId=" + gc.guoqingMonsterId);
      }
      
      private function intoClick(e:MouseEvent) : void
      {
         if(entering)
         {
            return;
         }
         if(gc.dataObject.beidouqixing >= 1)
         {
            entering = true;
            disableButtons();
            gc.curStageAndCurLevel.curStage = 55;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.dataObject.beidouqixing--;
            var game55:MainGame = MainGame.getInstance();
            if(game55)
            {
               game55.destroyGame();
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
            saveData();
            return;
         }
         if(gc.dataObject.guoqingFB >= 1)
         {
            entering = true;
            disableButtons();
            gc.curStageAndCurLevel.curStage = 56;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.dataObject.guoqingFB--;
            var game56:MainGame = MainGame.getInstance();
            if(game56)
            {
               game56.destroyGame();
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
            saveData();
            return;
         }
         gc.ts.setTxt("您今天已经挑战过该副本");
         if(!gc.ts.parent)
         {
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function saveData() : void
      {
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function disableButtons() : void
      {
         if(intobtn)
         {
            intobtn.mouseEnabled = false;
            intobtn.removeEventListener(MouseEvent.CLICK,intoClick);
         }
         if(xbtn)
         {
            xbtn.mouseEnabled = false;
            xbtn.removeEventListener(MouseEvent.CLICK,xClick);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(entering)
         {
            return;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removed(e:Event) : void
      {
         if(xbtn)
         {
            xbtn.removeEventListener(MouseEvent.CLICK,xClick);
         }
         if(intobtn)
         {
            intobtn.removeEventListener(MouseEvent.CLICK,intoClick);
         }
      }
   }
}
