package base
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import config.HeroSkillProtect;
   import event.CommonEvent;
   import export.HeroBuff;
   import export.hero.Role1;
   import export.hero.Role2;
   import export.hero.Role3;
   import export.hero.Role4;
   import export.pill.Pill;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import my.SingleSavedBuff;
   import user.User;
   
   public class BaseRoleProperies extends EventDispatcher
   {
       
      
      private var gc:Config;
      
      private var who:BaseHero;
      
      private var player:User;
      
      private var tcount:uint;
      
      private var pillArray:Array;
      
      public var properiesObj:Object;
      
      private var level3:Number = 0;
      
      private var basePower3:Number = 0;
      
      private var MMP3:Number = 0;
      
      private var sMMP3:Number = 0;
      
      private var HHP3:Number = 0;
      
      private var sHHP3:Number = 0;
      
      private var defense3:Number = 0;
      
      private var crit3:Number = 0;
      
      private var addSpeed3:Number = 0;
      
      private var miss3:Number = 0;
      
      private var exper3:Number = 0;
      
      private var selfhp3:Number = 0;
      
      private var selfmp3:Number = 0;
      
      private var exp3:Number = 0;
      
      private var php3:Number = 0;
      
      private var pmp3:Number = 0;
      
      private var pcrit3:Number = 0;
      
      private var pselfhp3:Number = 0;
      
      private var pselfmp3:Number = 0;
      
      private var eatblood3:Number = 0;
      
      private var magicdef3:Number = 0;
      
      private var deephit3:Number = 0;
      
      private var dataObject:Antiwear;
      
      private var buffArray:Array;
      
      var zuoBCount:int = 0;
      
      public function BaseRoleProperies(_who:BaseHero)
      {
         pillArray = [];
         properiesObj = {
            "level1":1,
            "level2":0,
            "basePower1":0,
            "basePower2":0,
            "MMP1":0,
            "MMP2":0,
            "sMMP1":0,
            "sMMP2":0,
            "HHP1":0,
            "HHP2":0,
            "sHHP1":0,
            "sHHP2":0,
            "defense1":0,
            "defense2":0,
            "crit1":0,
            "crit2":0,
            "addSpeed1":0,
            "addSpeed2":0,
            "miss1":0,
            "miss2":0,
            "exper1":0,
            "exper2":0,
            "selfhp1":0,
            "selfhp2":0,
            "selfmp1":0,
            "selfmp2":0,
            "exp1":0,
            "exp2":0,
            "php1":0,
            "php2":0,
            "pmp1":0,
            "pmp2":0,
            "pcrit1":0,
            "pcrit2":0,
            "pselfhp1":0,
            "pselfhp2":0,
            "pselfmp1":0,
            "pselfmp2":0,
            "eatblood1":0,
            "eatblood2":0,
            "magicdef1":0,
            "magicdef2":0,
            "deephit1":0,
            "deephit2":0
         };
         buffArray = [];
         super();
         gc = Config.getInstance();
         this.who = _who;
         this.player = _who.getPlayer();
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.setInitValue();
         gc.eventManger.addEventListener("RefreshPill",this.refreshAllPill);
         gc.eventManger.addEventListener("removejnsBuff",this.removejnsBuff);
         gc.eventManger.addEventListener("addjnsBuff",this.addjnsBuff);
         this.addEventListener("AddExper",this.addExper);
         this.addEventListener("SetHHp",this.setHHPEvent);
         this.addEventListener("SetMMp",this.setMMPEvent);
         this.addEventListener("SetSHHp",this.setSHHPEvent);
         this.addEventListener("SetSMMp",this.setSMMPEvent);
         this.addEventListener("SetSMMp",this.setSMMPEvent);
         this.addEventListener("SetLevel",this.setLevelEvent);
         this.addEventListener("SetExper",this.setExperEvent);
         this.addEventListener("SetInitExper",this.setInitExperEvent);
      }
      
      private function setLevelEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.setLevel(v);
      }
      
      private function setInitExperEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.dataObject.exper = v;
      }
      
      private function setExperEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.setExper(v);
      }
      
      private function setHHPEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.setHHP(v);
      }
      
      private function setMMPEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.setMMP(v);
      }
      
      private function setSHHPEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.setSHHP(v);
      }
      
      private function setSMMPEvent(evt:CommonEvent) : void
      {
         var v:int = evt.data[0];
         this.setSMMP(v);
      }
      
      public function setInitValue() : void
      {
         this.setHx(0);
         this.setHl(0);
         this.setCrit(0);
         this.setMiss(0);
         this.setDeephit(0);
         this.setDefense(0);
         this.setAddSpeed(0);
         this.setBasePower(0);
         this.setEatblood(0);
         this.setexp(0);
         this.setSHHP(0);
         this.setSMMP(0);
         this.setHHP(0);
         this.setMMP(0);
         this.setMagicDef(0);
      }
      
      private function enCodeValue(v:int) : Number
      {
         return v / 10 - 5;
      }
      
      private function deCodeValue(v:Number) : int
      {
         return Math.round((v + 5) * 10);
      }
      
      private function setSMMP(data:int) : void
      {
         this.dataObject.smmp = data;
      }
      
      public function getSMMP() : int
      {
         return this.dataObject.smmp;
      }
      
      private function setSHHP(data:int) : void
      {
         this.dataObject.shhp = data;
      }
      
      public function getSHHP() : int
      {
         return this.dataObject.shhp;
      }
      
      private function setexp(data:int) : void
      {
         this.dataObject.exp = data;
      }
      
      public function getExp() : int
      {
         return this.dataObject.exp;
      }
      
      public function step() : void
      {
         var o:* = null;
         var idx:int = 0;
         idx = 0;
         idx = 0;
         idx = 0;
         var sx_idx:int = 0;
         var rj_idx:int = 0;
         idx = 0;
         if(!gc.isInWeiPk())
         {
            if(tcount++ >= gc.frameClips)
            {
               if(this.getTotalHx() != 0)
               {
                  if(this.getHHP() + this.getTotalHx() < 1)
                  {
                     this.setHHP(1);
                  }
                  else
                  {
                     this.setHHP(this.getHHP() + this.getTotalHx());
                  }
               }
               if(this.getHl() != 0)
               {
                  if(this.getMMP() + this.getHl() < 1)
                  {
                     this.setMMP(1);
                  }
                  else
                  {
                     this.setMMP(this.getMMP() + this.getHl());
                  }
               }
               tcount = 0;
            }
         }
         if(this.who)
         {
            if(this.who.curAddEffect)
            {
               o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_SMJC);
               if(o)
               {
                  idx = this.buffArray.indexOf(o.name);
                  if(idx == -1)
                  {
                     trace("检测到有新的宠物buff：" + o.name);
                     this.addBuff(o.name);
                  }
                  if(this.who.curAddEffect.getBuffTimeLeftByName(BaseAddEffect.PET_SMJC) == 0)
                  {
                     trace("宠物buff-生命加成-到期");
                     this.removeBuff(BaseAddEffect.PET_SMJC);
                  }
               }
               o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_MFJC);
               if(o)
               {
                  idx = this.buffArray.indexOf(o.name);
                  if(idx == -1)
                  {
                     trace("检测到有新的宠物buff：" + o.name);
                     this.addBuff(o.name);
                  }
                  if(this.who.curAddEffect.getBuffTimeLeftByName(BaseAddEffect.PET_MFJC) == 0)
                  {
                     trace("宠物buff-魔法加成-到期");
                     this.removeBuff(BaseAddEffect.PET_MFJC);
                  }
               }
               o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_GJJC);
               if(o)
               {
                  idx = this.buffArray.indexOf(o.name);
                  if(idx == -1)
                  {
                     trace("检测到有新的宠物buff：" + o.name);
                     this.addBuff(o.name);
                  }
                  if(this.who.curAddEffect.getBuffTimeLeftByName(BaseAddEffect.PET_GJJC) == 0)
                  {
                     trace("宠物buff-攻击加成-到期");
                     this.removeBuff(BaseAddEffect.PET_GJJC);
                  }
               }
               o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_FYJC);
               if(o)
               {
                  idx = this.buffArray.indexOf(o.name);
                  if(idx == -1)
                  {
                     trace("检测到有新的宠物buff：" + o.name);
                     this.addBuff(o.name);
                  }
                  if(this.who.curAddEffect.getBuffTimeLeftByName(BaseAddEffect.PET_FYJC) == 0)
                  {
                     trace("宠物buff-防御加成-到期");
                     this.removeBuff(BaseAddEffect.PET_FYJC);
                  }
               }
               if(this.who is Role1)
               {
                  if(this.who.getPlayer())
                  {
                     sx_idx = this.buffArray.indexOf("role1_sx");
                     if(sx_idx == -1)
                     {
                        if(this.who.getPlayer().findSkillIsInTheSkillAry("sx"))
                        {
                           trace("人物被动--嗜血");
                           this.addBuff("role1_sx");
                        }
                     }
                     else if(!this.who.getPlayer().findSkillIsInTheSkillAry("sx"))
                     {
                        trace("移除人物被动--嗜血");
                        this.removeBuff("role1_sx");
                     }
                  }
               }
               else if(this.who is Role3)
               {
                  rj_idx = this.buffArray.indexOf("role3_rj");
                  if(rj_idx == -1)
                  {
                     if(this.who.getPlayer().findSkillIsInTheSkillAry("rj"))
                     {
                        trace("人物被动--轫甲");
                        this.addBuff("role3_rj");
                     }
                  }
                  else if(!this.who.getPlayer().findSkillIsInTheSkillAry("rj"))
                  {
                     trace("移除人物被动--轫甲");
                     this.removeBuff("role3_rj");
                  }
               }
            }
            for each(var obj in gc.heroBuffArray)
            {
               idx = this.buffArray.indexOf(obj.name);
               if(obj.count > 0)
               {
                  if(idx == -1)
                  {
                     trace("检测到有新的buff：" + obj.name);
                     this.addBuff(obj.name);
                  }
               }
               else if(idx != -1)
               {
                  trace("移除buff:" + obj.name);
                  this.removeBuff(obj.name);
               }
            }
         }
      }
      
      private function addBuff(buffName:String) : void
      {
         var o:* = null;
         var rate:Number = NaN;
         o = null;
         rate = NaN;
         o = null;
         o = null;
         var sxlv:int = 0;
         if(!this.who)
         {
            return;
         }
         if(this.buffArray.indexOf(buffName) == -1)
         {
            switch(buffName)
            {
               case HeroBuff.HPUPBUFF:
                  this.setSHHP(this.getSHHP() * 2);
                  this.setHHP(this.getHHP() * 2);
                  break;
               case BaseAddEffect.PET_SMJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_SMJC);
                  if(o)
                  {
                     trace("生命加成--》o.value:" + o.value);
                     rate = this.getHHP() / this.getSHHP();
                     this.setSHHP(this.getSHHP() + o.value);
                     this.setHHP(this.getHHP() + o.value * rate);
                  }
                  break;
               case BaseAddEffect.PET_MFJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_MFJC);
                  if(o)
                  {
                     trace("魔法加成--》o.value:" + o.value);
                     rate = this.getMMP() / this.getSMMP();
                     this.setSMMP(this.getSMMP() + o.value);
                     this.setMMP(this.getMMP() + o.value * rate);
                  }
                  break;
               case BaseAddEffect.PET_GJJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_GJJC);
                  if(o)
                  {
                     trace("攻击加成--》o.value:" + o.value);
                     this.setBasePower(this.getBasePower() + o.value);
                  }
                  break;
               case BaseAddEffect.PET_FYJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_FYJC);
                  if(o)
                  {
                     trace("防御加成--》o.value:" + o.value);
                     this.setDefense(this.getDefense() + o.value);
                  }
                  break;
               case "role1_sx":
                  sxlv = this.who.getPlayer().returnSkillLevelBySkillName("sx");
                  if(sxlv == 1)
                  {
                     this.setEatblood(this.getEatBlood() + 6);
                     this.setCrit(this.getCrit() + 5);
                  }
                  else if(sxlv == 2)
                  {
                     this.setEatblood(this.getEatBlood() + 8);
                     this.setCrit(this.getCrit() + 6);
                  }
                  break;
               case "role3_rj":
                  this.setDefense(this.getDefense() + 30);
            }
            this.buffArray.push(buffName);
         }
      }
      
      private function removeBuff(buffName:String) : void
      {
         var o:* = null;
         var rate:Number = NaN;
         rate = NaN;
         var sxlv:int = 0;
         if(!this.who)
         {
            return;
         }
         var idx:int = this.buffArray.indexOf(buffName);
         if(idx != -1)
         {
            switch(buffName)
            {
               case HeroBuff.HPUPBUFF:
                  this.setSHHP(this.getSHHP() / 2);
                  this.setHHP(this.getHHP() / 2);
                  break;
               case BaseAddEffect.PET_SMJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_SMJC);
                  if(o)
                  {
                     trace("生命加成去除--》o.value:" + o.value);
                     rate = this.getHHP() / this.getSHHP();
                     this.setSHHP(this.getSHHP() - o.value);
                     this.setHHP(this.getHHP() - o.value * rate);
                  }
                  break;
               case BaseAddEffect.PET_MFJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_MFJC);
                  if(o)
                  {
                     trace("魔法加成去除--》o.value:" + o.value);
                     rate = this.getMMP() / this.getSMMP();
                     this.setSMMP(this.getSMMP() - o.value);
                     this.setMMP(this.getMMP() - o.value * rate);
                  }
                  break;
               case BaseAddEffect.PET_GJJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_GJJC);
                  if(o)
                  {
                     trace("攻击加成去除--》o.value:" + o.value);
                     this.setBasePower(this.getBasePower() - o.value);
                  }
                  break;
               case BaseAddEffect.PET_FYJC:
                  o = this.who.curAddEffect.getBuffByName(BaseAddEffect.PET_FYJC);
                  if(o)
                  {
                     trace("防御加成去除--》o.value:" + o.value);
                     this.setDefense(this.getDefense() - o.value);
                  }
                  break;
               case "role1_sx":
                  sxlv = this.who.getPlayer().getSkillLevelBySkillName("sx");
                  if(sxlv == 1)
                  {
                     this.setEatblood(this.getEatBlood() - 6);
                     this.setCrit(this.getCrit() - 5);
                  }
                  else if(sxlv == 2)
                  {
                     this.setEatblood(this.getEatBlood() - 8);
                     this.setCrit(this.getCrit() - 6);
                  }
                  break;
               case "role3_rj":
                  this.setDefense(this.getDefense() - 30);
            }
            this.buffArray[idx] = "";
         }
      }
      
      public function removeAllBuff() : void
      {
         for each(var buffName in this.buffArray)
         {
            if(buffName != "")
            {
               this.removeBuff(buffName);
            }
         }
         this.buffArray.length = 0;
      }
      
      private function judgeUpGrade() : *
      {
         var mc:* = null;
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         var reduceExpCurLevel:uint = this.getExp();
         if(this.getExper() >= reduceExpCurLevel)
         {
            this.setLevel(this.getLevel() + 1);
            who.upGrade(false);
            this.setExper(this.getExper() - reduceExpCurLevel);
            who.getPlayer().setCurExp(this.getExper());
            mc = AUtils.getNewObj("RoleLevelUpMc") as MovieClip;
            this.who.addChild(mc);
            gc.playerGuide.checkNewGuide();
         }
      }
      
      private function setHx(hx:int) : void
      {
         this.dataObject.hx = hx;
      }
      
      public function getHx() : int
      {
         return this.dataObject.hx;
      }
      
      public function getTotalHx() : int
      {
         var ssb:* = null;
         var v:int = this.getHx();
         if(gc.savedBuff)
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_HP_CURE);
            if(ssb)
            {
               v += ssb.value;
            }
         }
         return v;
      }
      
      private function setHl(hl:int) : void
      {
         this.dataObject.hl = hl;
      }
      
      public function getHl() : int
      {
         return this.dataObject.hl;
      }
      
      private function setEatblood(eb:int) : void
      {
         this.dataObject.eatblood = eb;
      }
      
      public function getEatBlood() : int
      {
         return this.dataObject.eatblood;
      }
      
      private function setLevel(incr:int) : void
      {
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         this.dataObject.level = incr;
         who.getPlayer().setCurLevel(this.getLevel());
      }
      
      public function getLevel() : int
      {
         return this.dataObject.level;
      }
      
      private function setBasePower(incr:int) : void
      {
         this.dataObject.basePower = incr;
      }
      
      public function getBasePower() : int
      {
         return this.dataObject.basePower;
      }
      
      private function setMagicDef(incr:int) : void
      {
         this.dataObject.magicDef = incr;
      }
      
      public function getMagicDef() : int
      {
         return this.dataObject.magicDef;
      }
      
      public function getMagicDefWhenCountHurt() : int
      {
         var defUp:Number = 1;
         if(this.who.curAddEffect.getBuffByName(BaseAddEffect.SXFB_BUFF))
         {
            defUp *= 2;
         }
         return this.getMagicDef() * defUp;
      }
      
      public function getDefenseWhenCountHurt() : int
      {
         var defUp:Number = 1;
         if(this.who.curAddEffect.getBuffByName(BaseAddEffect.SXFB_BUFF))
         {
            defUp *= 2;
         }
         return this.getDefense() * defUp;
      }
      
      private function setDeephit(incr:int) : void
      {
         this.dataObject.deephit = incr;
      }
      
      public function getDeephit() : int
      {
         return this.dataObject.deephit;
      }
      
      public function getHurt() : int
      {
         if(!this.who || !this.who.getPlayer())
         {
            return 0;
         }
         var luck:int = this.who.getPlayer().getTotalLuckData();
         if(luck > 50)
         {
            luck = 50;
         }
         var rate:Number = 1;
         if(this.who.curAddEffect)
         {
            if(this.who.curAddEffect.getBuffByName(BaseAddEffect.MONSTER114FEAR))
            {
               rate = 1 - this.getHHP() / this.getSHHP();
            }
         }
         var totalHurt:int = (this.getPower() + RandomControllor.getIns().getRandom() * luck) * rate;
         if(this.who.curAddEffect)
         {
            if(this.who.curAddEffect.getBuffByName(BaseAddEffect.MONSTER149Buff))
            {
               totalHurt /= 2;
            }
            if(this.who.curAddEffect.getBuffByName(BaseAddEffect.XLFB_BUFF))
            {
               totalHurt *= 1.5;
            }
         }
         return totalHurt;
      }
      
      public function getPower() : int
      {
         var o:* = null;
         var yxAtkAdd1:Number = NaN;
         var yxAtkAdd2:Number = NaN;
         var ssb:* = null;
         if(!this.who)
         {
            return 0;
         }
         var addValue:int = 0;
         var addPercent:Number = 1;
         if(this.who.curAddEffect)
         {
            o = this.who.curAddEffect.getBuffByName(BaseAddEffect.ATTACKUP);
            if(o)
            {
               addValue = o.addValue;
            }
            o = this.who.curAddEffect.getBuffByName(BaseAddEffect.YXFB_BUFF);
            if(o)
            {
               yxAtkAdd1 = (1 - this.getHHP() / this.getSHHP()) / 2;
               addPercent += yxAtkAdd1;
            }
            o = this.who.curAddEffect.getBuffByName(BaseAddEffect.YXFB_BUFF2);
            if(o)
            {
               yxAtkAdd2 = 0.5;
               addPercent += yxAtkAdd2;
            }
         }
         if(gc.savedBuff)
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_ATK_ADD);
            if(ssb)
            {
               addValue += ssb.value;
            }
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_MID_BUFF);
            if(ssb)
            {
               addValue += ssb.value;
            }
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_ALLIANCE_ATK);
            if(ssb)
            {
               addValue += ssb.value;
            }
         }
         return (this.getBasePower() + addValue) * addPercent;
      }
      
      public function getPowerInPack() : int
      {
         var o:* = null;
         var ssb:* = null;
         if(!this.who)
         {
            return 0;
         }
         var addValue:int = 0;
         var addPercent:Number = 1;
         if(this.who.curAddEffect)
         {
            o = this.who.curAddEffect.getBuffByName(BaseAddEffect.ATTACKUP);
            if(o)
            {
               addValue = o.addValue;
            }
         }
         if(gc.savedBuff)
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_ATK_ADD);
            if(ssb)
            {
               addValue += ssb.value;
            }
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_ALLIANCE_ATK);
            if(ssb)
            {
               addValue += ssb.value;
            }
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_MID_BUFF);
            if(ssb)
            {
               addValue += ssb.value;
            }
         }
         return (this.getBasePower() + addValue) * addPercent;
      }
      
      public function getTotalCrit() : int
      {
         var ssb:* = null;
         var yxAtkAdd2:Number = NaN;
         if(!this.who)
         {
            return 0;
         }
         var v:int = this.getCrit();
         if(gc.savedBuff)
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_CRIT_ADD);
            if(ssb)
            {
               v += ssb.value;
            }
         }
         var addPercent:Number = 1;
         var o:Object = this.who.curAddEffect.getBuffByName(BaseAddEffect.YXFB_BUFF2);
         if(o)
         {
            yxAtkAdd2 = 0.5;
            addPercent += yxAtkAdd2;
         }
         return v * addPercent;
      }
      
      private function setDefense(incr:int) : void
      {
         this.dataObject.defense = incr;
      }
      
      public function getDefense() : int
      {
         return this.dataObject.defense;
      }
      
      private function setCrit(incr:int) : void
      {
         this.dataObject.crit = incr;
      }
      
      public function getCrit() : int
      {
         return this.dataObject.crit;
      }
      
      private function setAddSpeed(incr:int) : void
      {
         this.dataObject.addSpeed = incr;
      }
      
      public function getAddSpeed() : int
      {
         return this.dataObject.addSpeed;
      }
      
      private function setMiss(incr:int) : void
      {
         this.dataObject.miss = incr;
      }
      
      public function getMiss() : int
      {
         return this.dataObject.miss;
      }
      
      private function addExper(evt:CommonEvent) : void
      {
         var addValue:uint = evt.data[0];
         this.setExper(this.getExper() + addValue);
      }
      
      private function setExper(incr:int) : void
      {
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         var needExp:uint = this.getExp();
         if(incr < needExp)
         {
            this.dataObject.exper = incr;
            who.getPlayer().setCurExp(this.getExper());
         }
         else if(this.getLevel() < gc.getTotalTopLevel())
         {
            this.dataObject.exper = incr;
            who.getPlayer().setCurExp(this.getExper());
            this.judgeUpGrade();
         }
      }
      
      public function getExper() : int
      {
         return this.dataObject.exper;
      }
      
      private function setHHP(incr:int) : void
      {
         if(!this.who)
         {
            return;
         }
         if(incr != 0 && this.getHHP() > 0 && incr > this.getHHP())
         {
            if(this.who.curAddEffect)
            {
               if(this.who.curAddEffect.getBuffByName(BaseAddEffect.ERLANGSHEN_HP_REJECT) || this.who.curAddEffect.getBuffByName(BaseAddEffect.MONSTER120DEBUFF) || this.who.curAddEffect.getBuffByName(BaseAddEffect.MONSTER129Buff))
               {
                  return;
               }
            }
         }
         this.dataObject.hhp = incr;
         if(this.getHHP() < 0)
         {
            this.setHHP(0);
         }
         if(this.getSHHP() > 0)
         {
            if(this.getHHP() > this.getSHHP())
            {
               this.setHHP(this.getSHHP());
            }
         }
      }
      
      public function getHHP() : int
      {
         return this.dataObject.hhp;
      }
      
      private function setMMP(incr:int) : void
      {
         if(!this.who)
         {
            return;
         }
         if(incr != 0 && incr > this.getMMP())
         {
            if(this.who.curAddEffect)
            {
               if(this.who.curAddEffect.getBuffByName(BaseAddEffect.MONSTER42_BLUE) || this.who.curAddEffect.getBuffByName(BaseAddEffect.MONSTER120DEBUFF))
               {
                  return;
               }
            }
         }
         this.dataObject.mmp = incr;
         if(this.getMMP() < 0)
         {
            this.setMMP(0);
         }
         if(this.getSMMP() > 0)
         {
            if(this.getMMP() > this.getSMMP())
            {
               this.setMMP(this.getSMMP());
            }
         }
      }
      
      public function getMMP() : int
      {
         return this.dataObject.mmp;
      }
      
      public function getproperiesObj() : Object
      {
         return this.properiesObj;
      }
      
      public function addEquip(aequip:MyEquipObj) : void
      {
         var rate:Number = NaN;
         var mpAdd:int = 0;
         if(aequip != null)
         {
            this.removeAllBuff();
            this.removeSavedBuff();
            this.setBasePower(this.getBasePower() + aequip.geteatt());
            this.setDefense(this.getDefense() + aequip.getedef());
            this.setCrit(this.getCrit() + int(aequip.getecrit() * 100));
            this.setMiss(this.getMiss() + int(aequip.getemiss() * 100));
            this.setHx(this.getHx() + aequip.geteahp());
            this.setHl(this.getHl() + aequip.geteamp());
            this.setEatblood(this.getEatBlood() + int(aequip.geteatblood() * 100));
            this.setMagicDef(this.getMagicDef() + int(aequip.getmagicdef() * 100));
            this.setDeephit(this.getDeephit() + int(aequip.getdeephit() * 100));
            rate = this.getHHP() / this.getSHHP();
            if(this.getSHHP() + aequip.getehp() <= 0)
            {
               this.setSHHP(1);
               this.setHHP(1);
            }
            else
            {
               this.setSHHP(this.getSHHP() + aequip.getehp());
               this.setHHP(this.getHHP() + aequip.getehp() * rate);
            }
            if(gc.isInPk())
            {
               mpAdd = aequip.getemp() / 10;
            }
            else
            {
               mpAdd = aequip.getemp();
            }
            if(this.getSMMP() + mpAdd <= 0)
            {
               this.setSMMP(1);
               this.setMMP(1);
            }
            else
            {
               this.setSMMP(this.getSMMP() + mpAdd);
               this.setMMP(this.getMMP() + mpAdd * rate);
            }
         }
         this.addSavedBuff();
      }
      
      public function removeEquip(requip:MyEquipObj) : void
      {
         var rate:Number = NaN;
         var mpAdd:int = 0;
         if(requip != null)
         {
            this.removeAllBuff();
            this.removeSavedBuff();
            this.setBasePower(this.getBasePower() - requip.geteatt());
            this.setDefense(this.getDefense() - requip.getedef());
            this.setCrit(this.getCrit() - int(requip.getecrit() * 100));
            this.setMiss(this.getMiss() - int(requip.getemiss() * 100));
            this.setHx(this.getHx() - requip.geteahp());
            this.setHl(this.getHl() - requip.geteamp());
            this.setEatblood(this.getEatBlood() - int(requip.geteatblood() * 100));
            this.setMagicDef(this.getMagicDef() - int(requip.getmagicdef() * 100));
            this.setDeephit(this.getDeephit() - int(requip.getdeephit() * 100));
            rate = this.getHHP() / this.getSHHP();
            this.setSHHP(this.getSHHP() - requip.getehp());
            this.setHHP(this.getHHP() - requip.getehp() * rate);
            if(gc.isInPk())
            {
               mpAdd = requip.getemp() / 10;
            }
            else
            {
               mpAdd = requip.getemp();
            }
            this.setSMMP(this.getSMMP() - mpAdd);
            this.setMMP(this.getMMP() - mpAdd * rate);
         }
         this.addSavedBuff();
      }
      
      private function removeSavedBuff() : void
      {
         var ssb:* = null;
         var rate:Number = NaN;
         if(gc.savedBuff)
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_HP_ADD_28_BUFF);
            if(ssb)
            {
               rate = this.getHHP() / this.getSHHP();
               this.setSHHP(this.getSHHP() - ssb.value);
               this.setHHP(this.getHHP() - ssb.value * rate);
            }
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_DEF_ADD_28_BUFF);
            if(ssb)
            {
               this.setDefense(this.getDefense() - ssb.value);
            }
         }
      }
      
      private function addSavedBuff() : void
      {
         var ssb:* = null;
         var rate:Number = NaN;
         if(gc.savedBuff)
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_HP_ADD_28_BUFF);
            if(ssb)
            {
               rate = this.getHHP() / this.getSHHP();
               this.setSHHP(this.getSHHP() + ssb.value);
               this.setHHP(this.getHHP() + ssb.value * rate);
            }
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_DEF_ADD_28_BUFF);
            if(ssb)
            {
               this.setDefense(this.getDefense() + ssb.value);
            }
         }
      }
      
      public function addAllEquip() : void
      {
         var equip:* = null;
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         var wlen:uint = who.getPlayer().curarray.length;
         while(wlen-- > 0)
         {
            equip = who.getPlayer().curarray[wlen];
            this.addEquip(equip);
         }
         this.setHHP(this.getSHHP());
         this.setMMP(this.getSMMP());
      }
      
      public function removeAllEquip() : void
      {
         var equip:* = null;
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         var wlen:uint = who.getPlayer().curarray.length;
         while(wlen-- > 0)
         {
            equip = who.getPlayer().curarray[wlen];
            this.removeEquip(equip);
         }
      }
      
      private function removeAllPassive() : void
      {
         var num:* = 0;
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         var plen:uint = who.getPlayer().dataObject.ispassiveskill.length;
         while(plen-- > 0)
         {
            num = uint(who.getPlayer().dataObject.ispassiveskill[plen]);
            removePassive(plen,num);
         }
      }
      
      private function addAllPassive() : void
      {
         var num:* = 0;
         if(!this.who || !this.who.getPlayer())
         {
            return;
         }
         var plen:uint = who.getPlayer().dataObject.ispassiveskill.length;
         while(plen-- > 0)
         {
            num = uint(who.getPlayer().dataObject.ispassiveskill[plen]);
            this.addPassive(plen,num,false);
         }
      }
      
      public function addPassive(_type:uint, _level:uint, isrem:Boolean = true) : void
      {
         if(isrem)
         {
            this.removePassive(_type,_level - 1);
         }
         this.analyPassive(_type,_level);
      }
      
      public function removePassive(_type:uint, _level:uint) : void
      {
         this.analyPassive(_type,_level,-1);
      }
      
      private function analyPassive(_type:uint, _level:uint, i:int = 1) : void
      {
         var rate:Number = NaN;
         var hpPassive:int = 0;
         var mpPassive:int = 0;
         var critPassive:int = 0;
         var selfhpPassive:int = 0;
         var selfmpPassive:int = 0;
         if(_level != 0)
         {
            this.removeAllBuff();
            rate = 0;
            switch(int(_type))
            {
               case 0:
                  hpPassive = (_level * 100 + 100) * i;
                  if(this.getSHHP() > 0)
                  {
                     rate = this.getHHP() / this.getSHHP();
                  }
                  else
                  {
                     rate = 0;
                  }
                  this.setSHHP(this.getSHHP() + hpPassive);
                  this.setHHP(this.getHHP() + hpPassive * rate);
                  break;
               case 1:
                  mpPassive = (_level * 100 + 100) * i;
                  rate = this.getMMP() / this.getSMMP();
                  this.setSMMP(this.getSMMP() + mpPassive);
                  this.setMMP(this.getMMP() + mpPassive * rate);
                  break;
               case 2:
                  critPassive = (_level * 1 + 1) * i;
                  this.setCrit(this.getCrit() + critPassive);
                  break;
               case 3:
                  selfhpPassive = (_level + 1) * i;
                  this.setHx(this.getHx() + selfhpPassive);
                  break;
               case 4:
                  selfmpPassive = (_level + 1) * i;
                  this.setHl(this.getHl() + selfmpPassive);
            }
         }
      }
      
      public function setWho(w:BaseHero) : void
      {
         this.who = w;
      }
      
      public function destroy() : void
      {
         this.removeAllEquipAndPassive();
         gc.eventManger.removeEventListener("RefreshPill",this.refreshAllPill);
         gc.eventManger.removeEventListener("removejnsBuff",this.removejnsBuff);
         gc.eventManger.removeEventListener("addjnsBuff",this.addjnsBuff);
         this.removeEventListener("AddExper",this.addExper);
         this.removeEventListener("SetHHp",this.setHHPEvent);
         this.removeEventListener("SetMMp",this.setMMPEvent);
         this.removeEventListener("SetSHHp",this.setSHHPEvent);
         this.removeEventListener("SetSMMp",this.setSMMPEvent);
         this.removeEventListener("SetLevel",this.setLevelEvent);
         this.removeEventListener("SetExper",this.setExperEvent);
         this.removeEventListener("SetInitExper",this.setInitExperEvent);
         this.who = null;
      }
      
      public function removeAllEquipAndPassive() : void
      {
         this.removePill();
         this.removeAllEquip();
         this.removeAllPassive();
      }
      
      public function initAll() : void
      {
         this.initByLevel();
         this.addAllPassive();
         this.addAllEquip();
         this.addPill();
         if(gc.isInPk())
         {
            this.setSHHP(this.getSHHP() * 20);
            this.setHHP(this.getSHHP());
         }
      }
      
      private function initByLevel() : void
      {
         if(!this.who)
         {
            return;
         }
         if(this.who is Role1)
         {
            this.setSHHP(HeroSkillProtect.getInstance().heroConst.bashi + HeroSkillProtect.getInstance().heroConst.wushi * (this.getLevel() - 1));
            this.setHHP(this.getSHHP());
            this.setSMMP(HeroSkillProtect.getInstance().heroConst.wushi + HeroSkillProtect.getInstance().heroConst.ershi * (this.getLevel() - 1));
            this.setMMP(this.getSMMP());
            this.setBasePower(10 + 5 * (this.getLevel() - 1));
            this.setDefense(2 + 2 * (this.getLevel() - 1));
            if(this.getLevel() < 7)
            {
               this.setexp(135 + 10 * (this.getLevel() - 1));
            }
            else if(this.getLevel() < 13)
            {
               this.setexp(625 + 50 * (this.getLevel() - 7));
            }
            else if(this.getLevel() < 19)
            {
               this.setexp(1950 + 100 * (this.getLevel() - 13));
            }
            else
            {
               this.setexp(5000 + 5000 * (this.getLevel() - 19));
            }
         }
         else if(this.who is Role2)
         {
            this.setSHHP(HeroSkillProtect.getInstance().heroConst.wushi + HeroSkillProtect.getInstance().heroConst.ershi * (this.getLevel() - 1));
            this.setHHP(this.getSHHP());
            this.setSMMP(HeroSkillProtect.getInstance().heroConst.yibai + 40 * (this.getLevel() - 1));
            this.setMMP(this.getSMMP());
            this.setBasePower(12 + 8 * (this.getLevel() - 1));
            this.setDefense(this.getLevel() - 1);
            if(this.getLevel() < 7)
            {
               this.setexp(135 + 10 * (this.getLevel() - 1));
            }
            else if(this.getLevel() < 13)
            {
               this.setexp(625 + 50 * (this.getLevel() - 7));
            }
            else if(this.getLevel() < 19)
            {
               this.setexp(1950 + 100 * (this.getLevel() - 13));
            }
            else
            {
               this.setexp(5000 + 5000 * (this.getLevel() - 19));
            }
         }
         else if(this.who is Role3)
         {
            this.setSHHP(HeroSkillProtect.getInstance().heroConst.yibai + HeroSkillProtect.getInstance().heroConst.qishi * (this.getLevel() - 1));
            this.setHHP(this.getSHHP());
            if(gc.curStageAndCurLevel.curStage == 0)
            {
               this.setSMMP(35 + 5 * (this.getLevel() - 1));
               this.setMMP(this.getSMMP());
            }
            else
            {
               this.setSMMP(35 + 15 * (this.getLevel() - 1));
               this.setMMP(this.getSMMP());
            }
            this.setBasePower(HeroSkillProtect.getInstance().heroConst.ershi + 6 * (this.getLevel() - 1));
            this.setDefense(4 + (this.getLevel() - 1));
            if(this.getLevel() < 7)
            {
               this.setexp(135 + 10 * (this.getLevel() - 1));
            }
            else if(this.getLevel() < 13)
            {
               this.setexp(625 + 50 * (this.getLevel() - 7));
            }
            else if(this.getLevel() < 19)
            {
               this.setexp(1950 + 100 * (this.getLevel() - 13));
            }
            else
            {
               this.setexp(5000 + 5000 * (this.getLevel() - 19));
            }
         }
         else if(this.who is Role4)
         {
            this.setSHHP(HeroSkillProtect.getInstance().heroConst.qishi + HeroSkillProtect.getInstance().heroConst.sanshi * (this.getLevel() - 1));
            this.setHHP(this.getSHHP());
            this.setSMMP(HeroSkillProtect.getInstance().heroConst.qishi + HeroSkillProtect.getInstance().heroConst.sanshi * (this.getLevel() - 1));
            this.setMMP(this.getSMMP());
            this.setBasePower(16 + 4 * (this.getLevel() - 1));
            this.setDefense(this.getLevel() - 1);
            if(this.getLevel() < 7)
            {
               this.setexp(135 + 10 * (this.getLevel() - 1));
            }
            else if(this.getLevel() < 13)
            {
               this.setexp(625 + 50 * (this.getLevel() - 7));
            }
            else if(this.getLevel() < 19)
            {
               this.setexp(1950 + 100 * (this.getLevel() - 13));
            }
            else
            {
               this.setexp(5000 + 5000 * (this.getLevel() - 19));
            }
         }
         this.addSavedBuff();
      }
      
      public function removejnsBuff(evt:CommonEvent) : void
      {
         this.removeBuff("role1_sx");
      }
      
      public function addjnsBuff(evt:CommonEvent) : void
      {
         this.addBuff("role1_sx");
      }
      
      public function refreshAllPill(evt:CommonEvent) : void
      {
         for each(var pill in this.pillArray)
         {
            pill.refreshPill();
         }
      }
      
      private function removePill() : void
      {
         for each(var pill in this.pillArray)
         {
            pill.removePill();
         }
      }
      
      private function addPill() : void
      {
         var pill:* = null;
         if(!this.who)
         {
            return;
         }
         if(this.pillArray.length == 0)
         {
            pill = new Pill(Pill.PILL_HP,this.who);
            this.pillArray.push(pill);
         }
         else
         {
            for each(pill in this.pillArray)
            {
               pill.addPill();
            }
         }
      }
   }
}
