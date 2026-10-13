package export.win
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import mvc.controllor.RandomControllor;
   import user.User;
   
   public class GameWin extends Sprite
   {
       
      
      private var gc:Config;
      
      public var txt_allscore:TextField;
      
      public var txt_hight:TextField;
      
      public var txt_state:TextField;
      
      public var txt_usertime:TextField;
      
      public var nextStageButton:SimpleButton;
      
      public var backTochooseButton:SimpleButton;
      
      private var goTimer:int;
      
      private var ahp:Number;
      
      private var amp:Number;
      
      public function GameWin()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         nextStageButton.visible = true;
         nextStageButton.addEventListener("click",nextClick);
         backTochooseButton.addEventListener("click",backClick);
         if(gc.curStageAndCurLevel.curStage == 12)
         {
            if(gc.curStageAndCurLevel.curLevel < 5)
            {
               nextStageButton.visible = true;
               backTochooseButton.visible = false;
            }
            else
            {
               nextStageButton.visible = false;
               backTochooseButton.visible = true;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 3)
         {
            if(gc.curStageAndCurLevel.curLevel == 3)
            {
               nextStageButton.visible = false;
            }
         }
         else if(gc.curStageAndCurLevel.curStage >= 4)
         {
            if(gc.curStageAndCurLevel.curStage < 40)
            {
               if(gc.curStageAndCurLevel.curStage >= 20)
               {
                  if(gc.curStageAndCurLevel.curStage == 20)
                  {
                     nextStageButton.visible = true;
                     backTochooseButton.visible = true;
                  }
                  else if(gc.curStageAndCurLevel.curStage == 21)
                  {
                     if(gc.curStageAndCurLevel.curLevel <= 3)
                     {
                        nextStageButton.visible = true;
                        backTochooseButton.visible = true;
                     }
                     else
                     {
                        nextStageButton.visible = false;
                        backTochooseButton.visible = true;
                     }
                  }
                  else if(gc.curStageAndCurLevel.curStage == 22)
                  {
                     if(gc.curStageAndCurLevel.curLevel <= 3)
                     {
                        nextStageButton.visible = true;
                        backTochooseButton.visible = true;
                     }
                     else
                     {
                        nextStageButton.visible = false;
                        backTochooseButton.visible = true;
                     }
                  }
                  else if(gc.curStageAndCurLevel.curStage == 23)
                  {
                     if(gc.curStageAndCurLevel.curLevel < 2)
                     {
                        nextStageButton.visible = true;
                        backTochooseButton.visible = true;
                     }
                     else
                     {
                        nextStageButton.visible = false;
                        backTochooseButton.visible = true;
                     }
                  }
                  else if(gc.curStageAndCurLevel.curStage == 24)
                  {
                     if(gc.curStageAndCurLevel.curLevel <= 3)
                     {
                        nextStageButton.visible = true;
                        backTochooseButton.visible = true;
                     }
                     else
                     {
                        nextStageButton.visible = false;
                        backTochooseButton.visible = true;
                     }
                  }
                  else if(gc.curStageAndCurLevel.curStage == 25)
                  {
                     if(gc.curStageAndCurLevel.curLevel < 3)
                     {
                        nextStageButton.visible = true;
                        backTochooseButton.visible = true;
                     }
                     else
                     {
                        nextStageButton.visible = false;
                        backTochooseButton.visible = true;
                     }
                  }
               }
               else
               {
                  nextStageButton.visible = false;
                  if(gc.curStageAndCurLevel.curStage == 14)
                  {
                     if(gc.curStageAndCurLevel.curLevel < 2)
                     {
                        nextStageButton.visible = true;
                     }
                  }
               }
            }
            else
            {
               nextStageButton.visible = false;
            }
         }
         this.setUserTime();
         this.setHigh();
         this.setState();
         this.setAllScore();
      }
      
      private function setUserTime() : void
      {
         var hours:int = 0;
         var min:int = 0;
         var sec:int = 0;
         gc.pauseTime += int(gc.pauseaft - gc.pausepre);
         trace("goTimer=" + goTimer + " gc.pauseTime=" + gc.pauseTime + " gc.startTime=" + gc.startTime);
         goTimer = getTimer() - gc.startTime;
         if(goTimer <= 0)
         {
            this.txt_usertime.text = "99999";
         }
         else
         {
            hours = Math.floor(goTimer / 3600 / 1000);
            min = Math.floor((goTimer / 3600 / 1000 - hours) * 60);
            sec = Math.floor(((goTimer / 3600 / 1000 - hours) * 60 - min) * 60);
            this.txt_usertime.text = hours + ":" + min + ":" + sec;
         }
      }
      
      private function setAllScore() : void
      {
         var f1:int = (300 + goTimer / 1000) / (goTimer / 1000 * 50);
         if(f1 > 800)
         {
            f1 = 800;
         }
         var f2:int = 300 * (amp + ahp);
         if(f2 > 300)
         {
            f2 = 300;
         }
         var f3:int = User.biggestbatterNum;
         if(f3 > 800)
         {
            f3 = 800;
         }
         var allscore:Number = f1 + f2 + f3 + RandomControllor.getIns().getRandom();
         this.txt_allscore.text = int(allscore) + "";
         gc.gameScore["sl" + gc.curStageAndCurLevel.curStage + "_" + gc.curStageAndCurLevel.curLevel] = gc.gameScore["sl" + gc.curStageAndCurLevel.curStage + "_" + gc.curStageAndCurLevel.curLevel] < int(allscore) ? int(allscore) : gc.gameScore["sl" + gc.curStageAndCurLevel.curStage + "_" + gc.curStageAndCurLevel.curLevel] + RandomControllor.getIns().getRandom() / 10000;
      }
      
      private function setState() : void
      {
         amp = 0;
         ahp = 0;
         if(gc.hero1)
         {
            amp = gc.hero1.roleProperies.getMMP() / gc.hero1.roleProperies.getSMMP() / 2;
            ahp = gc.hero1.roleProperies.getHHP() / gc.hero1.roleProperies.getSHHP() / 2;
         }
         if(gc.hero2)
         {
            amp += gc.hero1.roleProperies.getMMP() / gc.hero1.roleProperies.getSMMP() / 2;
            ahp += gc.hero1.roleProperies.getHHP() / gc.hero1.roleProperies.getSHHP() / 2;
         }
         this.txt_state.text = int((amp + ahp) * 100) + "%";
         if(int((amp + ahp) * 100) > 100)
         {
            this.txt_state.text = "100%";
         }
      }
      
      private function setHigh() : void
      {
         this.txt_hight.text = User.biggestbatterNum + "";
      }
      
      private function removed(e:Event) : void
      {
         nextStageButton.removeEventListener("click",nextClick);
         backTochooseButton.removeEventListener("click",backClick);
      }
      
      private function nextClick(e:MouseEvent) : void
      {
         if(gc.curStageAndCurLevel.curStage <= 3)
         {
            if(gc.curStageAndCurLevel.curLevel == 3)
            {
               gc.curStageAndCurLevel.curStage++;
               gc.curStageAndCurLevel.curLevel = 1;
            }
            else
            {
               gc.curStageAndCurLevel.curLevel++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 4)
         {
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(gc.curStageAndCurLevel.curStage == 12)
         {
            if(gc.curStageAndCurLevel.curLevel < 5)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 14)
         {
            if(gc.curStageAndCurLevel.curLevel < 2)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 20)
         {
            gc.curStageAndCurLevel.curStage++;
         }
         else if(gc.curStageAndCurLevel.curStage == 21)
         {
            if(gc.curStageAndCurLevel.curLevel < 3)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
            else
            {
               gc.curStageAndCurLevel.curLevel = 1;
               gc.curStageAndCurLevel.curStage++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 22)
         {
            if(gc.curStageAndCurLevel.curLevel < 3)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
            else
            {
               gc.curStageAndCurLevel.curLevel = 1;
               gc.curStageAndCurLevel.curStage++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 23)
         {
            if(gc.curStageAndCurLevel.curLevel < 2)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
            else
            {
               gc.curStageAndCurLevel.curLevel = 1;
               gc.curStageAndCurLevel.curStage++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 24)
         {
            if(gc.curStageAndCurLevel.curLevel < 3)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
            else
            {
               gc.curStageAndCurLevel.curLevel = 1;
               gc.curStageAndCurLevel.curStage++;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 25)
         {
            if(gc.curStageAndCurLevel.curLevel < 3)
            {
               gc.curStageAndCurLevel.curLevel++;
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         User.biggestbatterNum = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function backClick(e:MouseEvent) : void
      {
         if(gc.dataObject.whichlastworld == 1)
         {
            GMain.getInstance().switchSence("showNewStageMap");
         }
         else if(gc.dataObject.whichlastworld == 2)
         {
            GMain.getInstance().switchSence("showThirdStageMap");
         }
         else
         {
            GMain.getInstance().switchSence("showStageMap");
         }
         if(gc.curStageAndCurLevel.curStage == 8 && gc.curStageAndCurLevel.curLevel == 1)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         User.biggestbatterNum = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
