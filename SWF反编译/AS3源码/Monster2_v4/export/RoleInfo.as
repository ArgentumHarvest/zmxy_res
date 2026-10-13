package export
{
   import base.*;
   import config.*;
   import event.*;
   import export.hero.*;
   import export.pack.*;
   import export.setmenu.*;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.text.TextField;
   
   public class RoleInfo extends Sprite
   {
       
      
      public var txthp:TextField;
      
      public var txtmp:TextField;
      
      public var txtexp:TextField;
      
      public var txtlevel:TextField;
      
      public var hpline:MovieClip;
      
      public var mpline:MovieClip;
      
      public var expline:MovieClip;
      
      public var wsmc:MovieClip;
      
      public var shows:MovieClip;
      
      public var bg:Sprite;
      
      public var head:MovieClip;
      
      public var zi:Sprite;
      
      public var skill1:MovieClip;
      
      public var skill2:MovieClip;
      
      public var skill3:MovieClip;
      
      public var skill4:MovieClip;
      
      public var skill5:MovieClip;
      
      public var btn_bb:SimpleButton;
      
      public var btn_set:SimpleButton;
      
      public var btn_study:SimpleButton;
      
      private var rn:uint;
      
      private var gc:Config;
      
      private var wsValueObject:Object;
      
      private var hero:BaseHero;
      
      var count:int;
      
      public function RoleInfo(param1:uint)
      {
         this.wsValueObject = {"wsValue":0};
         super();
         this.gc = Config.getInstance();
         this.rn = param1;
         this.hero = this.gc["hero" + this.rn];
         if(this.rn == 2)
         {
            this.setPos();
         }
         this.setHead();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function setHead() : void
      {
         this.head.gotoAndStop(this.gc["hero" + this.rn].roleName);
      }
      
      private function setPos() : void
      {
         AUtils.flipHorizontal(this.btn_bb,-1);
         AUtils.flipHorizontal(this.btn_study,-1);
         AUtils.flipHorizontal(this.btn_set,-1);
         AUtils.flipHorizontal(this.txtexp,-1);
         this.txtexp.x = 180;
         AUtils.flipHorizontal(this.txthp,-1);
         this.txthp.x = 180;
         AUtils.flipHorizontal(this.txtmp,-1);
         this.txtmp.x = 180;
         AUtils.flipHorizontal(this.txtlevel,-1);
         this.txtlevel.x = 15;
         this.bg.x -= 20;
         this.head.x -= 20;
         this.hpline.x -= 20;
         this.mpline.x -= 20;
         this.expline.x -= 20;
         this.zi.x -= 20;
         AUtils.flipHorizontal(this.shows,-1);
         this.shows.x = 110;
         AUtils.flipHorizontal(this.zi,-1);
         this.wsmc.x -= 8;
      }
      
      private function setSkillIcon() : void
      {
         var _loc1_:int = this.hero.getPlayer().isstudyskill.length;
         while(_loc1_-- > 0)
         {
            if(this.hero.getPlayer().isstudyskill[_loc1_] == 1)
            {
               if(this.hero is Role1)
               {
                  this["skill" + (_loc1_ + 1)].gotoAndStop(_loc1_ + 2);
               }
               else
               {
                  this["skill" + (_loc1_ + 1)].gotoAndStop(_loc1_ + 7);
               }
            }
         }
      }
      
      private function added(param1:*) : void
      {
         this.btn_bb.addEventListener(MouseEvent.CLICK,this.showBackPack);
         this.btn_set.addEventListener(MouseEvent.CLICK,this.setClick);
         this.btn_study.addEventListener(MouseEvent.CLICK,this.studySkill);
         this.gc.eventManger.addEventListener("keyboard_up",this._keyboardUp);
      }
      
      private function removed(param1:*) : void
      {
         this.btn_bb.removeEventListener(MouseEvent.CLICK,this.showBackPack);
         this.btn_set.removeEventListener(MouseEvent.CLICK,this.setClick);
         this.btn_study.removeEventListener(MouseEvent.CLICK,this.studySkill);
         this.gc.eventManger.removeEventListener("keyboard_up",this._keyboardUp);
      }
      
      private function _keyboardUp(param1:CommonEvent) : void
      {
         var _loc2_:int = param1.data;
         if(_loc2_ == 67)
         {
            this.showBackPack(null);
         }
         else if(_loc2_ == 86)
         {
            this.studySkill(null);
         }
      }
      
      public function step() : void
      {
         this.setSkillIcon();
         this.txthp.text = this.hero.roleProperies.getHHP() + "/" + this.hero.roleProperies.getSHHP();
         this.hpline.gotoAndStop(Math.round(100 * (1 - this.hero.roleProperies.getHHP() / this.hero.roleProperies.getSHHP())) + 1);
         this.txtmp.text = this.hero.roleProperies.getMMP() + "/" + this.hero.roleProperies.getSMMP();
         this.mpline.gotoAndStop(Math.round(100 * (1 - this.hero.roleProperies.getMMP() / this.hero.roleProperies.getSMMP())) + 1);
         this.txtexp.text = this.hero.roleProperies.getExper() + "/" + this.hero.roleProperies.getExp();
         this.expline.gotoAndStop(Math.round(100 * (1 - this.hero.roleProperies.getExper() / this.hero.roleProperies.getExp())) + 1);
         this.txtlevel.text = this.hero.roleProperies.getLevel() + "";
         this.lessWs();
         this.wsmc.gotoAndStop(this.wsValueObject.wsValue);
         if(this.wsValueObject.wsValue < 100 && this.shows.currentFrame == 2)
         {
            this.shows.gotoAndStop(1);
         }
      }
      
      private function showBackPack(param1:MouseEvent) : void
      {
         var _loc2_:BackPack = AUtils.getNewObj("export.pack.BackPack") as BackPack;
         _loc2_.setpack(this.rn);
         this.parent.addChild(_loc2_);
      }
      
      private function setClick(param1:MouseEvent) : void
      {
         var _loc2_:SetMenu = AUtils.getNewObj("export.setmenu.SetMenu") as SetMenu;
         this.parent.addChild(_loc2_);
      }
      
      private function studySkill(param1:MouseEvent) : void
      {
         this.gc.eventManger.dispatchEvent(new CommonEvent("showBuySkill",{"state":"gameing"}));
      }
      
      public function addWs(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BaseHero = param1[1] as BaseHero;
         var _loc4_:int = 2;
         if(this.gc.gameMode == 3)
         {
            _loc4_ = 8;
         }
         _loc2_ = Math.round(param1[0] / _loc3_.roleProperies.getBasePower() * _loc4_);
         if(!_loc3_.isGXP && this.wsValueObject.wsValue + _loc2_ <= 100 && _loc3_ == this.hero)
         {
            this.wsValueObject = AUtils.clone(this.wsValueObject);
            this.wsValueObject.wsValue += _loc2_;
            if(this.isGXPReady())
            {
               this.shows.gotoAndStop(2);
            }
         }
      }
      
      private function lessWs() : void
      {
         if(this.wsValueObject.wsValue >= 100)
         {
            return;
         }
         if(this.count >= 24)
         {
            if(this.wsValueObject.wsValue-- <= 0)
            {
               this.wsValueObject.wsValue = 0;
            }
            this.count = 0;
         }
         ++this.count;
      }
      
      public function addWarriors(param1:*) : void
      {
         if(param1[0] == this.hero)
         {
            if(!this.hero.isDead())
            {
               if(this.hero.roleProperies.getHHP() + param1[1] <= this.hero.roleProperies.getSHHP())
               {
                  this.hero.roleProperies.setHHP(this.hero.roleProperies.getHHP() + param1[1]);
               }
               else
               {
                  this.hero.roleProperies.setHHP(this.hero.roleProperies.getSHHP());
               }
            }
            if(this.hero.roleProperies.getMMP() + param1[2] <= this.hero.roleProperies.getSMMP())
            {
               this.hero.roleProperies.setMMP(this.hero.roleProperies.getMMP() + param1[2]);
            }
            else
            {
               this.hero.roleProperies.setMMP(this.hero.roleProperies.getSMMP());
            }
            this.hero.getPlayer().protectedObject = AUtils.clone(this.hero.getPlayer().protectedObject);
            this.hero.getPlayer().protectedObject.lhValue = this.hero.getPlayer().protectedObject.lhValue + param1[3];
            this.hero.getPlayer().protectedObject.myscore = this.hero.getPlayer().protectedObject.myscore + param1[3];
            if(int(this.wsValueObject.wsValue + param1[4]) <= 100)
            {
               this.wsValueObject = AUtils.clone(this.wsValueObject);
               this.wsValueObject.wsValue += param1[4];
               if(this.isGXPReady())
               {
                  this.shows.gotoAndStop(2);
               }
            }
         }
      }
      
      public function isGXPReady() : Boolean
      {
         return this.wsValueObject.wsValue >= 100;
      }
      
      public function isGXPAlive() : Boolean
      {
         return this.wsValueObject.wsValue > 0;
      }
      
      public function reduceGXP(param1:int) : void
      {
         this.wsValueObject = AUtils.clone(this.wsValueObject);
         this.wsValueObject.wsValue -= param1;
         if(this.wsValueObject.wsValue < 0)
         {
            this.wsValueObject.wsValue = 0;
         }
      }
   }
}
