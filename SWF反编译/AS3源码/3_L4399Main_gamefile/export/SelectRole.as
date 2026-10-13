package export
{
   import com.hexagonstar.util.debug.Debug;
   import config.Config;
   import event.CommonEvent;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SelectRole extends Sprite
   {
       
      
      public var btn1:SimpleButton;
      
      public var btn2:SimpleButton;
      
      public var btn3:SimpleButton;
      
      public var btn4:SimpleButton;
      
      public var curSelected:uint = 1;
      
      public var startBtn:SimpleButton;
      
      public var backBtn:SimpleButton;
      
      public var resetBtn:SimpleButton;
      
      private var gc:Config;
      
      private var temp1:DisplayObject;
      
      private var temp2:DisplayObject;
      
      private var chooseTarget1:SimpleButton;
      
      private var chooseTarget2:SimpleButton;
      
      private var roleId1:int = -1;
      
      private var roleId2:int = -1;
      
      public function SelectRole()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         Debug.trace("selectRole--added");
         btn1.addEventListener("rollOver",over);
         btn1.addEventListener("rollOut",out);
         btn2.addEventListener("rollOver",over);
         btn2.addEventListener("rollOut",out);
         btn1.addEventListener("click",onClick);
         btn2.addEventListener("click",onClick);
         btn3.addEventListener("rollOver",over);
         btn3.addEventListener("rollOut",out);
         btn3.addEventListener("click",onClick);
         btn4.addEventListener("rollOver",over);
         btn4.addEventListener("rollOut",out);
         btn4.addEventListener("click",onClick);
         startBtn.addEventListener("click",__startGame);
         backBtn.addEventListener("click",__backToMenu);
         resetBtn.addEventListener("click",__reset);
         if(gc.playNum == 1)
         {
            resetBtn.visible = false;
         }
         gc.eventManger.addEventListener("RemoveSelectRoleInterface",removeSelf);
      }
      
      protected function __reset(event:MouseEvent) : void
      {
         this.resetInDouble();
      }
      
      protected function __backToMenu(event:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("RemoveSelectRoleInterface"));
         GMain.getInstance().switchSence("GameMenu");
      }
      
      protected function __startGame(event:MouseEvent) : void
      {
         if(gc.playNum == 1)
         {
            if(!chooseTarget1)
            {
               gc.ts.setTxt("请先选择完角色再开始游戏！");
               gc.stage.addChild(gc.ts);
               return;
            }
         }
         else if(!chooseTarget1 || !chooseTarget2)
         {
            gc.ts.setTxt("请先选择完角色再开始游戏！");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.selectOver();
      }
      
      private function removed(e:*) : void
      {
         trace("-------SelectRoleRemove--------");
         btn1.removeEventListener("rollOver",over);
         btn1.removeEventListener("rollOut",out);
         btn2.removeEventListener("rollOver",over);
         btn2.removeEventListener("rollOut",out);
         btn1.removeEventListener("click",onClick);
         btn2.removeEventListener("click",onClick);
         btn3.removeEventListener("rollOver",over);
         btn3.removeEventListener("rollOut",out);
         btn3.removeEventListener("click",onClick);
         btn4.removeEventListener("rollOver",over);
         btn4.removeEventListener("rollOut",out);
         btn4.removeEventListener("click",onClick);
         startBtn.removeEventListener("click",__startGame);
         backBtn.removeEventListener("click",__backToMenu);
         resetBtn.removeEventListener("click",__reset);
         gc.eventManger.removeEventListener("RemoveSelectRoleInterface",removeSelf);
      }
      
      private function over(e:MouseEvent) : void
      {
      }
      
      private function showP(button:SimpleButton, select:int) : void
      {
         var arrow:* = undefined;
         if(select < 3)
         {
            arrow = AUtils.getImageObj(select + "P");
            arrow.name = "arrow" + select;
            arrow.x = button.x - 50;
            arrow.y = 40;
            this.addChild(arrow);
         }
      }
      
      private function hideP(select:int) : void
      {
         if(select < 3)
         {
            if(this.getChildByName("arrow" + select) != null)
            {
               this.removeChild(this.getChildByName("arrow" + select));
            }
         }
      }
      
      private function out(e:MouseEvent) : void
      {
         if(gc.playNum > 1)
         {
            hideP(this.curSelected);
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var target:* = null;
         target = null;
         var bool:Boolean = false;
         if(!gc.isHideDebug)
         {
         }
         if(gc.playNum == 1)
         {
            target = e.currentTarget as SimpleButton;
            this.selectOneInSingle(target,1);
            roleId1 = int(String(e.currentTarget.name).substr(3,1));
            return;
         }
         if(this.curSelected < 3)
         {
            target = e.currentTarget as SimpleButton;
            bool = this.selectOneInDouble(target,this.curSelected);
            if(bool)
            {
               if(this.curSelected == 1)
               {
                  roleId1 = int(String(e.currentTarget.name).substr(3,1));
               }
               else
               {
                  roleId2 = int(String(e.currentTarget.name).substr(3,1));
               }
               this.curSelected++;
            }
         }
      }
      
      private function selectOneInSingle(target:SimpleButton, select:int) : void
      {
         hideP(select);
         if(chooseTarget1)
         {
            chooseTarget1.upState = temp1;
         }
         if(target.upState != target.downState)
         {
            temp1 = target.upState;
            target.upState = target.downState;
            chooseTarget1 = target;
            showP(target,select);
         }
      }
      
      private function selectOneInDouble(target:SimpleButton, select:int) : Boolean
      {
         if(target.upState != target.downState)
         {
            if(select == 1)
            {
               chooseTarget1 = target;
               temp1 = target.upState;
            }
            else
            {
               chooseTarget2 = target;
               temp2 = target.upState;
            }
            target.upState = target.downState;
            showP(target,select);
            return true;
         }
         return false;
      }
      
      private function resetInDouble() : void
      {
         this.curSelected = 1;
         this.hideP(1);
         this.hideP(2);
         this.resetBtns();
         chooseTarget1 = null;
         chooseTarget2 = null;
      }
      
      private function resetBtns() : void
      {
         if(chooseTarget1 && temp1)
         {
            chooseTarget1.upState = temp1;
         }
         if(chooseTarget2 && temp2)
         {
            chooseTarget2.upState = temp2;
         }
      }
      
      private function selectOver() : void
      {
         gc.gameinwhere = "开场";
         if(gc.playNum == 1)
         {
            gc.player1.roleid = roleId1;
            gc.player2.roleid = 0;
         }
         else
         {
            gc.player1.roleid = roleId1;
            gc.player2.roleid = roleId2;
         }
         this.doAfterChangeOut();
      }
      
      public function doAfterChangeOut() : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("SelectOver"));
      }
      
      public function doAfterChangeIn() : void
      {
         this.visible = true;
      }
      
      private function removeSelf(e:CommonEvent) : void
      {
         trace("SelectRole--removeSelf");
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         temp1 = null;
         chooseTarget1 = null;
         chooseTarget2 = null;
      }
   }
}
