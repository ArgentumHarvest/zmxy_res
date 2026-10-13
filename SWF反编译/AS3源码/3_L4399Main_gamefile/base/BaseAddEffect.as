package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import export.hero.Role1;
   import export.hero.Role2;
   import export.hero.Role3;
   import export.hero.Role4;
   import export.magicWeapon.MagicLeaf;
   import export.monster.Monster102;
   import export.monster.Monster104;
   import export.monster.Monster108;
   import export.monster.Monster121;
   import export.monster.Monster122;
   import export.monster.Monster123;
   import export.monster.Monster124;
   import export.monster.Monster153;
   import export.monster.Monster154;
   import export.monster.Monster33;
   import export.monster.Monster48;
   import export.monster.Monster49;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import export.monster.Monster52;
   import export.monster.Monster67;
   import export.monster.Monster68;
   import export.summon.SummonHouyi;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   
   public class BaseAddEffect
   {
      
      public static var POISON:String = "poison";
      
      public static var POISON_TIMES:String = "poison_timers";
      
      public static var FATHER:String = "father";
      
      public static var DEADLINK:String = "deadlink";
      
      public static var ICE:String = "ice";
      
      public static var SPEEDUP:String = "speedup";
      
      public static var EYEFIX:String = "eyefix";
      
      public static var MAGICLOST:String = "magiclost";
      
      public static var STUN:String = "stun";
      
      public static var NET:String = "net";
      
      public static var FIX:String = "fix";
      
      public static var BAJIE_DUNPAI_BUFF:String = "bajie_dunpai_buff";
      
      public static var SIDATIANWANG_SAN_MP_LOST:String = "sidatianwang_san_mp_lost";
      
      public static var PETHORSE_ICE:String = "pethorse_ice";
      
      public static var MAGIC_LEAF_CURE:String = "magic_leaf_cure";
      
      public static var MAGIC_UMBRELLA_DEFEND:String = "magic_umbrella_defend";
      
      public static var PETMONKEY_FIRE:String = "petmonkey_fire";
      
      public static var ERLANGSHEN_HP_REJECT:String = "erlangshen_hp_reject";
      
      public static var MONSTER36Bullet4:String = "monster36bullet4";
      
      public static var Monster37FIX:String = "monster37fix";
      
      public static var Pet_TIGER_SXHZ:String = "pet_tiger_sxhz";
      
      public static var MONSTER42_REDUCE_HP:String = "monster42_reduce_hp";
      
      public static var MONSTER42_GREEN:String = "monster42_green";
      
      public static var MONSTER42_BLUE:String = "monster42_blue";
      
      public static var SHENMISHANGRENSHIZHUANG:String = "shenmishangrenshizhuang";
      
      public static var MEIGUI_BUFF:String = "meigui_buff";
      
      public static var PETTURTKE_BUFF:String = "petturtle_buff";
      
      public static var MONSTER47POISON:String = "monster47poison";
      
      public static var MONSTER47SLOW:String = "monster47slow";
      
      public static var MONSTER53_TIE:String = "monster53_tie";
      
      public static var MONSTER54_HOUJIAO:String = "monster54_houjiao";
      
      public static var MONSTER59CHOULAN:String = "monster59choulan";
      
      public static var MONSTER65_TIED_PET:String = "monster65_tied_pet";
      
      public static var MONSTER65_AOE:String = "monster65_aoe";
      
      public static var MONSTER66HURT:String = "monster66hurt";
      
      public static var MONSTER114FEAR:String = "Monster114Fear";
      
      public static var MONSTER115REDUCEHP:String = "monster115reducehp";
      
      public static var MONSTER115SLOW:String = "monster115slow";
      
      public static var MONSTER117SLEEP:String = "monster117sleep";
      
      public static var MONSTER118GELIE:String = "monster118gelie";
      
      public static var MONSTER120DEBUFF:String = "monster120debuff";
      
      public static var TIANTINGZHANSHEN:String = "tiantingzhansheng";
      
      public static var MONSTER129Buff:String = "monster129buff";
      
      public static var MONSTER131MUSIC1:String = "monster131music1";
      
      public static var MONSTER131MUSIC2:String = "monster131music2";
      
      public static var MONSTER135Buff:String = "monster135buff";
      
      public static var MONSTER136REDUCEMP:String = "monster136reducemp";
      
      public static var MONSTER137BUFF:String = "monster137buff";
      
      public static var MONSTER149Buff:String = "monster149buff";
      
      public static var MONSTER151BUFF:String = "monster151buff";
      
      public static var MONSTER158REJECTHP:String = "monster158rejecthp";
      
      public static var FLUTE_SLEEP:String = "flutesleep";
      
      public static var HANXIANGZI_SLEEP:String = "hanxiangzisleep";
      
      public static var MAGIC_SHENXING:String = "shenxing";
      
      public static var MAGIC_DKHL:String = "dkhl";
      
      public static var ZMXW_BUFF:String = "zmxw_buff";
      
      public static var MONSTER180Buff:String = "dajimeihuo";
      
      public static var XLFB_BUFF:String = "xlfb_buff";
      
      public static var SXFB_BUFF:String = "sxfb_buff";
      
      public static var YXFB_BUFF:String = "yxfb_buff";
      
      public static var YXFB_BUFF2:String = "yxfb_buff2";
      
      public static var MONSTER203_BUFF:String = "MONSTER203_BUFF";
      
      public static var MID_BUFF:String = "mid_buff";
      
      public static var ATTACKUP:String = "attackup";
      
      public static var PET_SXKB:String = "sxkb";
      
      public static var PET_FSNL:String = "fsnl";
      
      public static var PET_SMJC:String = "smjc";
      
      public static var PET_MFJC:String = "mfjc";
      
      public static var PET_GJJC:String = "gjjc";
      
      public static var PET_FYJC:String = "fyjc";
      
      public static var PET_RABBIT_JIFENG:String = "jifeng";
      
      public static var PET_RABBIT4_AOYI1:String = "petRabbit4Aoyi1";
      
      public static var PET_RABBIT4_AOYI2:String = "petRabbit4Aoyi2";
      
      public static var SLOWLY_ADDHP:String = "slowly_addhp";
       
      
      private var sourceRole:BaseObject;
      
      private var curEffectArray:Array;
      
      private var beAttackFatherTotalCount:int = 6;
      
      private var beAttackFatherCurCount:int = 0;
      
      private var lastBeAttackTime:int;
      
      private var gc:Config;
      
      private var glow:GlowFilter;
      
      private var count:int = 0;
      
      public function BaseAddEffect(s:BaseObject)
      {
         curEffectArray = [];
         super();
         this.sourceRole = s;
         gc = Config.getInstance();
      }
      
      public function isAnyThingElseStun(type:String) : Boolean
      {
         var i:int = 0;
         var o:* = null;
         var flag:Boolean = false;
         for(i = 0; i < this.curEffectArray.length; )
         {
            o = this.curEffectArray[i];
            if(o)
            {
               if(o.name != type)
               {
                  flag = this.isCannotContrlSkill(o);
                  if(flag)
                  {
                     return flag;
                  }
               }
            }
            i++;
         }
         return flag;
      }
      
      private function isCannotContrlSkill(o:Object) : Boolean
      {
         if(o.name == BaseAddEffect.ICE || o.name == BaseAddEffect.Pet_TIGER_SXHZ || o.name == BaseAddEffect.MONSTER54_HOUJIAO || o.name == BaseAddEffect.PETHORSE_ICE || o.name == BaseAddEffect.EYEFIX || o.name == BaseAddEffect.FIX || o.name == BaseAddEffect.MONSTER53_TIE || o.name == BaseAddEffect.STUN || o.name == BaseAddEffect.MONSTER117SLEEP || o.name == BaseAddEffect.MONSTER135Buff || o.name == BaseAddEffect.FLUTE_SLEEP || o.name == BaseAddEffect.HANXIANGZI_SLEEP || o.name == BaseAddEffect.MONSTER180Buff)
         {
            return true;
         }
         return false;
      }
      
      public function step() : void
      {
         var i:int = 0;
         var o:* = null;
         var rand:* = 0;
         var cureValue:* = 0;
         var equip:* = null;
         var reduceHp:* = 0;
         var point:* = null;
         var newPoint:* = null;
         var dis:int = 0;
         reduceHp = 0;
         var bhh:* = null;
         var bpp:* = null;
         bhh = null;
         bhh = null;
         for(i = 0; i < this.curEffectArray.length; )
         {
            o = this.curEffectArray[i];
            if(o)
            {
               if(this.sourceRole)
               {
                  if(o.isFirst)
                  {
                     o.startTime = count;
                     o.isFirst = false;
                     if(o.name == BaseAddEffect.POISON || o.name == BaseAddEffect.ZMXW_BUFF)
                     {
                        this.showPoison();
                     }
                     else if(o.name == BaseAddEffect.POISON_TIMES)
                     {
                        o.times = 1;
                        this.showPoisonTimes();
                     }
                     else if(o.name == BaseAddEffect.ICE)
                     {
                        this.showIce();
                     }
                     else if(o.name == BaseAddEffect.DEADLINK)
                     {
                        this.showDeadLink();
                     }
                     else if(o.name == BaseAddEffect.SPEEDUP)
                     {
                        this.showSpeedUp();
                     }
                     else if(o.name == BaseAddEffect.EYEFIX)
                     {
                        this.showEyeFix();
                     }
                     else if(o.name == BaseAddEffect.MAGICLOST)
                     {
                        this.showMagicLost();
                     }
                     else if(o.name == BaseAddEffect.STUN)
                     {
                        this.showStun();
                        this.sourceRole.setStatic();
                     }
                     else if(o.name == BaseAddEffect.NET)
                     {
                        this.showNet();
                     }
                     else if(o.name == BaseAddEffect.FIX)
                     {
                        this.fix();
                     }
                     else if(o.name == BaseAddEffect.SLOWLY_ADDHP)
                     {
                        this.slowlyAddHp();
                     }
                     else if(o.name == BaseAddEffect.BAJIE_DUNPAI_BUFF)
                     {
                        this.bajie_dunpai_buff();
                     }
                     else if(o.name == BaseAddEffect.SIDATIANWANG_SAN_MP_LOST)
                     {
                        this.show_sidatianwang_san_mp_lost(o);
                     }
                     else if(o.name == BaseAddEffect.PETHORSE_ICE)
                     {
                        this.show_pethorse_ice();
                     }
                     else if(o.name == BaseAddEffect.MAGIC_LEAF_CURE)
                     {
                        this.show_magic_laf_cure();
                     }
                     else if(o.name == BaseAddEffect.MAGIC_UMBRELLA_DEFEND)
                     {
                        this.show_magic_umb_def();
                     }
                     else if(o.name == BaseAddEffect.PETMONKEY_FIRE)
                     {
                        this.show_mpetmonkey_fire();
                     }
                     else if(o.name == BaseAddEffect.PET_SXKB)
                     {
                        this.show_sxkb();
                     }
                     else if(o.name == BaseAddEffect.PET_FSNL)
                     {
                        this.show_fsnl();
                     }
                     else if(o.name == BaseAddEffect.PET_SMJC)
                     {
                        this.show_smjc();
                     }
                     else if(o.name == BaseAddEffect.PET_MFJC)
                     {
                        this.show_mfjc();
                     }
                     else if(o.name == BaseAddEffect.PET_GJJC)
                     {
                        this.show_gjjc();
                     }
                     else if(o.name == BaseAddEffect.PET_FYJC)
                     {
                        this.show_fyjc();
                     }
                     else if(o.name == BaseAddEffect.ERLANGSHEN_HP_REJECT)
                     {
                        this.show_erlangshen();
                     }
                     else if(o.name == BaseAddEffect.MONSTER36Bullet4)
                     {
                        this.show_monster36bullet4();
                     }
                     else if(o.name == BaseAddEffect.Monster37FIX)
                     {
                        this.show_monster37fix();
                     }
                     else if(o.name == BaseAddEffect.Pet_TIGER_SXHZ)
                     {
                        this.show_pet_tiger_sxhz(o.time,o.direct);
                     }
                     else if(o.name == BaseAddEffect.MONSTER42_REDUCE_HP)
                     {
                        this.show_monster42_reduce_hp();
                     }
                     else if(o.name == BaseAddEffect.MONSTER42_GREEN)
                     {
                        this.show_monster42_green();
                     }
                     else if(o.name == BaseAddEffect.MONSTER42_BLUE)
                     {
                        this.show_monster42_blue();
                     }
                     else if(o.name == BaseAddEffect.SHENMISHANGRENSHIZHUANG)
                     {
                        this.show_shenmishangren();
                     }
                     else if(o.name == BaseAddEffect.MEIGUI_BUFF)
                     {
                        this.show_meigui_buff();
                     }
                     else if(o.name == BaseAddEffect.PETTURTKE_BUFF)
                     {
                        this.show_petturtle_buff();
                     }
                     else if(o.name == BaseAddEffect.MONSTER47POISON)
                     {
                        this.showMonster47Poison();
                     }
                     else if(o.name == BaseAddEffect.MONSTER47SLOW)
                     {
                        this.showMonster47Slow();
                     }
                     else if(o.name == BaseAddEffect.ATTACKUP)
                     {
                        this.showAttackUp();
                     }
                     else if(o.name == BaseAddEffect.MONSTER53_TIE)
                     {
                        this.showMonster53Tie();
                     }
                     else if(o.name == BaseAddEffect.MONSTER54_HOUJIAO)
                     {
                        this.showMonster54Houjiao(o.point);
                     }
                     else if(o.name == BaseAddEffect.MONSTER59CHOULAN)
                     {
                        this.showMonster59choulan(o.value);
                     }
                     else if(o.name == BaseAddEffect.MONSTER65_TIED_PET)
                     {
                        this.showMonster65tied();
                     }
                     else if(o.name == BaseAddEffect.MONSTER65_AOE)
                     {
                        this.showMonster65aoe();
                     }
                     else if(o.name == BaseAddEffect.MONSTER66HURT)
                     {
                        this.showMonster66hurt();
                     }
                     else if(o.name == BaseAddEffect.MONSTER114FEAR)
                     {
                        this.showMonster114Fear();
                     }
                     else if(o.name == BaseAddEffect.MONSTER115REDUCEHP)
                     {
                        this.showMonster115Reducehp();
                     }
                     else if(o.name == BaseAddEffect.MONSTER115SLOW)
                     {
                        this.showMonster115slow();
                     }
                     else if(o.name == BaseAddEffect.MONSTER117SLEEP)
                     {
                        this.showMonster117sleep();
                     }
                     else if(o.name == BaseAddEffect.MONSTER118GELIE)
                     {
                        this.showMonster118gelie();
                     }
                     else if(o.name == BaseAddEffect.MONSTER120DEBUFF)
                     {
                        this.showMonster120debuff();
                     }
                     else if(o.name == BaseAddEffect.TIANTINGZHANSHEN)
                     {
                        this.showTiantingZhanshen();
                     }
                     else if(o.name == BaseAddEffect.MONSTER129Buff)
                     {
                        this.showMonster129Buff();
                     }
                     else if(o.name == BaseAddEffect.PET_RABBIT_JIFENG)
                     {
                        this.showPetRabbitJiFeng();
                     }
                     else if(o.name == BaseAddEffect.PET_RABBIT4_AOYI1)
                     {
                        this.showPetRabbit4Aoyi1();
                     }
                     else if(o.name == BaseAddEffect.PET_RABBIT4_AOYI2)
                     {
                        this.showPetRabbit4Aoyi2();
                     }
                     else if(o.name == BaseAddEffect.MONSTER131MUSIC1)
                     {
                        this.showMonster131Music1();
                     }
                     else if(o.name == BaseAddEffect.MONSTER131MUSIC2)
                     {
                        this.showMonster131Music2();
                     }
                     else if(o.name == BaseAddEffect.MONSTER135Buff)
                     {
                        this.showMonster135Buff();
                     }
                     else if(o.name == BaseAddEffect.MONSTER137BUFF)
                     {
                        o.times = 1;
                     }
                     else if(o.name == BaseAddEffect.MONSTER149Buff)
                     {
                        this.showMonster149Buff();
                     }
                     else if(o.name == BaseAddEffect.MONSTER151BUFF)
                     {
                        this.showMonster151Buff();
                     }
                     else if(o.name == BaseAddEffect.MONSTER158REJECTHP)
                     {
                        this.showMonster158RejectHp();
                     }
                     else if(o.name == BaseAddEffect.FLUTE_SLEEP)
                     {
                        this.showFluteSleep();
                     }
                     else if(o.name == BaseAddEffect.HANXIANGZI_SLEEP)
                     {
                        this.showHXZSleep();
                     }
                     else if(o.name == BaseAddEffect.MAGIC_DKHL)
                     {
                        this.showDkhl();
                     }
                     else if(o.name == BaseAddEffect.MONSTER180Buff)
                     {
                        this.showMonster180Buff();
                     }
                     else if(o.name == BaseAddEffect.XLFB_BUFF)
                     {
                        this.showXLFB();
                     }
                     else if(o.name == BaseAddEffect.SXFB_BUFF)
                     {
                        this.showSXFB();
                     }
                     else if(o.name == BaseAddEffect.YXFB_BUFF2)
                     {
                        this.showYXFB();
                     }
                  }
                  if(o.name == BaseAddEffect.POISON)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(gc.isSingleGame())
                        {
                           this.sourceRole.reduceHp(o.power);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.FATHER)
                  {
                     if(getTimer() - lastBeAttackTime >= o.interval)
                     {
                        this.beAttackFatherCurCount = 0;
                     }
                  }
                  else if(o.name == BaseAddEffect.MAGICLOST)
                  {
                     if(this.sourceRole is BaseHero)
                     {
                        BaseHero(this.sourceRole).reduceMp(Math.abs(BaseHero(this.sourceRole).speed.x) * 2);
                     }
                  }
                  else if(o.name == BaseAddEffect.SLOWLY_ADDHP)
                  {
                     if(this.sourceRole is BaseHero)
                     {
                        if(count % gc.frameClips == 0)
                        {
                           cureValue = uint(o.value);
                           if(BaseHero(this.sourceRole).isGXP)
                           {
                              cureValue *= 1.5;
                           }
                           BaseHero(this.sourceRole).cureHp(cureValue);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.BAJIE_DUNPAI_BUFF)
                  {
                     if(this.sourceRole is BaseHero)
                     {
                        if(count % gc.frameClips == 0)
                        {
                           rand = uint((BaseHero(this.sourceRole).roleProperies.getTotalHx() + 2) * 2.5);
                           BaseHero(this.sourceRole).cureHp(rand);
                        }
                     }
                     else if(this.sourceRole is Monster33)
                     {
                        if(count % gc.frameClips == 0)
                        {
                           Monster33(this.sourceRole).cureHp(Monster33(this.sourceRole).getSHp() * 0.0001);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.STUN)
                  {
                     this.sourceRole.setStatic();
                  }
                  else if(o.name == BaseAddEffect.MAGIC_LEAF_CURE)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           if(BaseHero(this.sourceRole).getPlayer())
                           {
                              if(BaseHero(this.sourceRole).getCurMagicWeapon() is MagicLeaf)
                              {
                                 equip = BaseHero(this.sourceRole).getPlayer().getCurEquipByType("zbfb");
                                 if(equip)
                                 {
                                    BaseHero(this.sourceRole).cureHp(equip.getELevel());
                                 }
                              }
                           }
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.PETMONKEY_FIRE)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        this.sourceRole.reduceHp(o.hurt,false);
                     }
                  }
                  else if(o.name == BaseAddEffect.Monster37FIX)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        this.sourceRole.reduceHp(500,false);
                        if(this.sourceRole is BaseHero)
                        {
                           BaseHero(this.sourceRole).roleProperies.dispatchEvent(new CommonEvent("SetMMp",[BaseHero(this.sourceRole).roleProperies.getMMP() - 100]));
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER42_GREEN)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           BaseHero(this.sourceRole).reduceHp(BaseHero(this.sourceRole).roleProperies.getSHHP() / 100,false);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MEIGUI_BUFF)
                  {
                     if(count % (gc.frameClips * 10) == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           (this.sourceRole as BaseHero).cureHp(o.value);
                           (this.sourceRole as BaseHero).cureMp(o.value);
                        }
                        if(this.sourceRole is BasePet)
                        {
                           (this.sourceRole as BasePet).cureHp(o.value);
                           (this.sourceRole as BasePet).cureMp(o.value);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER47POISON)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           reduceHp = uint((BaseHero(this.sourceRole).roleProperies.getSHHP() - BaseHero(this.sourceRole).roleProperies.getHHP()) * 0.05);
                           (this.sourceRole as BaseHero).reduceHp(reduceHp,false);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER118GELIE)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           point = o.point;
                           newPoint = new Point(this.sourceRole.x,this.sourceRole.y);
                           dis = Math.abs(point.x - newPoint.x);
                           o.point = newPoint;
                           reduceHp = uint(dis * 10);
                           (this.sourceRole as BaseHero).reduceHp(reduceHp,false);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER120DEBUFF)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseMonster)
                        {
                           (this.sourceRole as BaseMonster).cureHp(500);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.PET_RABBIT4_AOYI1)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           bhh = this.sourceRole as BaseHero;
                           bhh.cureHp(bhh.roleProperies.getSHHP() / 10);
                        }
                        else if(this.sourceRole is BasePet)
                        {
                           bpp = this.sourceRole as BasePet;
                           bpp.cureHp(bpp.petInfo.getSHp() / 10);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER135Buff)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           bhh = this.sourceRole as BaseHero;
                           bhh.reduceHp(o.hurt);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER136REDUCEMP)
                  {
                     if(o.time == 1)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           (this.sourceRole as BaseHero).reduceMp(100);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER151BUFF)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           bhh = this.sourceRole as BaseHero;
                           bhh.reduceMp(o.hurt);
                           bhh.reduceHp(o.hurt);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER158REJECTHP)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        this.sourceRole.reduceHp(o.value);
                        if(o.source is BaseMonster)
                        {
                           (o.source as BaseMonster).cureHp(o.value);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.HANXIANGZI_SLEEP)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        this.sourceRole.reduceHp(o.value);
                     }
                  }
                  else if(o.name == BaseAddEffect.MAGIC_DKHL)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           BaseHero(this.sourceRole).cureHp(o.cureHp);
                           BaseHero(this.sourceRole).cureMp(o.cureMp);
                        }
                        else if(this.sourceRole is BasePet)
                        {
                           BasePet(this.sourceRole).cureHp(o.cureHp);
                           BasePet(this.sourceRole).cureMp(o.cureMp);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.ZMXW_BUFF)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           this.sourceRole.reduceHp(BaseHero(this.sourceRole).roleProperies.getSHHP() * 0.05);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MONSTER180Buff)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           (this.sourceRole as BaseHero).reduceMp(o.value);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.XLFB_BUFF)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           this.sourceRole.reduceHp(BaseHero(this.sourceRole).roleProperies.getSHHP() * 0.01);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.SXFB_BUFF)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           (this.sourceRole as BaseHero).reduceMp((this.sourceRole as BaseHero).roleProperies.getSMMP() * 0.01);
                        }
                     }
                  }
                  else if(o.name == BaseAddEffect.MID_BUFF)
                  {
                     if(count % gc.frameClips == 0)
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           (this.sourceRole as BaseHero).cureHp(o.value);
                        }
                        else if(this.sourceRole is BasePet)
                        {
                           (this.sourceRole as BasePet).cureHp(o.value);
                        }
                        else if(this.sourceRole is BaseSummon)
                        {
                           (this.sourceRole as BaseSummon).cureHp(o.value);
                        }
                     }
                  }
                  if(o.isForever != 1 && count - o.startTime >= o.time)
                  {
                     this.remove(o);
                  }
               }
            }
            i++;
         }
         if(this.sourceRole)
         {
            if(this.sourceRole is BaseHero)
            {
               if(this.sourceRole.isGXP || this.sourceRole.isYourFather())
               {
                  this.myGlow();
               }
               else if(!this.sourceRole.isGXP && !this.sourceRole.isYourFather())
               {
                  this.cancelGlow();
               }
            }
            else if(this.sourceRole is BasePet)
            {
               if(this.sourceRole.isYourFather())
               {
                  this.myGlow();
               }
               else
               {
                  this.cancelGlow();
               }
            }
            else if(this.sourceRole is BaseSummon)
            {
               if(!(this.sourceRole is SummonHouyi))
               {
                  this.myGlow();
               }
            }
            else if(this.sourceRole is Monster121 || this.sourceRole is Monster122 || this.sourceRole is Monster123 || this.sourceRole is Monster124)
            {
               this.myGlow();
            }
         }
         if(count % gc.frameClips * 5 == 0)
         {
            this.addBuffIcon();
         }
         count++;
      }
      
      protected function cancelGlow() : void
      {
         this.glow = null;
         this.sourceRole.filters = [];
      }
      
      protected function myGlow() : void
      {
         if(this.sourceRole is BaseSummon)
         {
            if(!this.glow)
            {
               this.glow = new GlowFilter(1122867,1,15,15,1.5,3,false,false);
            }
            else
            {
               if(this.glow.blurX > 6 && this.glow.alpha == 1)
               {
                  this.glow.blurX--;
                  this.glow.blurY--;
                  if(this.glow.blurX == 6)
                  {
                     this.glow.alpha = 0.8;
                  }
               }
               if(this.glow.blurX < 15 && this.glow.alpha == 0.8)
               {
                  this.glow.blurX++;
                  this.glow.blurY++;
                  if(this.glow.blurX == 15)
                  {
                     this.glow.alpha = 1;
                  }
               }
            }
         }
         else if(this.sourceRole.isGXP)
         {
            if(!this.glow)
            {
               this.glow = new GlowFilter(16777215,1,15,15,1.5,3,false,false);
            }
            else
            {
               this.glow.color = 16777215;
               if(this.glow.blurX > 6 && this.glow.alpha == 1)
               {
                  this.glow.blurX--;
                  this.glow.blurY--;
                  if(this.glow.blurX == 6)
                  {
                     this.glow.alpha = 0.8;
                  }
               }
               if(this.glow.blurX < 15 && this.glow.alpha == 0.8)
               {
                  this.glow.blurX++;
                  this.glow.blurY++;
                  if(this.glow.blurX == 15)
                  {
                     this.glow.alpha = 1;
                  }
               }
            }
         }
         else if(this.sourceRole.isYourFather())
         {
            if(!this.glow)
            {
               if(this.sourceRole is Role1)
               {
                  this.glow = new GlowFilter(16711680,1,15,15,1.5,3,false,false);
               }
               else if(this.sourceRole is Role2)
               {
                  this.glow = new GlowFilter(255,1,15,15,1.5,3,false,false);
               }
               else if(this.sourceRole is Role3)
               {
                  this.glow = new GlowFilter(16763955,1,15,15,1.5,3,false,false);
               }
               else if(this.sourceRole is Role4)
               {
                  this.glow = new GlowFilter(65280,1,15,15,1.5,3,false,false);
               }
               else if(this.sourceRole is BasePet)
               {
                  this.glow = new GlowFilter(10092288,1,15,15,1.5,3,false,false);
               }
            }
            else
            {
               if(this.sourceRole is Role1)
               {
                  this.glow.color = 16711680;
               }
               else if(this.sourceRole is Role2)
               {
                  this.glow.color = 255;
               }
               else if(this.sourceRole is Role3)
               {
                  this.glow.color = 16763955;
               }
               else if(this.sourceRole is Role4)
               {
                  this.glow.color = 65280;
               }
               else if(this.sourceRole is BasePet)
               {
                  this.glow.color = 10092288;
               }
               if(this.glow.blurX > 6 && this.glow.alpha == 1)
               {
                  this.glow.blurX--;
                  this.glow.blurY--;
                  if(this.glow.blurX == 6)
                  {
                     this.glow.alpha = 0.8;
                  }
               }
               if(this.glow.blurX < 15 && this.glow.alpha == 0.8)
               {
                  this.glow.blurX++;
                  this.glow.blurY++;
                  if(this.glow.blurX == 15)
                  {
                     this.glow.alpha = 1;
                  }
               }
            }
         }
         if(this.glow)
         {
            this.sourceRole.filters = [this.glow];
         }
      }
      
      public function updateFather() : void
      {
         var o:Object = this.getBuffByName("father");
         if(!o)
         {
            return;
         }
         if(this.beAttackFatherCurCount < this.beAttackFatherTotalCount)
         {
            this.beAttackFatherCurCount++;
            if(this.beAttackFatherCurCount >= this.beAttackFatherTotalCount)
            {
               this.sourceRole.setYourFather(o.time);
               this.sourceRole.doWhenSetYourFatherByFatherCount();
               this.beAttackFatherCurCount = 0;
            }
         }
         this.lastBeAttackTime = getTimer();
      }
      
      public function add(arr:Array) : void
      {
         var i:* = 0;
         var newObj:* = null;
         var isHit:Boolean = false;
         var eq:* = null;
         var j:* = 0;
         var oldObj:* = null;
         trace("===============新增==========");
         if(!this.sourceRole || this.sourceRole.isDead())
         {
            return;
         }
         var isNew:Boolean = true;
         for(i = uint(0); i < arr.length; )
         {
            newObj = arr[i];
            if(newObj)
            {
               trace("===============新增buff:" + newObj.name);
               isHit = false;
               if(newObj.rate != undefined)
               {
                  if(RandomControllor.getIns().getRandom() <= newObj.rate)
                  {
                     isHit = true;
                  }
               }
               else
               {
                  isHit = true;
               }
               if(isHit)
               {
                  if(gc.isSingleGame())
                  {
                     if(this.isCannotContrlSkill(newObj))
                     {
                        if(this.sourceRole is BaseHero)
                        {
                           if((this.sourceRole as BaseHero).getPlayer())
                           {
                              eq = (this.sourceRole as BaseHero).getPlayer().getCurEquipByType("zbsp");
                              if(eq)
                              {
                                 if(eq.getFillName() == "phhl" || eq.getFillName() == "cs_sp_hy")
                                 {
                                    if(newObj.time > 5)
                                    {
                                       newObj.time = 5;
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
                  for(j = uint(0); j < curEffectArray.length; )
                  {
                     oldObj = curEffectArray[j];
                     if(oldObj)
                     {
                        if(newObj.name == oldObj.name)
                        {
                           if(oldObj.name == BaseAddEffect.POISON_TIMES || oldObj.name == BaseAddEffect.MONSTER137BUFF)
                           {
                              oldObj.times++;
                           }
                           oldObj.time = newObj.time;
                           oldObj.startTime = this.count;
                           isNew = false;
                           if(newObj.name == BaseAddEffect.MONSTER203_BUFF)
                           {
                              oldObj.hurt += newObj.hurt;
                              this.sourceRole.reduceHp(oldObj.hurt);
                           }
                        }
                     }
                     j++;
                  }
                  if(isNew)
                  {
                     newObj.isFirst = true;
                     if(newObj.name == BaseAddEffect.MONSTER203_BUFF)
                     {
                        this.sourceRole.reduceHp(newObj.hurt);
                     }
                     curEffectArray.push(newObj);
                  }
                  isNew = true;
               }
            }
            i++;
         }
      }
      
      public function poison_times_bomb(hurt:uint, sr:Role4, level:uint) : void
      {
         var j:* = 0;
         var o:* = null;
         var index:* = 0;
         var topIndex:* = 0;
         var topXishu:Number = NaN;
         var b:* = null;
         for(j = uint(0); j < curEffectArray.length; )
         {
            o = curEffectArray[j];
            if(o && o.name == BaseAddEffect.POISON_TIMES)
            {
               index = uint(o.times);
               topIndex = uint(level - 1 + 6);
               topXishu = 0.25 + (level - 1) * 0.05;
               if(index > topIndex)
               {
                  index = topIndex;
               }
               hurt = index * index * hurt * topXishu * level;
               this.sourceRole.reduceHp(hurt,false);
               if(this.sourceRole is BaseHero)
               {
                  if(sr)
                  {
                     if(BaseHero(this.sourceRole).sid != gc.sid && gc.isInRoom())
                     {
                        gc.sendAttack(BaseHero(sr).getRoleId(),"poison_bomb",BaseHero(sr).getBBDC().getDirect(),BaseHero(sr).x,BaseHero(sr).y,[]);
                        gc.sendHurt(hurt,BaseHero(this.sourceRole).sid,BaseHero(this.sourceRole).getRoleId() * 10 + BaseHero(sr).getRoleId(),"",0,0,0,false,false);
                     }
                  }
                  if(gc.isSingleGame())
                  {
                     BaseHero(this.sourceRole).reduceHp(hurt,false);
                  }
               }
               o.times = 0;
               o.time = 0;
               this.remove(o);
               b = new FollowBaseObjectBullet("Role4MDS");
               b.x = this.sourceRole.x;
               b.y = this.sourceRole.y;
               b.setRole(this.sourceRole);
               b.setDisable();
               b.setDirect(this.sourceRole.getBBDC().getDirect());
               b.setAction("hit0");
               gc.gameSence.addChild(b);
               this.sourceRole.magicBulletArray.push(b);
            }
            j++;
         }
      }
      
      public function poison_times_bomb_other() : void
      {
         var j:* = 0;
         var o:* = null;
         var b:* = null;
         for(j = uint(0); j < curEffectArray.length; )
         {
            o = curEffectArray[j];
            if(o && o.name == BaseAddEffect.POISON_TIMES)
            {
               o.times = 0;
               o.time = 0;
               this.remove(o);
               b = new FollowBaseObjectBullet("Role4MDS");
               b.x = this.sourceRole.x;
               b.y = this.sourceRole.y;
               b.setRole(this.sourceRole);
               b.setDisable();
               b.setDirect(this.sourceRole.getBBDC().getDirect());
               b.setAction("hit0");
               gc.gameSence.addChild(b);
               this.sourceRole.magicBulletArray.push(b);
               break;
            }
            j++;
         }
      }
      
      public function remove(obj:Object) : void
      {
         var idx:int = this.curEffectArray.indexOf(obj);
         if(idx != -1)
         {
            this.curEffectArray[idx] = null;
         }
         if(obj.name == BaseAddEffect.POISON || obj.name == BaseAddEffect.ZMXW_BUFF)
         {
            this.hidePoison();
         }
         else if(obj.name == BaseAddEffect.POISON_TIMES)
         {
            this.hidePoisonTimes();
         }
         else if(obj.name == BaseAddEffect.ICE)
         {
            this.hideIce();
         }
         else if(obj.name == BaseAddEffect.DEADLINK)
         {
            this.hideDeadLink();
         }
         else if(obj.name == BaseAddEffect.SPEEDUP)
         {
            this.hideSpeedUp();
         }
         else if(obj.name == BaseAddEffect.EYEFIX)
         {
            this.hideEyeFix();
         }
         else if(obj.name == BaseAddEffect.MAGICLOST)
         {
            this.hideMagicLost();
         }
         else if(obj.name == BaseAddEffect.STUN)
         {
            this.hideStun();
         }
         else if(obj.name == BaseAddEffect.NET)
         {
            this.hideNet();
         }
         else if(obj.name == BaseAddEffect.FIX)
         {
            this.hideFix();
         }
         else if(obj.name == BaseAddEffect.SLOWLY_ADDHP)
         {
            this.hideSlowlyAddHp();
         }
         else if(obj.name == BaseAddEffect.BAJIE_DUNPAI_BUFF)
         {
            this.hideBajieDunpaiBuff();
         }
         else if(obj.name == BaseAddEffect.SIDATIANWANG_SAN_MP_LOST)
         {
            this.hide_sidatianwang_san_mp_lost(parseInt(obj.mpSource));
         }
         else if(obj.name == BaseAddEffect.PETHORSE_ICE)
         {
            this.hide_pethorse_ice();
         }
         else if(obj.name == BaseAddEffect.MAGIC_LEAF_CURE)
         {
            this.hide_magic_laf_cure();
         }
         else if(obj.name == BaseAddEffect.MAGIC_UMBRELLA_DEFEND)
         {
            this.hide_magic_umb_def();
         }
         else if(obj.name == BaseAddEffect.PETMONKEY_FIRE)
         {
            this.hide_mpetmonkey_fire();
         }
         else if(obj.name == BaseAddEffect.PET_SXKB)
         {
            this.hide_sxkb();
         }
         else if(obj.name == BaseAddEffect.PET_FSNL)
         {
            this.hide_fsnl();
         }
         else if(obj.name == BaseAddEffect.PET_SMJC)
         {
            this.hide_smjc();
         }
         else if(obj.name == BaseAddEffect.PET_MFJC)
         {
            this.hide_mfjc();
         }
         else if(obj.name == BaseAddEffect.PET_GJJC)
         {
            this.hide_gjjc();
         }
         else if(obj.name == BaseAddEffect.PET_FYJC)
         {
            this.hide_fyjc();
         }
         else if(obj.name == BaseAddEffect.ERLANGSHEN_HP_REJECT)
         {
            this.hide_erlangshen();
         }
         else if(obj.name == BaseAddEffect.MONSTER36Bullet4)
         {
            this.hide_monster36bullet4();
         }
         else if(obj.name == BaseAddEffect.Monster37FIX)
         {
            this.hide_monster37fix();
         }
         else if(obj.name == BaseAddEffect.Pet_TIGER_SXHZ)
         {
            this.hide_pet_tiger_sxhz();
         }
         else if(obj.name == BaseAddEffect.MONSTER42_REDUCE_HP)
         {
            this.hide_monster42_reduce_hp();
         }
         else if(obj.name == BaseAddEffect.MONSTER42_GREEN)
         {
            this.hide_monster42_green();
         }
         else if(obj.name == BaseAddEffect.MONSTER42_BLUE)
         {
            this.hide_monster42_blue();
         }
         else if(obj.name == BaseAddEffect.SHENMISHANGRENSHIZHUANG)
         {
            this.hide_shenmishangren();
         }
         else if(obj.name == BaseAddEffect.MEIGUI_BUFF)
         {
            this.hide_meigui_buff();
         }
         else if(obj.name == BaseAddEffect.PETTURTKE_BUFF)
         {
            this.hide_petturtle_buff();
         }
         else if(obj.name == BaseAddEffect.MONSTER47POISON)
         {
            this.hideMonster47Poison();
         }
         else if(obj.name == BaseAddEffect.MONSTER47SLOW)
         {
            this.hideMonster47Slow();
         }
         else if(obj.name == BaseAddEffect.ATTACKUP)
         {
            this.hideAttackUp();
         }
         else if(obj.name == BaseAddEffect.MONSTER53_TIE)
         {
            this.hideMonster53Tie();
         }
         else if(obj.name == BaseAddEffect.MONSTER54_HOUJIAO)
         {
            this.hideMonster54Houjiao();
         }
         else if(obj.name == BaseAddEffect.MONSTER65_TIED_PET)
         {
            this.hideMonster65tied();
         }
         else if(obj.name == BaseAddEffect.MONSTER65_AOE)
         {
            this.hideMonster65aoe();
         }
         else if(obj.name == BaseAddEffect.MONSTER66HURT)
         {
            this.hideMonster66hurt();
         }
         else if(obj.name == BaseAddEffect.MONSTER114FEAR)
         {
            this.hideMonster114Fear();
         }
         else if(obj.name == BaseAddEffect.MONSTER115REDUCEHP)
         {
            this.hideMonster115Reducehp(parseInt(obj.hpSource));
         }
         else if(obj.name == BaseAddEffect.MONSTER115SLOW)
         {
            this.hideMonster115slow();
         }
         else if(obj.name == BaseAddEffect.MONSTER117SLEEP)
         {
            this.hideMonster117sleep();
         }
         else if(obj.name == BaseAddEffect.MONSTER118GELIE)
         {
            this.hideMonster118gelie();
         }
         else if(obj.name == BaseAddEffect.MONSTER120DEBUFF)
         {
            this.hideMonster120debuff();
         }
         else if(obj.name == BaseAddEffect.TIANTINGZHANSHEN)
         {
            this.hideTiantingZhanshen();
         }
         else if(obj.name == BaseAddEffect.MONSTER129Buff)
         {
            this.hideMonster129Buff();
         }
         else if(obj.name == BaseAddEffect.PET_RABBIT_JIFENG)
         {
            this.hidePetRabbitJiFeng();
         }
         else if(obj.name == BaseAddEffect.PET_RABBIT4_AOYI1)
         {
            this.hidePetRabbit4Aoyi1();
         }
         else if(obj.name == BaseAddEffect.PET_RABBIT4_AOYI2)
         {
            this.hidePetRabbit4Aoyi2();
         }
         else if(obj.name == BaseAddEffect.MONSTER131MUSIC1)
         {
            this.hideMonster131Music1();
         }
         else if(obj.name == BaseAddEffect.MONSTER131MUSIC2)
         {
            this.hideMonster131Music2();
         }
         else if(obj.name == BaseAddEffect.MONSTER135Buff)
         {
            this.hideMonster135Buff();
         }
         else if(obj.name == BaseAddEffect.MONSTER149Buff)
         {
            this.hideMonster149Buff();
         }
         else if(obj.name == BaseAddEffect.MONSTER151BUFF)
         {
            this.hideMonster151Buff();
         }
         else if(obj.name == BaseAddEffect.MONSTER158REJECTHP)
         {
            this.hideMonster158RejectHp();
         }
         else if(obj.name == BaseAddEffect.FLUTE_SLEEP)
         {
            this.hideFluteSleep();
         }
         else if(obj.name == BaseAddEffect.HANXIANGZI_SLEEP)
         {
            this.hideHXZSleep();
         }
         else if(obj.name == BaseAddEffect.MAGIC_DKHL)
         {
            this.hideDkhl();
         }
         else if(obj.name == BaseAddEffect.MONSTER180Buff)
         {
            this.hideMonster180Buff();
         }
         else if(obj.name == BaseAddEffect.XLFB_BUFF)
         {
            this.hideXLFB();
         }
         else if(obj.name == BaseAddEffect.SXFB_BUFF)
         {
            this.hideSXFB();
         }
         else if(obj.name == BaseAddEffect.YXFB_BUFF2)
         {
            this.hideYXFB();
         }
         this.removeBuffIcon(obj.name);
      }
      
      public function destroy() : void
      {
         this.removeAllBuff();
         curEffectArray = [];
         count = 0;
         beAttackFatherCurCount = 0;
         this.sourceRole = null;
      }
      
      protected function showIce() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("ice"))
         {
            try
            {
               mc = AUtils.getNewObj("ice");
               mc.name = "ice";
               mc.x = -90;
               mc.y = -115;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
         this.sourceRole.setStatic();
      }
      
      protected function showDeadLink() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("deadlink"))
         {
            try
            {
               mc = AUtils.getNewObj("DeadLink");
               mc.name = "deadlink";
               mc.x = 0;
               mc.y = -70;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function showSpeedUp() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("speedup"))
         {
            try
            {
               mc = AUtils.getNewObj("SpeedUp");
               mc.name = "speedup";
               mc.x = 0;
               mc.y = 50;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function showMagicLost() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("magiclost"))
         {
            try
            {
               mc = AUtils.getNewObj("MagicLost");
               mc.name = "magiclost";
               mc.x = 0;
               mc.y = 0;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function show_petturtle_buff() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PetTurtle2Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("PetTurtle2Buff");
               mc.y = -50;
               mc.name = "PetTurtle2Buff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_petturtle_buff() : void
      {
         if(this.sourceRole.getChildByName("PetTurtle2Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PetTurtle2Buff"));
         }
      }
      
      protected function show_meigui_buff() : void
      {
      }
      
      protected function hide_meigui_buff() : void
      {
      }
      
      protected function show_shenmishangren() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("ShenMiBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("ShenMiBuff");
               mc.name = "ShenMiBuff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_shenmishangren() : void
      {
         if(this.sourceRole.getChildByName("ShenMiBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("ShenMiBuff"));
         }
      }
      
      protected function show_monster42_green() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster42BulletBuffGreen"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster42BulletBuffGreen");
               mc.name = "Monster42BulletBuffGreen";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_monster42_green() : void
      {
         if(this.sourceRole.getChildByName("Monster42BulletBuffGreen"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster42BulletBuffGreen"));
         }
      }
      
      protected function show_monster42_blue() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster42BulletBuffBlue"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster42BulletBuffBlue");
               mc.name = "Monster42BulletBuffBlue";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_monster42_blue() : void
      {
         if(this.sourceRole.getChildByName("Monster42BulletBuffBlue"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster42BulletBuffBlue"));
         }
      }
      
      protected function show_monster42_reduce_hp() : void
      {
         if(this.sourceRole is BaseHero)
         {
            BaseHero(this.sourceRole).reduceHp(BaseHero(this.sourceRole).roleProperies.getHHP() / 6,false);
         }
      }
      
      protected function hide_monster42_reduce_hp() : void
      {
      }
      
      protected function show_pet_tiger_sxhz(time:uint, direct:uint) : void
      {
         time = time;
         direct = direct;
         if(this.sourceRole)
         {
            if(this.sourceRole is Monster48 || this.sourceRole is Monster49 || this.sourceRole is Monster50 || this.sourceRole is Monster51 || this.sourceRole is Monster52 || this.sourceRole is Monster67 || this.sourceRole is Monster68 || this.sourceRole is Monster102 || this.sourceRole is Monster104 || this.sourceRole is Monster108 || this.sourceRole is Monster154 || this.sourceRole is Monster153)
            {
               return;
            }
            this.sourceRole.setStatic();
            this.sourceRole.getBBDC().stopFrame();
            if(this.sourceRole is BaseHero)
            {
               BaseHero(this.sourceRole).setStatic();
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  BaseHero(this.sourceRole).setLostKeyboard();
               }
            }
            this.sourceRole.setLostGraity();
            var point:Point = new Point();
            if(direct == 0)
            {
               point.x = this.sourceRole.x - 100;
            }
            else
            {
               point.x = this.sourceRole.x + 100;
            }
            point.y = this.sourceRole.y - 100;
            TweenMax.to(this.sourceRole,0.5,{
               "x":point.x,
               "y":point.y,
               "onComplete":function(bo:BaseObject):*
               {
                  bo = bo;
                  if(!bo.isDead())
                  {
                     TweenMax.delayedCall(2,function(_bo:BaseObject):*
                     {
                        if(!_bo.isDead())
                        {
                           if(_bo is BaseHero)
                           {
                              BaseHero(_bo).setStatic();
                              if(BaseHero(_bo).getPlayer())
                              {
                                 BaseHero(_bo).reSetLostKeyboard();
                              }
                           }
                           _bo.resetGraity();
                           _bo.getBBDC().continueFrame();
                        }
                        else
                        {
                           _bo.setAction("dead");
                           _bo.setYourFather(20);
                           _bo.resetGraity();
                           _bo.getBBDC().continueFrame();
                        }
                     },[bo]);
                  }
                  else
                  {
                     bo.setAction("dead");
                     bo.setYourFather(20);
                     bo.resetGraity();
                     bo.getBBDC().continueFrame();
                  }
               },
               "onCompleteParams":[this.sourceRole]
            });
         }
      }
      
      protected function hide_pet_tiger_sxhz() : void
      {
         if(this.sourceRole)
         {
            this.sourceRole.resetGraity();
            this.sourceRole.getBBDC().continueFrame();
         }
      }
      
      protected function showMonster54Houjiao(targetPoint:Point) : void
      {
         targetPoint = targetPoint;
         if(this.sourceRole)
         {
            this.sourceRole.setStatic();
            this.sourceRole.getBBDC().stopFrame();
            if(this.sourceRole is BaseHero)
            {
               BaseHero(this.sourceRole).setStatic();
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  BaseHero(this.sourceRole).setLostKeyboard();
               }
            }
            TweenMax.to(this.sourceRole,1,{
               "x":targetPoint.x,
               "y":targetPoint.y,
               "onComplete":function(bo:BaseObject):*
               {
                  bo = bo;
                  if(!bo.isDead())
                  {
                     TweenMax.to(bo,2,{
                        "x":targetPoint.x,
                        "y":targetPoint.y - 20,
                        "onComplete":function(_bo:BaseObject):*
                        {
                           if(!_bo.isDead())
                           {
                              if(_bo is BaseHero)
                              {
                                 BaseHero(_bo).setStatic();
                                 if(BaseHero(_bo).getPlayer())
                                 {
                                    BaseHero(_bo).reSetLostKeyboard();
                                 }
                              }
                              _bo.getBBDC().continueFrame();
                           }
                        },
                        "onCompleteParams":[bo]
                     });
                  }
               },
               "onCompleteParams":[this.sourceRole]
            });
         }
      }
      
      protected function hideMonster54Houjiao() : void
      {
      }
      
      protected function showPetRabbit4Aoyi1() : void
      {
      }
      
      protected function hidePetRabbit4Aoyi1() : void
      {
      }
      
      protected function showMonster131Music1() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("monster131MusicBuff1"))
         {
            try
            {
               mc = AUtils.getNewObj("monster131MusicBuff1");
               mc.x = 0;
               mc.y = -60;
               mc.name = "monster131MusicBuff1";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster131Music1() : void
      {
         if(this.sourceRole.getChildByName("monster131MusicBuff1"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("monster131MusicBuff1"));
         }
      }
      
      protected function showDkhl() : void
      {
      }
      
      protected function hideDkhl() : void
      {
      }
      
      protected function showHXZSleep() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("BaseAddEffectSleep"))
         {
            try
            {
               mc = AUtils.getNewObj("BaseAddEffectSleep");
               mc.x = 0;
               mc.y = -45;
               mc.name = "BaseAddEffectSleep";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         BaseObject(this.sourceRole).getBBDC().stopFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
      }
      
      protected function hideHXZSleep() : void
      {
         BaseObject(this.sourceRole).getBBDC().continueFrame();
         if(this.sourceRole.getChildByName("BaseAddEffectSleep"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("BaseAddEffectSleep"));
         }
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).reSetLostKeyboard();
            }
         }
      }
      
      protected function showFluteSleep() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("BaseAddEffectSleep"))
         {
            try
            {
               mc = AUtils.getNewObj("BaseAddEffectSleep");
               mc.x = 0;
               mc.y = -45;
               mc.name = "BaseAddEffectSleep";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         BaseObject(this.sourceRole).getBBDC().stopFrame();
         BaseObject(this.sourceRole).setStatic();
      }
      
      protected function hideFluteSleep() : void
      {
         BaseObject(this.sourceRole).getBBDC().continueFrame();
         if(this.sourceRole.getChildByName("BaseAddEffectSleep"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("BaseAddEffectSleep"));
         }
      }
      
      protected function showMonster158RejectHp() : void
      {
      }
      
      protected function hideMonster158RejectHp() : void
      {
      }
      
      protected function showMonster151Buff() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster151Bullet2Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster151Bullet2Buff");
               mc.x = 0;
               mc.y = 0;
               mc.name = "Monster151Bullet2Buff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster151Buff() : void
      {
         if(this.sourceRole.getChildByName("Monster151Bullet2Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster151Bullet2Buff"));
         }
      }
      
      protected function showMonster149Buff() : void
      {
      }
      
      protected function hideMonster149Buff() : void
      {
      }
      
      protected function showMonster135Buff() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("monster135Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("BaseAddEffectSleep");
               mc.x = 0;
               mc.y = -30;
               mc.name = "monster135Buff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         BaseObject(this.sourceRole).getBBDC().stopFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
      }
      
      protected function hideMonster135Buff() : void
      {
         if(this.sourceRole.getChildByName("monster135Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("monster135Buff"));
         }
         if(!this.isAnyThingElseStun(BaseAddEffect.MONSTER135Buff))
         {
            this.sourceRole.getBBDC().continueFrame();
            if(this.sourceRole is BaseHero)
            {
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  BaseHero(this.sourceRole).reSetLostKeyboard();
               }
            }
         }
      }
      
      protected function showMonster131Music2() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("monster131MusicBuff2"))
         {
            try
            {
               mc = AUtils.getNewObj("monster131MusicBuff2");
               mc.x = 0;
               mc.y = -60;
               mc.name = "monster131MusicBuff2";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster131Music2() : void
      {
         if(this.sourceRole.getChildByName("monster131MusicBuff2"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("monster131MusicBuff2"));
         }
      }
      
      protected function showPetRabbit4Aoyi2() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("petRabbit4AoyiBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("petRabbit4AoyiBuff");
               mc.x = 0;
               mc.y = -120;
               mc.name = "petRabbit4AoyiBuff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hidePetRabbit4Aoyi2() : void
      {
         if(this.sourceRole.getChildByName("petRabbit4AoyiBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("petRabbit4AoyiBuff"));
         }
      }
      
      protected function showPetRabbitJiFeng() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PetPetRabbitJFBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("PetPetRabbitJFBuff");
               mc.x = 0;
               mc.y = 20;
               mc.name = "PetPetRabbitJFBuff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hidePetRabbitJiFeng() : void
      {
         if(this.sourceRole.getChildByName("PetPetRabbitJFBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PetPetRabbitJFBuff"));
         }
      }
      
      protected function showMonster129Buff() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster129Bullet3PlayerBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster129Bullet3PlayerBuff");
               mc.x = 0;
               mc.y = 20;
               mc.name = "Monster129Bullet3PlayerBuff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster129Buff() : void
      {
         if(this.sourceRole.getChildByName("Monster129Bullet3PlayerBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster129Bullet3PlayerBuff"));
         }
      }
      
      protected function showTiantingZhanshen() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("tiantingzhanshenBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("tiantingzhanshenBuff");
               mc.x = 0;
               mc.y = -45;
               mc.name = "tiantingzhanshenBuff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideTiantingZhanshen() : void
      {
         if(this.sourceRole.getChildByName("tiantingzhanshenBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("tiantingzhanshenBuff"));
         }
      }
      
      protected function showMonster120debuff() : void
      {
      }
      
      protected function hideMonster120debuff() : void
      {
      }
      
      protected function showMonster118gelie() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster118Bullet3Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster118Bullet3Buff");
               mc.x = 0;
               mc.y = -45;
               mc.name = "Monster118Bullet3Buff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster118gelie() : void
      {
         if(this.sourceRole.getChildByName("Monster118Bullet3Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster118Bullet3Buff"));
         }
      }
      
      protected function showMonster117sleep() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("BaseAddEffectSleep"))
         {
            try
            {
               mc = AUtils.getNewObj("BaseAddEffectSleep");
               mc.x = 0;
               mc.y = -45;
               mc.name = "BaseAddEffectSleep";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         BaseObject(this.sourceRole).getBBDC().stopFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
      }
      
      protected function hideMonster117sleep() : void
      {
         if(this.sourceRole.getChildByName("BaseAddEffectSleep"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("BaseAddEffectSleep"));
         }
         if(!this.isAnyThingElseStun(BaseAddEffect.MONSTER117SLEEP))
         {
            this.sourceRole.getBBDC().continueFrame();
            if(this.sourceRole is BaseHero)
            {
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  BaseHero(this.sourceRole).reSetLostKeyboard();
               }
            }
         }
      }
      
      protected function showMonster115slow() : void
      {
      }
      
      protected function hideMonster115slow() : void
      {
      }
      
      protected function showMonster115Reducehp() : void
      {
         var reducehp:int = 0;
         if(this.sourceRole is BaseHero)
         {
            reducehp = (this.sourceRole as BaseHero).roleProperies.getHHP() / 2;
         }
         else if(this.sourceRole is BasePet)
         {
            reducehp = (this.sourceRole as BasePet).petInfo.getHp() / 2;
         }
         this.sourceRole.reduceHp(reducehp);
         var obj:Object = this.getBuffByName(BaseAddEffect.MONSTER115REDUCEHP);
         if(obj)
         {
            obj.hpSource = reducehp;
         }
      }
      
      protected function hideMonster115Reducehp(v:int) : void
      {
         if(this.sourceRole is BaseHero)
         {
            (this.sourceRole as BaseHero).cureHp(v);
         }
         else if(this.sourceRole is BasePet)
         {
            (this.sourceRole as BasePet).cureHp(v);
         }
      }
      
      protected function showMonster114Fear() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster114Bullet2Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster114Bullet2Buff");
               mc.x = 0;
               mc.y = -45;
               mc.name = "Monster114Bullet2Buff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster114Fear() : void
      {
         if(this.sourceRole.getChildByName("Monster114Bullet2Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster114Bullet2Buff"));
         }
      }
      
      protected function showMonster66hurt() : void
      {
         if(this.sourceRole is BaseHero)
         {
            BaseHero(this.sourceRole).reduceHp(BaseHero(this.sourceRole).roleProperies.getSHHP() * 0.03);
         }
         else if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).reduceHp(BasePet(this.sourceRole).petInfo.getSHp() * 0.03);
         }
      }
      
      protected function hideMonster66hurt() : void
      {
      }
      
      protected function showMonster65aoe() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster65Bullet3Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster65Bullet3Buff");
               mc.x = 0;
               mc.y = 0;
               mc.name = "Monster65Bullet3Buff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hideMonster65aoe() : void
      {
         if(this.sourceRole.getChildByName("Monster65Bullet3Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster65Bullet3Buff"));
         }
      }
      
      protected function showMonster65tied() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster65Bullet2"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster65Bullet2");
               mc.x = 0;
               mc.y = 0;
               mc.name = "Monster65Bullet2";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).getBBDC().stopFrame();
         }
      }
      
      protected function hideMonster65tied() : void
      {
         if(this.sourceRole.getChildByName("Monster65Bullet2"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster65Bullet2"));
         }
         if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).getBBDC().continueFrame();
         }
      }
      
      protected function showMonster59choulan(reduceMpValue:uint) : void
      {
         var b:* = null;
         if(this.sourceRole)
         {
            b = new FollowBaseObjectBullet("Monster59Effect1");
            b.x = this.sourceRole.x;
            b.y = this.sourceRole.y;
            b.setRole(this.sourceRole);
            b.setHurtCanCutDownEffect(false);
            b.setDisable();
            b.setDirect(0);
            b.setAction("null");
            gc.gameSence.addChild(b);
            this.sourceRole.magicBulletArray.push(b);
            if(this.sourceRole is BaseHero)
            {
               BaseHero(this.sourceRole).reduceMp(reduceMpValue);
            }
         }
      }
      
      protected function hideMonster59choulan() : void
      {
      }
      
      protected function show_monster37fix() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster37Bullet2_2"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster37Bullet2_2");
               mc.x = 0;
               mc.y = 0;
               if(this.sourceRole.getBBDC().getDirect() == 1)
               {
                  AUtils.flipHorizontal(mc,-1);
               }
               mc.name = "Monster37Bullet2_2";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_monster37fix() : void
      {
         if(this.sourceRole.getChildByName("Monster37Bullet2_2"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster37Bullet2_2"));
         }
      }
      
      protected function show_monster36bullet4() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster36Linghun");
         b.x = this.sourceRole.x;
         b.y = this.sourceRole.y;
         b.rotation = int(RandomControllor.getIns().getRandom() * 360);
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setDirect(0);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
         if(this.sourceRole is BaseHero)
         {
            BaseHero(this.sourceRole).roleProperies.dispatchEvent(new CommonEvent("SetMMp",[BaseHero(this.sourceRole).roleProperies.getMMP() - 100]));
         }
      }
      
      protected function hide_monster36bullet4() : void
      {
      }
      
      protected function show_erlangshen() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster22_ERLANGSHEN_HP_REJECT"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster22_ERLANGSHEN_HP_REJECT");
               mc.name = "Monster22_ERLANGSHEN_HP_REJECT";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_erlangshen() : void
      {
         if(this.sourceRole.getChildByName("Monster22_ERLANGSHEN_HP_REJECT"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster22_ERLANGSHEN_HP_REJECT"));
         }
      }
      
      protected function show_fyjc() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("buff_fyjc");
         b.x = this.sourceRole.x;
         b.y = this.sourceRole.y;
         b.width = this.sourceRole.colipse.width;
         b.height = this.sourceRole.colipse.height;
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setDirect(this.sourceRole.getBBDC().getDirect());
         b.setAction("hit0");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
      }
      
      protected function hide_fyjc() : void
      {
      }
      
      protected function show_gjjc() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("buff_gjjc");
         b.x = this.sourceRole.x;
         b.y = this.sourceRole.y;
         b.width = this.sourceRole.colipse.width;
         b.height = this.sourceRole.colipse.height;
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setDirect(this.sourceRole.getBBDC().getDirect());
         b.setAction("hit0");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
      }
      
      protected function hide_gjjc() : void
      {
      }
      
      protected function show_mfjc() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("buff_mfjc");
         b.x = this.sourceRole.x;
         b.y = this.sourceRole.y;
         b.width = this.sourceRole.colipse.width;
         b.height = this.sourceRole.colipse.height;
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setDirect(this.sourceRole.getBBDC().getDirect());
         b.setAction("hit0");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
      }
      
      protected function hide_mfjc() : void
      {
      }
      
      protected function show_smjc() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("buff_smjc");
         b.x = this.sourceRole.x;
         b.y = this.sourceRole.y;
         b.width = this.sourceRole.colipse.width;
         b.height = this.sourceRole.colipse.height;
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setDirect(this.sourceRole.getBBDC().getDirect());
         b.setAction("hit0");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
      }
      
      protected function hide_smjc() : void
      {
      }
      
      protected function show_fsnl() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("buff_fsnl"))
         {
            try
            {
               mc = AUtils.getNewObj("buff_fsnl");
               mc.name = "buff_fsnl";
               mc.width = this.sourceRole.colipse.width;
               mc.height = this.sourceRole.colipse.height;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_fsnl() : void
      {
         if(this.sourceRole.getChildByName("buff_fsnl"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("buff_fsnl"));
         }
      }
      
      protected function show_sxkb() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("buff_sxkb"))
         {
            try
            {
               mc = AUtils.getNewObj("buff_sxkb");
               mc.name = "buff_sxkb";
               mc.width = this.sourceRole.colipse.width;
               mc.height = this.sourceRole.colipse.height;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_sxkb() : void
      {
         if(this.sourceRole.getChildByName("buff_sxkb"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("buff_sxkb"));
         }
      }
      
      protected function show_mpetmonkey_fire() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("FireBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("FireBuff");
               mc.name = "FireBuff";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_mpetmonkey_fire() : void
      {
         if(this.sourceRole.getChildByName("FireBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("FireBuff"));
         }
      }
      
      protected function show_magic_umb_def() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("MagicUmbrellaEffect"))
         {
            try
            {
               mc = AUtils.getNewObj("MagicUmbrellaEffect");
               mc.name = "MagicUmbrellaEffect";
               mc.x = 0;
               mc.y = 0;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      public function reduceMagicUmbDef(v:uint) : void
      {
         var i:int = 0;
         var o:* = null;
         for(i = 0; i < this.curEffectArray.length; )
         {
            o = this.curEffectArray[i];
            if(o && o.name == BaseAddEffect.MAGIC_UMBRELLA_DEFEND)
            {
               o.defendValue -= v;
               if(o.defendValue <= 0)
               {
                  this.remove(o);
               }
            }
            i++;
         }
      }
      
      protected function hide_magic_umb_def() : void
      {
         if(this.sourceRole.getChildByName("MagicUmbrellaEffect"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("MagicUmbrellaEffect"));
         }
      }
      
      protected function show_magic_laf_cure() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("MagicLeafEffect"))
         {
            try
            {
               mc = AUtils.getNewObj("MagicLeafEffect");
               mc.name = "MagicLeafEffect";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function hide_magic_laf_cure() : void
      {
         if(this.sourceRole.getChildByName("MagicLeafEffect"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("MagicLeafEffect"));
         }
      }
      
      protected function show_pethorse_ice() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PetHorseIceEffect"))
         {
            try
            {
               mc = AUtils.getNewObj("PetHorseIceEffect");
               mc.width = this.sourceRole.colipse.width;
               mc.height = this.sourceRole.colipse.height;
               mc.name = "PetHorseIceEffect";
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         this.sourceRole.getBBDC().stopFrame();
         if(this.sourceRole is BaseHero)
         {
            BaseHero(this.sourceRole).setStatic();
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
      }
      
      protected function hide_pethorse_ice() : void
      {
         if(this.sourceRole.getChildByName("PetHorseIceEffect"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PetHorseIceEffect"));
         }
         if(!this.isAnyThingElseStun(BaseAddEffect.PETHORSE_ICE))
         {
            this.sourceRole.getBBDC().continueFrame();
            if(this.sourceRole is BaseHero)
            {
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  BaseHero(this.sourceRole).reSetLostKeyboard();
               }
            }
         }
      }
      
      protected function show_sidatianwang_san_mp_lost(obj:Object) : void
      {
         if(this.sourceRole is BaseHero)
         {
            obj.mpSource = BaseHero(this.sourceRole).roleProperies.getMMP();
            BaseHero(this.sourceRole).roleProperies.dispatchEvent(new CommonEvent("SetMMp",[0]));
         }
         else if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).petInfo.setMp(0);
         }
      }
      
      protected function hide_sidatianwang_san_mp_lost(source:uint) : void
      {
         if(this.sourceRole is BaseHero)
         {
            if(!this.sourceRole.getCurAddEffect(BaseAddEffect.MONSTER129Buff))
            {
               BaseHero(this.sourceRole).roleProperies.dispatchEvent(new CommonEvent("SetMMp",[source]));
            }
         }
         else if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).petInfo.setMp(source);
         }
      }
      
      protected function bajie_dunpai_buff() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Role3Bullet5Buff"))
         {
            try
            {
               mc = AUtils.getNewObj("Role3Bullet5Buff");
               mc.name = "Role3Bullet5Buff";
               mc.x = -20;
               mc.y = -80;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
      }
      
      protected function slowlyAddHp() : void
      {
      }
      
      protected function hideSlowlyAddHp() : void
      {
      }
      
      protected function fix() : void
      {
         (this.sourceRole as BaseObject).getBBDC().stopFrame();
         if(this.sourceRole is BaseHero)
         {
            if((this.sourceRole as BaseHero).getPlayer())
            {
               (this.sourceRole as BaseHero).setLostKeyboard();
            }
         }
      }
      
      protected function showNet() : void
      {
         var mc:MovieClip = new MovieClip();
         mc.name = "net";
         this.sourceRole.addChild(mc);
      }
      
      protected function showStun() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("stun"))
         {
            try
            {
               mc = AUtils.getNewObj("Stun");
               mc.name = "stun";
               if(this.sourceRole.getBBDC().getDirect() == 0)
               {
                  mc.x = 35;
               }
               else
               {
                  mc.x = -35;
               }
               mc.y = -30;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         if(this.sourceRole)
         {
            if(this.sourceRole is BaseHero)
            {
               BaseHero(this.sourceRole).setAction("hurt");
               if(BaseHero(this.sourceRole).getPlayer())
               {
                  BaseHero(this.sourceRole).setLostKeyboard();
               }
            }
            this.sourceRole.getBBDC().stopFrame();
         }
      }
      
      protected function showMonster180Buff() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster180Bullet2"))
         {
            try
            {
               mc = AUtils.getNewObj("Monster180Bullet2");
               mc.name = "Monster180Bullet2";
               mc.x = -50;
               mc.y = -20;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
         if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).petInfo.isCannotChange = true;
         }
         this.sourceRole.getBBDC().stopFrame();
         this.sourceRole.setStatic();
      }
      
      protected function hideMonster180Buff() : void
      {
         BaseObject(this.sourceRole).getBBDC().continueFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               if(gc.keyboardControl)
               {
                  gc.keyboardControl.setYesControlByPlayer(BaseHero(this.sourceRole).getPlayer());
               }
            }
         }
         if(this.sourceRole.getChildByName("Monster180Bullet2"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster180Bullet2"));
         }
         if(this.sourceRole is BasePet)
         {
            BasePet(this.sourceRole).petInfo.isCannotChange = false;
         }
      }
      
      protected function showXLFB() : void
      {
         this.sourceRole.setHue(-150);
      }
      
      protected function hideXLFB() : void
      {
         this.sourceRole.setHue(0);
      }
      
      protected function showSXFB() : void
      {
         this.sourceRole.setHue(-50);
      }
      
      protected function hideSXFB() : void
      {
         this.sourceRole.setHue(0);
      }
      
      protected function showYXFB() : void
      {
         this.sourceRole.setHue(-100);
      }
      
      protected function hideYXFB() : void
      {
         this.sourceRole.setHue(0);
      }
      
      protected function showEyeFix() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("eyefixBuff"))
         {
            try
            {
               mc = AUtils.getNewObj("eyefixBuff");
               mc.name = "eyefixBuff";
               mc.x = 0;
               mc.y = 0;
               this.sourceRole.addChild(mc);
            }
            catch(e:*)
            {
            }
         }
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
         this.sourceRole.getBBDC().stopFrame();
         this.sourceRole.setStatic();
      }
      
      protected function hideBajieDunpaiBuff() : void
      {
         if(this.sourceRole.getChildByName("Role3Bullet5Buff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Role3Bullet5Buff"));
         }
      }
      
      protected function hideFix() : void
      {
         BaseObject(this.sourceRole).getBBDC().continueFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).reSetLostKeyboard();
            }
         }
      }
      
      protected function hideNet() : void
      {
         if(this.sourceRole.getChildByName("net"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("net"));
         }
      }
      
      protected function hideMagicLost() : void
      {
         if(this.sourceRole.getChildByName("magiclost"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("magiclost"));
         }
      }
      
      protected function hideSpeedUp() : void
      {
         if(this.sourceRole.getChildByName("speedup"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("speedup"));
         }
      }
      
      protected function hideDeadLink() : void
      {
         if(this.sourceRole.getChildByName("deadlink"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("deadlink"));
         }
      }
      
      protected function hideStun() : void
      {
         if(this.sourceRole.getChildByName("stun"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("stun"));
         }
         if(this.sourceRole)
         {
            if(!this.isAnyThingElseStun(BaseAddEffect.STUN))
            {
               if(this.sourceRole is BaseHero)
               {
                  if(BaseHero(this.sourceRole).getPlayer())
                  {
                     BaseHero(this.sourceRole).reSetLostKeyboard();
                  }
               }
               this.sourceRole.getBBDC().continueFrame();
            }
         }
      }
      
      protected function hideIce() : void
      {
         if(this.sourceRole.getChildByName("ice"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("ice"));
         }
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               if(gc.keyboardControl)
               {
                  gc.keyboardControl.setYesControlByPlayer(BaseHero(this.sourceRole).getPlayer());
               }
            }
         }
      }
      
      protected function hideEyeFix() : void
      {
         BaseObject(this.sourceRole).getBBDC().continueFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               if(gc.keyboardControl)
               {
                  gc.keyboardControl.setYesControlByPlayer(BaseHero(this.sourceRole).getPlayer());
               }
            }
         }
         if(this.sourceRole.getChildByName("eyefixBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("eyefixBuff"));
         }
      }
      
      protected function showPoisonTimes() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PoisonBuff"))
         {
            mc = AUtils.getNewObj("PoisonBuff");
            mc.name = "PoisonBuff";
            this.sourceRole.addChild(mc);
         }
      }
      
      protected function hidePoisonTimes() : void
      {
         if(this.sourceRole.getChildByName("PoisonBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PoisonBuff"));
         }
      }
      
      protected function showMonster53Tie() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("Monster53Bullet2"))
         {
            mc = AUtils.getNewObj("Monster53Bullet2");
            mc.name = "Monster53Bullet2";
            this.sourceRole.addChild(mc);
         }
         this.sourceRole.setStatic();
         this.sourceRole.getBBDC().stopFrame();
         if(this.sourceRole is BaseHero)
         {
            BaseHero(this.sourceRole).setStatic();
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).setLostKeyboard();
            }
         }
      }
      
      protected function hideMonster53Tie() : void
      {
         if(this.sourceRole.getChildByName("Monster53Bullet2"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("Monster53Bullet2"));
         }
         this.sourceRole.getBBDC().continueFrame();
         if(this.sourceRole is BaseHero)
         {
            if(BaseHero(this.sourceRole).getPlayer())
            {
               BaseHero(this.sourceRole).reSetLostKeyboard();
            }
         }
      }
      
      protected function showAttackUp() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PeachAttackUpBuff"))
         {
            mc = AUtils.getNewObj("PeachAttackUpBuff");
            mc.name = "PeachAttackUpBuff";
            this.sourceRole.addChild(mc);
         }
      }
      
      protected function hideAttackUp() : void
      {
         if(this.sourceRole.getChildByName("PeachAttackUpBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PeachAttackUpBuff"));
         }
      }
      
      protected function showMonster47Slow() : void
      {
      }
      
      protected function hideMonster47Slow() : void
      {
      }
      
      protected function showMonster47Poison() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PoisonBuff"))
         {
            mc = AUtils.getNewObj("PoisonBuff");
            mc.name = "PoisonBuff";
            this.sourceRole.addChild(mc);
         }
      }
      
      protected function hideMonster47Poison() : void
      {
         if(this.sourceRole.getChildByName("PoisonBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PoisonBuff"));
         }
      }
      
      protected function showPoison() : void
      {
         var mc:* = null;
         if(!this.sourceRole.getChildByName("PoisonBuff"))
         {
            mc = AUtils.getNewObj("PoisonBuff");
            mc.name = "PoisonBuff";
            this.sourceRole.addChild(mc);
         }
      }
      
      protected function hidePoison() : void
      {
         if(this.sourceRole.getChildByName("PoisonBuff"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("PoisonBuff"));
         }
      }
      
      public function cancelAllEffect() : void
      {
         var i:int = 0;
         var o:* = null;
         for(i = 0; i < this.curEffectArray.length; )
         {
            o = this.curEffectArray[i];
            if(o && o.name != "father")
            {
               this.remove(o);
            }
            i++;
         }
      }
      
      public function getBuffByName(kind:String) : Object
      {
         var i:int = 0;
         var o:* = null;
         for(i = 0; i < this.curEffectArray.length; )
         {
            o = this.curEffectArray[i];
            if(o && o.name == kind)
            {
               return o;
            }
            i++;
         }
         return null;
      }
      
      public function removeBuffByName(kind:String) : void
      {
         var o:Object = this.getBuffByName(kind);
         if(o)
         {
            this.remove(o);
         }
      }
      
      public function resetBuffTimeByKind(kind:String) : void
      {
         var o:Object = this.getBuffByName(kind);
         if(o)
         {
            o.startTime = this.count;
         }
      }
      
      public function getBuffTimeLeftByName(kind:String) : int
      {
         var i:int = 0;
         var o:* = null;
         for(i = 0; i < this.curEffectArray.length; )
         {
            o = this.curEffectArray[i];
            if(o && o.name == kind)
            {
               return o.time - (count - o.startTime);
            }
            i++;
         }
         return 0;
      }
      
      private function addBuffIcon() : void
      {
         if(this.sourceRole is BaseHero)
         {
            if(gc.gameInfo)
            {
               gc.gameInfo.addHeroBuff();
            }
         }
      }
      
      private function removeBuffIcon(name:String) : void
      {
         if(this.sourceRole is BaseHero)
         {
            if(gc.gameInfo)
            {
               gc.gameInfo.removeHeroBuff(name);
            }
         }
      }
      
      public function getAllBuffArray() : Array
      {
         return this.curEffectArray;
      }
      
      public function removeAllBuff() : void
      {
         var i:* = 0;
         var obj:* = null;
         for(i = uint(0); i < curEffectArray.length; )
         {
            obj = curEffectArray[i];
            if(obj)
            {
               this.remove(obj);
            }
            i++;
         }
         this.curEffectArray.length = 0;
      }
      
      public function curDebuff(kind:String) : Boolean
      {
         var i:* = 0;
         var obj:* = null;
         for(i = uint(0); i < curEffectArray.length; )
         {
            obj = curEffectArray[i];
            if(obj && obj.name == kind)
            {
               return true;
            }
            i++;
         }
         return false;
      }
   }
}
