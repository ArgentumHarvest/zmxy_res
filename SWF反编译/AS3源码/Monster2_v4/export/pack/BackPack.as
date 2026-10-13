package export.pack
{
   import base.*;
   import config.*;
   import export.hero.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import my.*;
   import user.*;
   
   public class BackPack extends Sprite
   {
       
      
      private var gc:Config;
      
      private var gzSprite:Sprite;
      
      public var btn_dj:SimpleButton;
      
      public var btn_zb:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      public var mc_exp:MovieClip;
      
      public var txt_name:TextField;
      
      public var txt_hp:TextField;
      
      public var txt_mp:TextField;
      
      public var txt_att:TextField;
      
      public var txt_def:TextField;
      
      public var txt_baoji:TextField;
      
      public var txt_sb:TextField;
      
      public var txt_hx:TextField;
      
      public var txt_hl:TextField;
      
      public var txt_lh:TextField;
      
      public var txt_zg:TextField;
      
      public var txt_exp:TextField;
      
      public var zbwq:Sprite;
      
      public var zbsp:Sprite;
      
      public var zbfj:Sprite;
      
      public var zbfb:Sprite;
      
      public var levelmc:MovieClip;
      
      public var personmc:MovieClip;
      
      private var packNum:uint = 1;
      
      private var hero:BaseHero;
      
      private var player:User;
      
      public function BackPack()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      public function setpack(param1:uint) : void
      {
         this.packNum = param1;
         this.hero = this.gc["hero" + this.packNum] as BaseHero;
         this.player = this.gc["player" + this.packNum] as User;
      }
      
      private function refreshZhangong(param1:Event) : void
      {
         this.txt_zg.text = this.gc.gongxun + "";
      }
      
      public function setInfoTxt() : void
      {
         this.personmc.gotoAndStop(this.hero.roleName);
         this.levelmc.gotoAndStop(this.hero.roleProperies.getLevel());
         this.mc_exp.gotoAndStop(Math.round(30 * this.hero.roleProperies.getExper() / this.hero.roleProperies.getExp()));
         if(this.gc.logInfo && this.gc.logInfo.name)
         {
            this.txt_name.text = this.gc.logInfo.name;
         }
         else
         {
            this.txt_name.text = this.hero.roleName;
         }
         this.txt_hp.text = this.hero.roleProperies.getHHP() + " / " + this.hero.roleProperies.getSHHP();
         this.txt_mp.text = this.hero.roleProperies.getMMP() + " / " + this.hero.roleProperies.getSMMP();
         this.txt_exp.text = this.hero.roleProperies.getExper() + " / " + this.hero.roleProperies.getExp();
         if(this.hero.roleProperies.baselowerpower != this.hero.roleProperies.baseuppower)
         {
            this.txt_att.text = this.hero.roleProperies.baselowerpower + this.hero.roleProperies.baseadd * (this.hero.roleProperies.getLevel() - 1) + this.hero.roleProperies.getaddPower() + "~" + (this.hero.roleProperies.baseuppower + this.hero.roleProperies.baseadd * (this.hero.roleProperies.getLevel() - 1) + this.hero.roleProperies.getaddPower());
         }
         else
         {
            this.txt_att.text = this.hero.roleProperies.baselowerpower + this.hero.roleProperies.baseadd * (this.hero.roleProperies.getLevel() - 1) + this.hero.roleProperies.getaddPower() + "";
         }
         this.txt_baoji.text = Math.round(this.hero.roleProperies.getCrit() * 100) + " %";
         this.txt_def.text = this.hero.roleProperies.getDefense() + "";
         this.txt_sb.text = Math.round(this.hero.roleProperies.getMiss() * 100) + " %";
         this.txt_hx.text = this.hero.roleProperies.getHx() + "";
         this.txt_hl.text = this.hero.roleProperies.getHl() + "";
         this.txt_lh.text = this.hero.getPlayer().protectedObject.lhValue + "";
         this.refreshZhangong(null);
         AUtils.checkLoadOK(this.personmc,this.updateRoleShow);
      }
      
      private function updateRoleShow() : void
      {
         if(this.hero is Role1)
         {
            this.changeWKShowEquip();
         }
         else if(this.hero is Role2)
         {
            this.changeTSShowEquip();
         }
      }
      
      private function added(param1:Event) : void
      {
         this.mc_exp.stop();
         this.curequip();
         this.setInfoTxt();
         this.btn_dj.addEventListener(MouseEvent.CLICK,this.selectType);
         this.btn_zb.addEventListener(MouseEvent.CLICK,this.selectType);
         this.btn_close.addEventListener(MouseEvent.CLICK,this.close);
         this.btn_zb.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         MainGame.getInstance().stopGame();
         this.gc.eventManger.addEventListener("refreshZhangong",this.refreshZhangong);
      }
      
      private function removed(param1:Event) : void
      {
         this.btn_dj.removeEventListener(MouseEvent.CLICK,this.selectType);
         this.btn_zb.removeEventListener(MouseEvent.CLICK,this.selectType);
         this.btn_close.removeEventListener(MouseEvent.CLICK,this.close);
         this.gc.eventManger.removeEventListener("refreshZhangong",this.refreshZhangong);
      }
      
      private function selectType(param1:MouseEvent) : void
      {
         if(this.gzSprite && contains(this.gzSprite))
         {
            this.removeChild(this.gzSprite);
            this.gzSprite = null;
         }
         this.gzSprite = new Sprite();
         this.gzSprite.x = 484.3;
         this.gzSprite.y = 120.35;
         this.addChildAt(this.gzSprite,this.numChildren - 6);
         switch(param1.currentTarget.name)
         {
            case "btn_dj":
               this.drawgz(this.gc.sdList,true);
               break;
            case "btn_zb":
               this.drawgz(this.player.zblist,false);
         }
      }
      
      private function close(param1:*) : void
      {
         MainGame.getInstance().continueGame();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function drawgz(param1:Array, param2:Boolean) : void
      {
         var _loc3_:PackThings = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < 5)
         {
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               _loc3_ = AUtils.getNewObj("export.pack.PackThings") as PackThings;
               _loc3_.x = _loc6_ * (_loc3_.width + 7);
               _loc3_.y = _loc5_ * (_loc3_.height + 7);
               this.gzSprite.addChildAt(_loc3_,0);
               trace("list[t]:" + param1[_loc4_]);
               if(param1[_loc4_])
               {
                  _loc3_.setObj(param1[_loc4_],this.packNum,param2);
                  _loc4_++;
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function equip(param1:String, param2:MyEquipObj) : *
      {
         var _loc3_:ShowObj = null;
         var _loc4_:int = 0;
         if(this[param1].getChildByName("curzb") != null)
         {
            _loc3_ = this[param1].getChildByName("curzb");
            this[param1].removeChild(_loc3_);
            this.hero.roleProperies.removeEquip(_loc3_.getMyEquipObj());
            _loc4_ = this.player.curarray.indexOf(_loc3_.getMyEquipObj());
            this.player.curarray.splice(_loc4_,1);
            this.player.zblist.push(_loc3_.getMyEquipObj());
            _loc3_ = null;
            this.btn_zb.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         this.player.curarray.push(param2);
         this.hero.roleProperies.addEquip(param2);
         this.curequip();
         this.hero.changeEquip(this.player.getEquipNum());
         this.setInfoTxt();
      }
      
      private function changeWKShowEquip() : void
      {
         var _loc1_:Object = this.player.getEquipNum();
         this.personmc["body"]["weapon1"].gotoAndStop(_loc1_.zbwq);
         this.personmc["body"]["cloth1"].gotoAndStop(_loc1_.zbfj);
         this.personmc["body"]["cloth2"].gotoAndStop(_loc1_.zbfj);
         this.personmc["body"]["cloth3"].gotoAndStop(_loc1_.zbfj);
         this.personmc["body"]["cloth4"].gotoAndStop(_loc1_.zbfj);
      }
      
      private function changeTSShowEquip() : void
      {
         var _loc1_:Object = this.player.getEquipNum();
         this.personmc["body"]["weapon1"].gotoAndStop(_loc1_.zbwq);
         this.personmc["body"]["cloth"].gotoAndStop(_loc1_.zbfj);
         this.personmc["body"]["head"].gotoAndStop(_loc1_.zbfj);
      }
      
      private function curequip() : void
      {
         var _loc2_:ShowObj = null;
         var _loc1_:uint = this.player.curarray.length;
         while(_loc1_-- > 0)
         {
            _loc2_ = new ShowObj(this.player.curarray[_loc1_],false);
            _loc2_.y = -2;
            if(this[this.player.curarray[_loc1_].type].numChildren <= 1)
            {
               this[this.player.curarray[_loc1_].type].addChild(_loc2_);
            }
         }
      }
   }
}
