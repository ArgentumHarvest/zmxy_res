package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import my.MainGame;
   
   public class StageListener121 extends BaseLevelListenering
   {
       
      
      private var showBossDialogue:Boolean = true;
      
      private var bossDialogue:MovieClip;
      
      public function StageListener121()
      {
         super();
         waitForRegisterDataArray = ["Monster53","Monster55","Monster56","Monster57"];
      }
      
      override public function start() : void
      {
         super.start();
      }
      
      private function __keyDown(evt:KeyboardEvent) : void
      {
         this.nextDialogue();
      }
      
      private function __click(evt:MouseEvent) : void
      {
         this.nextDialogue();
      }
      
      private function nextDialogue() : void
      {
         var heroHead:* = null;
         var monsterHead:* = null;
         if(this.bossDialogue)
         {
            if(this.bossDialogue.currentFrame < 4)
            {
               this.bossDialogue.gotoAndStop(this.bossDialogue.currentFrame + 1);
               heroHead = this.bossDialogue.getChildByName("playerHead") as MovieClip;
               monsterHead = this.bossDialogue.getChildByName("monsterDead") as MovieClip;
               if(this.bossDialogue.currentFrame == 1 || this.bossDialogue.currentFrame == 3 || this.bossDialogue.currentFrame == 6 || this.bossDialogue.currentFrame == 8)
               {
                  monsterHead.visible = false;
                  heroHead.visible = true;
               }
               else
               {
                  monsterHead.visible = true;
                  heroHead.visible = false;
               }
            }
            else
            {
               gc.stage.removeEventListener("keyDown",__keyDown);
               gc.stage.removeEventListener("click",__click);
               MainGame.getInstance().continueGame();
               if(this.bossDialogue.parent)
               {
                  this.bossDialogue.parent.removeChild(this.bossDialogue);
               }
            }
         }
      }
      
      override public function step() : void
      {
         var heroHead:* = null;
         var monsterHead:* = null;
         super.step();
         if(this.showBossDialogue)
         {
            for each(var bm in gc.pWorld.monsterArray)
            {
               if(bm.isBoss)
               {
                  if(this.showBossDialogue)
                  {
                     gc.stage.addEventListener("keyDown",__keyDown);
                     gc.stage.addEventListener("click",__click);
                     this.bossDialogue = AUtils.getNewObj("Stage12XDialogue") as MovieClip;
                     this.bossDialogue.x = -15;
                     this.bossDialogue.y = 360;
                     heroHead = this.bossDialogue.getChildByName("playerHead") as MovieClip;
                     monsterHead = this.bossDialogue.getChildByName("monsterDead") as MovieClip;
                     monsterHead.visible = false;
                     heroHead.gotoAndStop(gc.player1.roleid);
                     monsterHead.gotoAndStop(1);
                     MainGame.getInstance().stopGame();
                     GMain.getInstance().getTopSence().addChild(this.bossDialogue);
                     this.showBossDialogue = false;
                  }
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
