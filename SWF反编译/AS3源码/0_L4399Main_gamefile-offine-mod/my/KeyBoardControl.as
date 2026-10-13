package my
{
   import base.BaseHero;
   import base.BaseMonster;
   import com.superkaka.mvc.ControlFactory;
   import config.Config;
   import export.RoleInfo;
   import export.level.StageListener01;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.control.SocketsSendControl;
   import mvc.net.sm.OperationSend;
   import user.User;
   
   public class KeyBoardControl
   {
       
      
      private var thisStage:Stage;
      
      private var role1:BaseHero;
      
      private var role2:BaseHero;
      
      private var leftArray:Array;
      
      private var rightArray:Array;
      
      private var player1KeyArray:Array;
      
      private var player2KeyArray:Array;
      
      private var player1KeyInHostArray:Array;
      
      private var player2KeyInHostArray:Array;
      
      private var player1CanControl:Boolean = true;
      
      private var player2CanControl:Boolean = true;
      
      private var player1SkillArray:Array;
      
      private var player2SkillArray:Array;
      
      private var player1ShortcutKeyArray:Array;
      
      private var player2ShortcutKeyArray:Array;
      
      private var gc:Config;
      
      private var isStop:Boolean = false;
      
      public function KeyBoardControl(s:Stage)
      {
         leftArray = [65,37];
         rightArray = [68,39];
         player1KeyArray = [83,74,75,87];
         player2KeyArray = [40,97,98,38];
         player1KeyInHostArray = [83,75,65,68,87];
         player2KeyInHostArray = [40,98,37,39,38];
         player1SkillArray = [89,76,85,73,79,32,72];
         player2SkillArray = [104,99,100,101,102,96,103];
         player1ShortcutKeyArray = [67,86,66];
         player2ShortcutKeyArray = [111,106,109,107];
         super();
         gc = Config.getInstance();
         this.thisStage = s;
         this.thisStage.addEventListener("keyDown",__keyBoardDown);
         this.thisStage.addEventListener("keyUp",__keyBoardUp);
      }
      
      protected function __keyBoardDown(evt:KeyboardEvent) : void
      {
         if(this.thisStage.focus is TextField)
         {
            return;
         }
         KeyboardInput.getIns().keyDown(evt.keyCode);
         if(gc.isFramePk)
         {
            this.sendOperationToFb(evt.keyCode,0);
         }
         else
         {
            this.doKeyDown(evt.keyCode);
         }
      }
      
      private function sendOperationToFb(keyCode:int, oper:int) : void
      {
         var ssc:SocketsSendControl = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
         var sm:OperationSend = new OperationSend(keyCode,oper);
         if(oper == 0)
         {
            if(KeyboardInput.getIns().isJustKeyDown(keyCode))
            {
               ssc.sendToFb(sm);
            }
         }
         else if(oper == 1)
         {
            if(KeyboardInput.getIns().isJustKeyUp(keyCode))
            {
               ssc.sendToFb(sm);
            }
         }
      }
      
      public function doKeyDown(keyCode:int) : void
      {
         var ri:* = null;
         var shortCut:int = 0;
         var skillIdx1:int = 0;
         var skillIdx2:int = 0;
         if(gc.gameInfo)
         {
            if(!gc.isInWeiPk() && !gc.isInWeiPkHost())
            {
               shortCut = player1ShortcutKeyArray.indexOf(keyCode);
               if(shortCut == 0)
               {
                  if(role1 && gc.gameInfo)
                  {
                     ri = gc.gameInfo.getRoleInfoByPlayer(role1.getPlayer());
                     ri.btn_bb.dispatchEvent(new MouseEvent("click"));
                  }
               }
               else if(shortCut == 1)
               {
                  if(role1 && gc.gameInfo)
                  {
                     ri = gc.gameInfo.getRoleInfoByPlayer(role1.getPlayer());
                     ri.btn_study.dispatchEvent(new MouseEvent("click"));
                  }
               }
               else if(shortCut == 2)
               {
                  if(role1 && gc.gameInfo)
                  {
                     ri = gc.gameInfo.getRoleInfoByPlayer(role1.getPlayer());
                     ri.btn_cw.dispatchEvent(new MouseEvent("click"));
                  }
               }
               shortCut = player2ShortcutKeyArray.indexOf(keyCode);
               if(shortCut == 0 || shortCut == 3)
               {
                  if(role2 && gc.gameInfo)
                  {
                     ri = gc.gameInfo.getRoleInfoByPlayer(role2.getPlayer());
                     ri.btn_bb.dispatchEvent(new MouseEvent("click"));
                  }
               }
               else if(shortCut == 1)
               {
                  if(role2 && gc.gameInfo)
                  {
                     ri = gc.gameInfo.getRoleInfoByPlayer(role2.getPlayer());
                     ri.btn_study.dispatchEvent(new MouseEvent("click"));
                  }
               }
               else if(shortCut == 2)
               {
                  if(role2 && gc.gameInfo)
                  {
                     ri = gc.gameInfo.getRoleInfoByPlayer(role2.getPlayer());
                     ri.btn_cw.dispatchEvent(new MouseEvent("click"));
                  }
               }
            }
         }
         if(this.isStop)
         {
            return;
         }
         var evt:KeyboardEvent = new KeyboardEvent("keyDown",true,false,0,keyCode);
         if(player1CanControl)
         {
            if(gc.isInRoomOrSingleGame())
            {
               if(player1KeyArray.indexOf(keyCode) != -1 || keyCode == 65 || keyCode == 68)
               {
                  if(role1)
                  {
                     role1.__keyBoardDown(evt);
                  }
               }
               if(!gc.isInWeiPkHost())
               {
                  skillIdx1 = player1SkillArray.indexOf(keyCode);
                  if(skillIdx1 != -1)
                  {
                     if(role1)
                     {
                        role1.sendSkill(skillIdx1);
                     }
                  }
               }
            }
            else if(gc.isInHost())
            {
               if(player1KeyInHostArray.indexOf(keyCode) != -1)
               {
                  if(role1)
                  {
                     role1.__keyBoardDown(evt);
                  }
               }
            }
         }
         if(player2CanControl)
         {
            if(gc.isInRoomOrSingleGame())
            {
               if(player2KeyArray.indexOf(keyCode) != -1 || keyCode == 37 || keyCode == 39)
               {
                  if(role2)
                  {
                     role2.__keyBoardDown(evt);
                  }
               }
               if(!gc.isInWeiPkHost())
               {
                  skillIdx2 = player2SkillArray.indexOf(keyCode);
                  if(skillIdx2 != -1)
                  {
                     if(role2)
                     {
                        role2.sendSkill(skillIdx2);
                     }
                  }
               }
            }
            else if(gc.isInHost())
            {
               if(player2KeyInHostArray.indexOf(keyCode) != -1)
               {
                  if(role2)
                  {
                     role2.__keyBoardDown(evt);
                  }
               }
            }
         }
         if(player1CanControl)
         {
            if(gc.isInHost())
            {
               if(keyCode == 81)
               {
                  if(gc.pWorld.getBaseLevelListener() is StageListener01)
                  {
                     StageListener01(gc.pWorld.getBaseLevelListener()).checkRwOrPk();
                  }
               }
            }
         }
      }
      
      public function setNoControlByPlayer(p:User) : void
      {
         if(p.getControlPlayer() == 0)
         {
            this.player1CanControl = false;
         }
         else
         {
            this.player2CanControl = false;
         }
      }
      
      public function stopAllControl() : void
      {
         this.player1CanControl = false;
         this.player2CanControl = false;
      }
      
      public function continueAllControl() : void
      {
         this.player1CanControl = true;
         this.player2CanControl = true;
      }
      
      public function setYesControlByPlayer(p:User) : void
      {
         if(p.getControlPlayer() == 0)
         {
            this.player1CanControl = true;
         }
         else
         {
            this.player2CanControl = true;
         }
      }
      
      protected function __keyBoardUp(evt:KeyboardEvent) : void
      {
         KeyboardInput.getIns().keyUp(evt.keyCode);
         if(gc.isFramePk)
         {
            this.sendOperationToFb(evt.keyCode,1);
         }
         else
         {
            this.doKeyUp(evt.keyCode);
         }
      }
      
      public function doKeyUp(keyCode:int) : void
      {
         if(this.thisStage.focus is TextField)
         {
            return;
         }
         if(gc.isTest)
         {
            if(keyCode == 77)
            {
               if(MainGame.getInstance())
               {
                  if(gc.isStopGame)
                  {
                     MainGame.getInstance().continueGame();
                  }
                  else
                  {
                     MainGame.getInstance().stopGame();
                  }
               }
            }
            else if(keyCode == 78)
            {
               if(MainGame.getInstance())
               {
                  if(!gc.isStopGame)
                  {
                     for each(var bm in gc.pWorld.monsterArray)
                     {
                        if(!bm.isYourFather() && !bm.isDead())
                        {
                           bm.reduceHp(bm.getSHp());
                        }
                     }
                  }
               }
            }
            else if(keyCode == 90)
            {
               if(MainGame.getInstance())
               {
                  if(!gc.isStopGame)
                  {
                     for each(var bh in gc.getPlayerArray())
                     {
                        if(!bh.isYourFather() && !bh.isDead())
                        {
                           bh.reduceHp(bh.roleProperies.getSHHP());
                        }
                     }
                  }
               }
            }
         }
         KeyboardInput.getIns().keyUp(keyCode);
         if(this.isStop)
         {
            return;
         }
         if(gc.stage.focus != gc.stage)
         {
         }
         var evt:KeyboardEvent = new KeyboardEvent("keyUp",true,false,0,keyCode);
         if(player1CanControl)
         {
            if(role1)
            {
               role1.__keyBoardUp(evt);
            }
         }
         if(player2CanControl)
         {
            if(role2)
            {
               role2.__keyBoardUp(evt);
            }
         }
      }
      
      public function getKeyArrayByPlayer(p:User) : Array
      {
         if(p.getControlPlayer() == 0)
         {
            return this.player1KeyArray;
         }
         return this.player2KeyArray;
      }
      
      public function continueKeyboardControl() : void
      {
         this.isStop = false;
      }
      
      public function stopKeyboardControl() : void
      {
         this.isStop = true;
      }
      
      public function destroy() : void
      {
         this.thisStage.removeEventListener("keyUp",__keyBoardUp);
         this.thisStage.removeEventListener("keyDown",__keyBoardDown);
         this.player1CanControl = true;
         this.player2CanControl = true;
         this.role1 = null;
         this.role2 = null;
      }
      
      public function setRole1(r:BaseHero) : void
      {
         this.role1 = r;
         if(this.role1.getPlayer().getControlPlayer() == 0)
         {
            this.role1.setKeyList(this.player1KeyArray);
         }
         else
         {
            this.role1.setKeyList(this.player2KeyArray);
         }
      }
      
      public function setRole2(r:BaseHero) : void
      {
         this.role2 = r;
         if(this.role2.getPlayer().getControlPlayer() == 0)
         {
            this.role2.setKeyList(this.player1KeyArray);
         }
         else
         {
            this.role2.setKeyList(this.player2KeyArray);
         }
      }
      
      public function getRole1() : BaseHero
      {
         return this.role1;
      }
      
      public function getRole2() : BaseHero
      {
         return this.role2;
      }
      
      public function getLeftByPlayer(p:User) : int
      {
         return leftArray[p.getControlPlayer()];
      }
      
      public function getRightByPlayer(p:User) : int
      {
         return rightArray[p.getControlPlayer()];
      }
      
      public function getNormalAttackKeyCodeByPlayer(p:User) : int
      {
         if(p.getControlPlayer() == 0)
         {
            return player1KeyArray[1];
         }
         return player2KeyArray[1];
      }
      
      public function getCombo1ByPlayer(p:User) : String
      {
         if(p.getControlPlayer() == 0)
         {
            return "83,83,74";
         }
         return "40,40,97";
      }
      
      public function getCombo2ByPlayer(p:User) : String
      {
         if(p.getControlPlayer() == 0)
         {
            return "87,87,74";
         }
         return "38,38,97";
      }
      
      public function getCombo3ByPlayer(p:User) : String
      {
         if(p.getControlPlayer() == 0)
         {
            return "83,87,74";
         }
         return "40,38,97";
      }
      
      public function getFaBaoByPlayer(p:User) : String
      {
         if(p.getControlPlayer() == 0)
         {
            return player1SkillArray[6].toString();
         }
         return player2SkillArray[6].toString();
      }
      
      public function getSkillKeyByPlayerAndIndex(p:User, idx:uint) : uint
      {
         if(p.getControlPlayer() == 0)
         {
            return this.player1SkillArray[idx];
         }
         return this.player2SkillArray[idx];
      }
      
      public function getZeroKeyArray() : Array
      {
         var i:int = 0;
         var returnArr:Array = [];
         var maxLen:int = this.player1KeyArray.length;
         for(i = 0; i < maxLen; )
         {
            returnArr[i] = 0;
            i++;
         }
         return returnArr;
      }
      
      public function isInThisPlayerKeyboard(p:User, key:uint) : Boolean
      {
         if(p.getControlPlayer() == 0)
         {
            return this.player1KeyArray.indexOf(key) != -1 || key == this.getLeftByPlayer(p) || key == this.getRightByPlayer(p);
         }
         return this.player2KeyArray.indexOf(key) != -1 || key == this.getLeftByPlayer(p) || key == this.getRightByPlayer(p);
      }
   }
}
