package export
{
   import AssetsClass.BackPackInterfaceAssets;
   import AssetsClass.PetInterfaceAssets;
   import AssetsClass.SutraInterfaceAssets;
   import base.BaseAddEffect;
   import base.BaseHero;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.pet.ShowPetInfo;
   import export.setmenu.SetMenu;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import my.MainGame;
   import petInfo.PetInfo;
   
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
      
      public var Yskill:Sprite;
      
      public var Uskill:Sprite;
      
      public var Iskill:Sprite;
      
      public var Oskill:Sprite;
      
      public var Lskill:Sprite;
      
      public var btn_bb:SimpleButton;
      
      public var btn_set:SimpleButton;
      
      public var btn_study:SimpleButton;
      
      public var btn_fb:SimpleButton;
      
      public var btn_cw:SimpleButton;
      
      private var wsValue1:int;
      
      private var wsValue2:int;
      
      private var wsValue3:Number;
      
      private var rn:uint;
      
      private var gc:Config;
      
      private var petHead:ShowPetInfo;
      
      private var skillIconSprite:Sprite;
      
      private var heroBuffSprite:Sprite;
      
      private var hero:BaseHero;
      
      private var _anti:Antiwear;
      
      var count:int;
      
      public function RoleInfo(_rn:uint)
      {
         skillIconSprite = new Sprite();
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this.addChild(skillIconSprite);
         this.rn = _rn;
         hero = gc["hero" + this.rn];
         if(this.rn == 2 || this.rn == 3)
         {
            this.setPos();
         }
         this.setHead();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         this.setWsValue(0);
      }
      
      private function setHead() : void
      {
         if(this.head)
         {
            this.head.gotoAndStop(gc["player" + this.rn].roleid);
         }
      }
      
      private function setPos() : void
      {
         this.Yskill.x += 159;
         this.Uskill.x += 80;
         this.Oskill.x -= 80;
         this.Lskill.x -= 159;
         AUtils.flipHorizontal(this.btn_bb,-1);
         AUtils.flipHorizontal(this.btn_study,-1);
         AUtils.flipHorizontal(this.btn_set,-1);
         AUtils.flipHorizontal(this.btn_fb,-1);
         AUtils.flipHorizontal(this.btn_cw,-1);
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
         var _1len:* = 0;
         var _2len:* = 0;
         var img:* = undefined;
         var sprite:* = null;
         var smallShow:* = null;
         var _1p:Array = ["Y","U","I","O","L"];
         var _2p:Array = ["8","4","5","6","3"];
         if(this.rn == 1)
         {
            for(_1len = uint(_1p.length); _1len-- > 0; )
            {
               if(this.getChildByName("initsprite" + _1p[_1len]))
               {
                  this.removeChild(this.getChildByName("initsprite" + _1p[_1len]));
               }
            }
         }
         else
         {
            for(_2len = uint(_2p.length); _2len-- > 0; )
            {
               if(this.getChildByName("initsprite" + _2p[_2len]))
               {
                  this.removeChild(this.getChildByName("initsprite" + _2p[_2len]));
               }
            }
         }
         var slen:uint = this.hero.getPlayer().skillbykey.length;
         trace("技能-slen----->>" + slen);
         var keys:String = "";
         for(var showKeys:String = ""; slen-- > 0; )
         {
            if(this.getChildByName("initsprite" + this.hero.getPlayer().skillbykey[slen].keys))
            {
               this.removeChild(this.getChildByName("initsprite" + this.hero.getPlayer().skillbykey[slen].keys));
            }
            img = AUtils.getImageObj("ss_" + this.hero.getPlayer().skillbykey[slen].skillName);
            sprite = new Sprite();
            sprite.name = "initsprite" + this.hero.getPlayer().skillbykey[slen].keys;
            sprite.addChild(img);
            showKeys = this.hero.getPlayer().skillbykey[slen].keys;
            if(this.hero.getPlayer().controlPlayer == 0)
            {
               keys = this.hero.getPlayer().skillbykey[slen].keys;
            }
            else
            {
               keys = this.hero.getPlayer().skillbykey[slen].keys;
               if(keys == "8")
               {
                  keys = "Y";
               }
               else if(keys == "4")
               {
                  keys = "U";
               }
               else if(keys == "5")
               {
                  keys = "I";
               }
               else if(keys == "6")
               {
                  keys = "O";
               }
               else if(keys == "3")
               {
                  keys = "L";
               }
               else if(keys == "Y")
               {
                  showKeys = "8";
               }
               else if(keys == "U")
               {
                  showKeys = "4";
               }
               else if(keys == "I")
               {
                  showKeys = "5";
               }
               else if(keys == "O")
               {
                  showKeys = "6";
               }
               else if(keys == "L")
               {
                  showKeys = "3";
               }
            }
            skillIconSprite.addChild(sprite);
            if(this.rn == 2 || this.rn == 3)
            {
               AUtils.flipHorizontal(sprite,-1);
               sprite.x = this[keys + "skill"].x + this[keys + "skill"].width / 2;
               sprite.y = this[keys + "skill"].y - this[keys + "skill"].height / 2;
            }
            else
            {
               sprite.x = this[keys + "skill"].x - this[keys + "skill"].width / 2;
               sprite.y = this[keys + "skill"].y - this[keys + "skill"].height / 2;
            }
            smallShow = new Sprite();
            smallShow.addChild(AUtils.getImageObj("Skill_" + showKeys));
            smallShow.x = sprite.width / 2;
            smallShow.y = sprite.height / 2 - 4;
            sprite.addChild(smallShow);
         }
      }
      
      private function added(e:*) : void
      {
         trace("roleinfo--added");
         btn_bb.addEventListener("click",showBackPack);
         btn_set.addEventListener("click",setClick);
         btn_study.addEventListener("click",studySkill);
         btn_fb.addEventListener("click",fbClick);
         btn_cw.addEventListener("click",cwClick);
         gc.eventManger.addEventListener("InGameBuySkillOver",refreshShowSkill);
         gc.eventManger.addEventListener("CHANGECURRENTPET",changeCurPet);
         this.setSkillIcon();
         this.addPetHead();
      }
      
      private function removed(e:*) : void
      {
         btn_bb.removeEventListener("click",showBackPack);
         btn_set.removeEventListener("click",setClick);
         btn_study.removeEventListener("click",studySkill);
         btn_fb.removeEventListener("click",fbClick);
         btn_cw.removeEventListener("click",cwClick);
         gc.eventManger.removeEventListener("InGameBuySkillOver",refreshShowSkill);
         gc.eventManger.removeEventListener("CHANGECURRENTPET",changeCurPet);
         this.hero = null;
      }
      
      public function step() : void
      {
         var str:* = null;
         if(!hero || !hero.roleProperies)
         {
            str = this.txthp.text;
            str = str.split("/")[1];
            this.txthp.text = "0/" + str;
            this.hpline.gotoAndStop(101);
            return;
         }
         try
         {
            this.txthp.text = hero.roleProperies.getHHP() + "/" + hero.roleProperies.getSHHP();
            this.hpline.gotoAndStop(Math.round(100 * (1 - hero.roleProperies.getHHP() / hero.roleProperies.getSHHP())) + 1);
            this.txtmp.text = hero.roleProperies.getMMP() + "/" + hero.roleProperies.getSMMP();
            this.mpline.gotoAndStop(Math.round(100 * (1 - hero.roleProperies.getMMP() / hero.roleProperies.getSMMP())) + 1);
            this.txtexp.text = hero.roleProperies.getExper() + "/" + hero.roleProperies.getExp();
            this.expline.gotoAndStop(Math.round(100 * (1 - hero.roleProperies.getExper() / hero.roleProperies.getExp())) + 1);
            this.txtlevel.text = hero.roleProperies.getLevel() + "";
            this.lessWs();
            this.wsmc.gotoAndStop(this.getWsValue());
            if(this.getWsValue() < 100 && this.shows.currentFrame == 2)
            {
               this.shows.gotoAndStop(1);
            }
            if(this.petHead)
            {
               this.petHead.show();
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function addHeroBuff() : void
      {
         if(!this.heroBuffSprite)
         {
            this.heroBuffSprite = new Sprite();
            this.heroBuffSprite.x = 90;
            this.heroBuffSprite.y = 75;
            this.addChild(this.heroBuffSprite);
         }
         this.refreshBuffIcon();
      }
      
      public function setSkillEnabled(enabled:Boolean = true) : void
      {
         var filter:* = null;
         if(!enabled)
         {
            filter = new ColorMatrixFilter([0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,0,0.5,0.5,0.5,0,0,0,0,0,1,0]);
            skillIconSprite.filters = [filter];
         }
         else
         {
            skillIconSprite.filters = [];
         }
      }
      
      private function refreshBuffIcon() : void
      {
         var o:* = null;
         var tl:* = 0;
         var icon:* = null;
         var totalBuffLen:* = 0;
         var bm:* = null;
         if(!this.heroBuffSprite)
         {
            return;
         }
         while(this.heroBuffSprite.numChildren > 0)
         {
            this.heroBuffSprite.removeChild(this.heroBuffSprite.getChildAt(0));
         }
         var buffArray:Array = [{
            "name":BaseAddEffect.MEIGUI_BUFF,
            "sourceName":"meigui_buff"
         }];
         for each(var obj in buffArray)
         {
            if(this.hero && this.hero.curAddEffect)
            {
               o = this.hero.curAddEffect.getBuffByName(obj.name);
               if(o)
               {
                  if(!this.heroBuffSprite.getChildByName(obj.name))
                  {
                     tl = uint(this.heroBuffSprite.numChildren);
                     icon = AUtils.getImageObj(obj.sourceName) as Bitmap;
                     icon.name = obj.name;
                     icon.x = tl * 30;
                     this.heroBuffSprite.addChild(icon);
                  }
               }
            }
         }
         if(gc.isDoubleExp)
         {
            if(!this.heroBuffSprite.getChildByName("doubleExp"))
            {
               totalBuffLen = uint(this.heroBuffSprite.numChildren);
               bm = AUtils.getImageObj("doubleExp") as Bitmap;
               bm.name = "doubleExp";
               bm.x = totalBuffLen * 30;
               this.heroBuffSprite.addChild(bm);
            }
         }
      }
      
      public function removeHeroBuff(name:String) : void
      {
         this.refreshBuffIcon();
      }
      
      private function addPetHead() : void
      {
         var cpif:PetInfo = this.hero.getPlayer().findCurrentPet();
         if(cpif)
         {
            if(this.petHead == null)
            {
               this.petHead = new ShowPetInfo();
               this.petHead.setPetInfo(cpif);
               this.petHead.flipHorizontalTxt(rn);
               this.petHead.y = 94;
               this.addChild(this.petHead);
            }
            else
            {
               this.petHead.setPetInfo(cpif);
            }
         }
         else
         {
            this.removePetHead();
         }
      }
      
      private function removePetHead() : void
      {
         if(this.petHead && this.contains(this.petHead))
         {
            this.removeChild(this.petHead);
            this.petHead = null;
         }
      }
      
      private function changeCurPet(e:CommonEvent) : void
      {
         this.addPetHead();
      }
      
      private function showBackPack(e:MouseEvent) : void
      {
         var bb:* = null;
         if(gc.curStageAndCurLevel.curStage == 0 && gc.curStageAndCurLevel.curLevel > 1 || gc.isInWeiPk())
         {
            return;
         }
         if(hero.isDead())
         {
            gc.ts.setTxt("您的角色已经死亡");
            this.parent.addChild(gc.ts);
            return;
         }
         if(!gc.isStopGame && !gc.isOpenBackPack)
         {
            gc.isOpenBackPack = true;
            bb = new BackPackInterfaceAssets(rn);
            this.parent.addChild(bb);
            if(gc.isSingleGame())
            {
               MainGame.getInstance().stopGame();
            }
         }
         else
         {
            gc.eventManger.dispatchEvent(new CommonEvent("closeBackpack"));
         }
      }
      
      private function setClick(e:MouseEvent) : void
      {
         var sm:SetMenu = AUtils.getNewObj("export.setmenu.SetMenu") as SetMenu;
         this.parent.addChild(sm);
         if(gc.isSingleGame())
         {
            MainGame.getInstance().stopGame();
         }
      }
      
      private function studySkill(e:MouseEvent) : void
      {
         if(gc.curStageAndCurLevel.curStage == 0 && gc.curStageAndCurLevel.curLevel > 1 || gc.isInWeiPk())
         {
            return;
         }
         trace("gc.isStopGame:" + gc.isStopGame);
         if(gc.isStopGame)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("closeBuySkill",{"state":"gameing"}));
         }
         else
         {
            gc.eventManger.dispatchEvent(new CommonEvent("showBuySkill",{"state":"gameing"}));
            if(gc.isSingleGame())
            {
               MainGame.getInstance().stopGame();
            }
         }
      }
      
      private function fbClick(e:MouseEvent) : void
      {
         var si:* = null;
         if(gc.curStageAndCurLevel.curStage == 0 && gc.curStageAndCurLevel.curLevel > 1 || gc.isInWeiPk())
         {
            return;
         }
         if(hero.isDead())
         {
            gc.ts.setTxt("您的角色已经死亡");
            this.parent.addChild(gc.ts);
            return;
         }
         if(hero.getPlayer().getCurEquipByType("zbfb") != null)
         {
            si = new SutraInterfaceAssets(this.hero);
            this.parent.addChild(si);
            if(gc.isSingleGame())
            {
               MainGame.getInstance().stopGame();
            }
         }
         else
         {
            gc.ts.setTxt("您还未装备法宝");
            this.parent.addChild(gc.ts);
         }
      }
      
      private function cwClick(e:MouseEvent) : void
      {
         var pif:* = null;
         if(gc.curStageAndCurLevel.curStage == 0 && gc.curStageAndCurLevel.curLevel > 1 || gc.isInWeiPk())
         {
            return;
         }
         if(!gc.isStopGame)
         {
            pif = new PetInterfaceAssets(this.hero.getPlayer());
            this.parent.addChild(pif);
            if(gc.isSingleGame())
            {
               MainGame.getInstance().stopGame();
            }
         }
         else
         {
            gc.eventManger.dispatchEvent(new CommonEvent("closePetInterface"));
         }
      }
      
      private function refreshShowSkill(e:CommonEvent) : void
      {
         this.setSkillIcon();
      }
      
      public function addWs(data:*) : void
      {
         if(!hero || !hero.roleProperies)
         {
            return;
         }
         if(!gc.isSingleGame())
         {
            return;
         }
         var addNum:int = 0;
         var bh:BaseHero = data[1] as BaseHero;
         if(!bh)
         {
            return;
         }
         var power:int = 2;
         addNum = Math.round(data[0] / bh.getRealPower(bh.lastHit) * power);
         if(addNum == 0)
         {
            addNum = data[0] / 8;
         }
         if(!bh.isGXP && bh == hero)
         {
            if(this.getWsValue() + addNum <= 100)
            {
               this.setWsValue(this.getWsValue() + addNum);
            }
            else
            {
               this.setWsValue(100);
            }
            if(this.isGXPReady())
            {
               this.shows.gotoAndStop(2);
            }
         }
      }
      
      private function lessWs() : void
      {
         var curWs:int = 0;
         if(this.getWsValue() >= 100)
         {
            return;
         }
         if(count >= gc.frameClips)
         {
            curWs = this.getWsValue();
            if(curWs-- <= 0)
            {
               this.setWsValue(0);
            }
            else
            {
               this.setWsValue(curWs);
            }
            count = 0;
         }
         count++;
      }
      
      public function addWarriors(data:*) : void
      {
         if(!hero || !hero.roleProperies)
         {
            return;
         }
         if(data[0] == hero)
         {
            if(!hero.isDead())
            {
               if(hero.roleProperies.getHHP() + data[1] <= hero.roleProperies.getSHHP())
               {
                  hero.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[hero.roleProperies.getHHP() + data[1]]));
               }
               else
               {
                  hero.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[hero.roleProperies.getSHHP()]));
               }
            }
            if(hero.roleProperies.getMMP() + data[2] <= hero.roleProperies.getSMMP())
            {
               hero.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[hero.roleProperies.getMMP() + data[2]]));
            }
            else
            {
               hero.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[hero.roleProperies.getSMMP()]));
            }
            hero.getPlayer().setLhValue(hero.getPlayer().getLhValue() + data[3]);
            hero.getPlayer().setMyScore(hero.getPlayer().getMyScore() + data[3]);
            if(this.getWsValue() + data[4] <= 100)
            {
               this.setWsValue(this.getWsValue() + data[4]);
            }
            else
            {
               this.setWsValue(100);
            }
            if(this.isGXPReady())
            {
               this.shows.gotoAndStop(2);
            }
         }
      }
      
      public function isGXPReady() : Boolean
      {
         return this.getWsValue() >= 100;
      }
      
      public function isGXPAlive() : Boolean
      {
         return this.getWsValue() > 0;
      }
      
      public function reduceGXP(r:int) : void
      {
         this.setWsValue(this.getWsValue() - r);
         if(this.getWsValue() < 0)
         {
            this.setWsValue(0);
         }
      }
      
      public function setWsValue(v:int) : void
      {
         this._anti.wsValue = v;
      }
      
      public function getWsValue() : int
      {
         return this._anti.wsValue;
      }
      
      private function enCodeValue(v:int) : Number
      {
         return v / 10 - 5;
      }
      
      private function deCodeValue(v:Number) : int
      {
         return Math.round((v + 5) * 10);
      }
   }
}
