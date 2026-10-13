package export.shop
{
   import base.BaseHero;
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class SkillControl extends Sprite
   {
       
      
      private var role:BaseHero;
      
      private var gc:Config;
      
      public var txtlh:TextField;
      
      public var instrmc:MovieClip;
      
      public var roleskillbtn:MovieClip;
      
      public var bgmc:MovieClip;
      
      public var passivebtn:SimpleButton;
      
      public var activebtn:SimpleButton;
      
      public function SkillControl(param1:BaseHero)
      {
         super();
         this.gc = Config.getInstance();
         this.role = param1;
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : void
      {
         this.activebtn.addEventListener(MouseEvent.CLICK,this.activeSkill);
         this.passivebtn.addEventListener(MouseEvent.CLICK,this.passiveSkill);
         this.instrmc.gotoAndStop(this.role.roleName);
         this.activebtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         this.txtlh.text = this.role.getPlayer().protectedObject.lhValue;
      }
      
      public function setTxtlh() : void
      {
         this.txtlh.text = this.role.getPlayer().protectedObject.lhValue;
      }
      
      private function initActiveSkill() : void
      {
         if(this.role.getPlayer().getControlPlayer() == 1)
         {
            this.instrmc["roleskillbtn"].gotoAndStop(2);
         }
         else if(this.role.getPlayer().getControlPlayer() == 0)
         {
            this.instrmc["roleskillbtn"].gotoAndStop(1);
         }
         var _loc1_:uint = this.role.getPlayer().isstudyskill.length;
         while(_loc1_-- > 0)
         {
            this.instrmc["skill" + (_loc1_ + 1)].buttonMode = true;
            if(this.role.getPlayer().isstudyskill[_loc1_] == 0)
            {
               this.instrmc["skill" + (_loc1_ + 1)].addEventListener(MouseEvent.CLICK,this.buy);
            }
            else
            {
               this.instrmc["skill" + (_loc1_ + 1)].gotoAndStop(2);
            }
         }
      }
      
      private function initPassiveSkill() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 5)
         {
            this.instrmc["pskill" + (_loc1_ + 1)].setRole(this.role);
            _loc1_++;
         }
      }
      
      private function removed(param1:Event) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            if(this.instrmc["skill" + (_loc2_ + 1)])
            {
               this.instrmc["skill" + (_loc2_ + 1)].removeEventListener(MouseEvent.CLICK,this.buy);
            }
            _loc2_++;
         }
      }
      
      private function activeSkill(param1:*) : void
      {
         this.instrmc.gotoAndStop(this.role.roleName);
         this.bgmc.gotoAndStop(1);
         AUtils.checkLoadOK(this.instrmc,this.initActiveSkill);
      }
      
      private function passiveSkill(param1:*) : void
      {
         this.bgmc.gotoAndStop(2);
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            if(this.instrmc["skill" + (_loc2_ + 1)])
            {
               this.instrmc["skill" + (_loc2_ + 1)].removeEventListener(MouseEvent.CLICK,this.buy);
            }
            _loc2_++;
         }
         this.instrmc.gotoAndStop(3);
         AUtils.checkLoadOK(this.instrmc,this.initPassiveSkill);
      }
      
      private function buy(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         switch(param1.currentTarget.name)
         {
            case "skill1":
               if(this.role.getPlayer().protectedObject.lhValue >= 100)
               {
                  this.role.getPlayer().isstudyskill[0] = 1;
                  this.instrmc["skill1"].gotoAndStop(2);
                  this.instrmc["skill1"].removeEventListener(MouseEvent.CLICK,this.buy);
                  _loc2_ = 100;
               }
               break;
            case "skill2":
               if(this.role.getPlayer().protectedObject.lhValue >= 200)
               {
                  this.role.getPlayer().isstudyskill[1] = 1;
                  this.instrmc["skill2"].gotoAndStop(2);
                  this.instrmc["skill2"].removeEventListener(MouseEvent.CLICK,this.buy);
                  _loc2_ = 200;
               }
               break;
            case "skill3":
               if(this.role.getPlayer().protectedObject.lhValue >= 500)
               {
                  this.role.getPlayer().isstudyskill[2] = 1;
                  this.instrmc["skill3"].gotoAndStop(2);
                  this.instrmc["skill3"].removeEventListener(MouseEvent.CLICK,this.buy);
                  _loc2_ = 500;
               }
               break;
            case "skill4":
               if(this.role.getPlayer().protectedObject.lhValue >= 1000)
               {
                  this.role.getPlayer().isstudyskill[3] = 1;
                  this.instrmc["skill4"].gotoAndStop(2);
                  this.instrmc["skill4"].removeEventListener(MouseEvent.CLICK,this.buy);
                  _loc2_ = 1000;
               }
               break;
            case "skill5":
               if(this.role.getPlayer().protectedObject.lhValue >= 2000)
               {
                  this.role.getPlayer().isstudyskill[4] = 1;
                  this.instrmc["skill5"].gotoAndStop(2);
                  this.instrmc["skill5"].removeEventListener(MouseEvent.CLICK,this.buy);
                  _loc2_ = 2000;
               }
         }
         this.role.getPlayer().protectedObject = AUtils.clone(this.role.getPlayer().protectedObject);
         this.role.getPlayer().protectedObject.lhValue = this.role.getPlayer().protectedObject.lhValue - _loc2_;
         this.setTxtlh();
      }
   }
}
