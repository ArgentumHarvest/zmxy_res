package my
{
   import base.BaseHero;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
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
      
      private var player1CanControl:Boolean = true;
      
      private var player2CanControl:Boolean = true;
      
      private var player1SkillArray:Array;
      
      private var player2SkillArray:Array;
      
      public function KeyBoardControl(param1:Stage)
      {
         this.leftArray = [65,37];
         this.rightArray = [68,39];
         this.player1KeyArray = [83,74,75,87];
         this.player2KeyArray = [40,97,98,38];
         this.player1SkillArray = [76,85,73,79,32];
         this.player2SkillArray = [99,100,101,102,96];
         super();
         this.thisStage = param1;
         this.thisStage.addEventListener(KeyboardEvent.KEY_DOWN,this.__keyBoardDown);
         this.thisStage.addEventListener(KeyboardEvent.KEY_UP,this.__keyBoardUp);
      }
      
      protected function __keyBoardDown(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.player1CanControl)
         {
            if(this.player1KeyArray.indexOf(param1.keyCode) != -1 || param1.keyCode == 65 || param1.keyCode == 68)
            {
               if(this.role1)
               {
                  this.role1.__keyBoardDown(param1);
               }
            }
            _loc2_ = this.player1SkillArray.indexOf(param1.keyCode);
            if(_loc2_ != -1)
            {
               if(this.role1)
               {
                  this.role1.sendSkill(_loc2_);
               }
            }
         }
         if(this.player2CanControl)
         {
            if(this.player2KeyArray.indexOf(param1.keyCode) != -1 || param1.keyCode == 37 || param1.keyCode == 39)
            {
               if(this.role2)
               {
                  this.role2.__keyBoardDown(param1);
               }
            }
            _loc3_ = this.player2SkillArray.indexOf(param1.keyCode);
            if(_loc3_ != -1)
            {
               if(this.role2)
               {
                  this.role2.sendSkill(_loc3_);
               }
            }
         }
      }
      
      public function setNoControlByPlayer(param1:User) : void
      {
         if(param1.getControlPlayer() == 0)
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
      
      public function setYesControlByPlayer(param1:User) : void
      {
         if(param1.getControlPlayer() == 0)
         {
            this.player1CanControl = true;
         }
         else
         {
            this.player2CanControl = true;
         }
      }
      
      protected function __keyBoardUp(param1:KeyboardEvent) : void
      {
         if(this.role1)
         {
            this.role1.__keyBoardUp(param1);
         }
         if(this.role2)
         {
            this.role2.__keyBoardUp(param1);
         }
      }
      
      public function getKeyArrayByPlayer(param1:User) : Array
      {
         if(param1.getControlPlayer() == 0)
         {
            return this.player1KeyArray;
         }
         return this.player2KeyArray;
      }
      
      public function continueKeyboardControl() : void
      {
         this.thisStage.addEventListener(KeyboardEvent.KEY_DOWN,this.__keyBoardDown);
         this.thisStage.addEventListener(KeyboardEvent.KEY_UP,this.__keyBoardUp);
      }
      
      public function stopKeyboardControl() : void
      {
         this.thisStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.__keyBoardDown);
         this.thisStage.removeEventListener(KeyboardEvent.KEY_UP,this.__keyBoardUp);
      }
      
      public function destroy() : void
      {
         this.stopKeyboardControl();
         this.player1CanControl = true;
         this.player2CanControl = true;
      }
      
      public function setRole1(param1:BaseHero) : void
      {
         this.role1 = param1;
         if(this.role1.getPlayer().getControlPlayer() == 0)
         {
            this.role1.setKeyList(this.player1KeyArray);
         }
         else
         {
            this.role1.setKeyList(this.player2KeyArray);
         }
      }
      
      public function setRole2(param1:BaseHero) : void
      {
         this.role2 = param1;
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
      
      public function getLeftByPlayer(param1:User) : int
      {
         return this.leftArray[param1.getControlPlayer()];
      }
      
      public function getRightByPlayer(param1:User) : int
      {
         return this.rightArray[param1.getControlPlayer()];
      }
      
      public function getNormalAttackKeyCodeByPlayer(param1:User) : int
      {
         if(param1.getControlPlayer() == 0)
         {
            return this.player1KeyArray[1];
         }
         return this.player2KeyArray[1];
      }
      
      public function getZeroKeyArray() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = this.player1KeyArray.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_[_loc3_] = 0;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function isInThisPlayerKeyboard(param1:User, param2:uint) : Boolean
      {
         if(param1.getControlPlayer() == 0)
         {
            return this.player1KeyArray.indexOf(param2) != -1 || param2 == this.getLeftByPlayer(param1) || param2 == this.getRightByPlayer(param1);
         }
         return this.player2KeyArray.indexOf(param2) != -1 || param2 == this.getLeftByPlayer(param1) || param2 == this.getRightByPlayer(param1);
      }
   }
}
