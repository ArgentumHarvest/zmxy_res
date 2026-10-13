package base
{
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import export.level.StageListener151;
   import export.level.StageListener221;
   import export.level.StageListener222;
   import export.level.StageListener223;
   import export.monster.Monster150Children.YinghuochongBullet;
   import export.monster.Monster16;
   import export.monster.Monster6;
   import export.petSprite.DragonPetSprite;
   import export.petSprite.FireHorsePetSprite;
   import export.petSprite.MousePetSprite;
   import export.petSprite.NeatPetSprite;
   import export.petSprite.NianPetSprite;
   import export.petSprite.PhoenixPetSprite;
   import export.petSprite.TigressPetSprite;
   import export.petSprite.TurtlePetSprite;
   import export.petSprite.YinTigerPetSprite;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.ANumber;
   import my.ColorMatrix;
   import my.HitTest;
   import my.PetEquipObj;
   import petInfo.PetInfo;
   import user.MutiUser;
   
   public class BasePet extends BaseObject
   {
      
      public static var PET_MONKEY:uint = 0;
      
      public static var PET_HORSE:uint = 1;
       
      
      protected var sourceRole:BaseHero;
      
      private var hpSlip:Sprite;
      
      protected var _petInfo:PetInfo;
      
      protected var attackRate:Number = 0.7;
      
      protected var attackRange:uint = 150;
      
      protected var searchRange:uint = 400;
      
      protected var followRange:uint = 200;
      
      protected var curAttackTarget:BaseObject;
      
      protected var lastBeAttackedTarget:BaseObject;
      
      protected var skillCD1:Array;
      
      protected var skillCD2:Array;
      
      protected var skillCD3:Array;
      
      protected var skillCD4:Array;
      
      protected var timeCount:uint = 0;
      
      protected var petSprite:BasePetSprite;
      
      protected var sxkbCount:uint = 240;
      
      protected var fsnlCount:uint = 240;
      
      protected var smjcCount:uint = 240;
      
      protected var mfjcCount:uint = 240;
      
      protected var gjjcCount:uint = 240;
      
      protected var fyjcCount:uint = 240;
      
      protected var testCount:uint = 96;
      
      public function BasePet(bh:BaseHero, pi:PetInfo)
      {
         skillCD1 = [-1,30];
         skillCD2 = [-1,30];
         skillCD3 = [-1,30];
         skillCD4 = [-1,30];
         super();
         this.petInfo = pi;
         this.sourceRole = bh;
         this.newHpSlip();
         this.jumpPower = -30;
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
         this.bbdc.turnRight();
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 5,
            "interval":1000,
            "isForever":1
         }]);
         this.horizenSpeed = this._petInfo.getMoveSpeed();
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         if(gc.pWorld.getBaseLevelListener() is StageListener151)
         {
            StageListener151(gc.pWorld.getBaseLevelListener()).addBoatByBaseObject(this);
         }
         if(gc.pWorld.getBaseLevelListener() is StageListener221)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener221).addBoatByBaseObject(this);
         }
         if(gc.pWorld.getBaseLevelListener() is StageListener222)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener222).addBoatByBaseObject(this);
         }
         if(gc.pWorld.getBaseLevelListener() is StageListener223)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener223).addBoatByBaseObject(this);
         }
         this.refreshPetSprite();
      }
      
      public function refreshEquipsAndBuffs(newEquipArray:Array) : void
      {
         var curBuffArray:* = null;
         trace("refreshEquipsAndBuffs");
         if(this.curAddEffect)
         {
            curBuffArray = this.curAddEffect.getAllBuffArray().concat();
            this.curAddEffect.removeAllBuff();
         }
         if(this._petInfo)
         {
            this._petInfo.refreshEquip(newEquipArray);
         }
         if(this.curAddEffect)
         {
            if(curBuffArray && curBuffArray.length > 0)
            {
               for each(var obj in curBuffArray)
               {
                  if(obj)
                  {
                     this.curAddEffect.add(curBuffArray);
                  }
               }
            }
         }
         this.horizenSpeed = this._petInfo.getMoveSpeed();
      }
      
      public function get petInfo() : PetInfo
      {
         return _petInfo;
      }
      
      public function get sHp() : int
      {
         return _petInfo.getSHp();
      }
      
      public function set petInfo(value:PetInfo) : void
      {
         _petInfo = value;
         _petInfo.addEventListener(PetInfo.EVENT_REFRESHEQUIP,__refreshEquip);
      }
      
      private function __refreshEquip(evt:CommonEvent) : void
      {
         trace("===__refreshEquip===");
         var newEquipArray:Array = evt.data[0] as Array;
         this.refreshEquipsAndBuffs(newEquipArray);
         this.refreshPetSprite();
      }
      
      protected function refreshPetSprite() : void
      {
         var jnEquipType:int = -1;
         var equipArray:Array = this._petInfo.getEquipArray();
         for each(var pEquip in equipArray)
         {
            if(pEquip.type == "zbjn")
            {
               if(this._petInfo.getPetName().indexOf("phoenix") != -1)
               {
                  if(pEquip.getFillName() == "p_cylhjl" || pEquip.getFillName() == "p_jlcylhjl" || pEquip.getFillName() == "p_sscylhjl")
                  {
                     jnEquipType = 0;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("tigress") != -1)
               {
                  if(pEquip.getFillName() == "p_cybxjl" || pEquip.getFillName() == "p_jlcybxjl" || pEquip.getFillName() == "p_sscybxjl")
                  {
                     jnEquipType = 1;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("nian") != -1)
               {
                  if(pEquip.getFillName() == "p_cynsjl" || pEquip.getFillName() == "p_jlcynsjl" || pEquip.getFillName() == "p_sscynsjl")
                  {
                     jnEquipType = 2;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("turtle") != -1)
               {
                  if(pEquip.getFillName() == "p_cygsjl" || pEquip.getFillName() == "p_jlcygsjl" || pEquip.getFillName() == "p_sscygsjl")
                  {
                     jnEquipType = 3;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("dragon") != -1)
               {
                  if(pEquip.getFillName() == "p_cykljl" || pEquip.getFillName() == "p_jlcykljl" || pEquip.getFillName() == "p_sscykljl")
                  {
                     jnEquipType = 4;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("mouse") != -1)
               {
                  if(pEquip.getFillName() == "p_cyzsjl" || pEquip.getFillName() == "p_jlcyzsjl" || pEquip.getFillName() == "p_sscyzsjl")
                  {
                     jnEquipType = 5;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("neat") != -1)
               {
                  if(pEquip.getFillName() == "p_cycnjl" || pEquip.getFillName() == "p_jlcycnjl" || pEquip.getFillName() == "p_sscycnjl")
                  {
                     jnEquipType = 6;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("roomhorse") != -1)
               {
                  if(pEquip.getFillName() == "p_cyymjl" || pEquip.getFillName() == "p_jlcyymjl" || pEquip.getFillName() == "p_sscyymjl")
                  {
                     jnEquipType = 7;
                     break;
                  }
               }
               else if(this._petInfo.getPetName().indexOf("terribletiger") != -1)
               {
                  if(pEquip.getFillName() == "p_cyyhjl" || pEquip.getFillName() == "p_jlcyyhjl" || pEquip.getFillName() == "p_sscyyhjl")
                  {
                     jnEquipType = 8;
                     break;
                  }
               }
            }
         }
         if(jnEquipType != -1)
         {
            if(this.petSprite)
            {
               if(this.petSprite.type != jnEquipType)
               {
                  this.petSprite.destroy();
                  this.petSprite = null;
                  this.createPetSpriteByType(jnEquipType);
               }
            }
            else
            {
               this.createPetSpriteByType(jnEquipType);
            }
         }
         else if(this.petSprite)
         {
            this.petSprite.destroy();
            this.petSprite = null;
         }
      }
      
      private function createPetSpriteByType(type:int) : void
      {
         switch(int(type))
         {
            case 0:
               this.petSprite = new PhoenixPetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 1:
               this.petSprite = new TigressPetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 2:
               this.petSprite = new NianPetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 3:
               this.petSprite = new TurtlePetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 4:
               this.petSprite = new DragonPetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 5:
               this.petSprite = new MousePetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 6:
               this.petSprite = new NeatPetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 7:
               this.petSprite = new FireHorsePetSprite(this);
               gc.gameSence.addChild(this.petSprite);
               break;
            case 8:
               this.petSprite = new YinTigerPetSprite(this);
               gc.gameSence.addChild(this.petSprite);
         }
      }
      
      override protected function initBBDC() : void
      {
      }
      
      override public function step() : void
      {
         var waitForDeleteArray:Array = [];
         for each(var bb in this.magicBulletArray)
         {
            bb.step2();
            if(bb.isReadyToDestroy)
            {
               waitForDeleteArray.push(bb);
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray,this.magicBulletArray);
         this.myIntelligence();
         this.countSkillCD();
         this.timeCount++;
         if(this.timeCount >= 59999)
         {
            this.timeCount = 0;
         }
         if(this.isGXP)
         {
            if(this.timeCount % 4 == 0)
            {
               AUtils.shallowEffect(this);
            }
         }
         if(AUtils.GetDisBetweenTwoObj(this,this.sourceRole) >= 800)
         {
            if(!this.isAttacking() && !this.isBeAttacking())
            {
               this.x = this.sourceRole.x;
               this.y = this.sourceRole.y - 30;
            }
         }
         if(this._petInfo)
         {
            this._petInfo.step();
         }
         if(this.petSprite)
         {
            this.petSprite.step();
         }
         super.step();
      }
      
      protected function countSkillCD() : void
      {
         if(this.skillCD1[0] > 0)
         {
            if(this.skillCD1[0]-- <= 0)
            {
               this.skillCD1[0] = 0;
            }
         }
         if(this.skillCD2[0] > 0)
         {
            if(this.skillCD2[0]-- <= 0)
            {
               this.skillCD2[0] = 0;
            }
         }
         if(this.skillCD3[0] > 0)
         {
            if(this.skillCD3[0]-- <= 0)
            {
               this.skillCD3[0] = 0;
            }
         }
         if(this.skillCD4[0] > 0)
         {
            if(this.skillCD4[0]-- <= 0)
            {
               this.skillCD4[0] = 0;
            }
         }
      }
      
      private function clearWaitFromParentArray(wArray:Array, pArray:Array) : void
      {
         var temp:* = undefined;
         var i:* = 0;
         var idx:int = 0;
         for(i = uint(0); wArray.length > 0; )
         {
            temp = wArray.shift();
            idx = pArray.indexOf(temp);
            if(idx != -1)
            {
               pArray.splice(idx,1);
            }
            i++;
         }
      }
      
      protected function beforeSkill1Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill2Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill3Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill4Start() : Boolean
      {
         return false;
      }
      
      protected function releSkill1() : void
      {
      }
      
      protected function releSkill2() : void
      {
      }
      
      protected function releSkill3() : void
      {
      }
      
      protected function releSkill4() : void
      {
      }
      
      public function turnToGxp(time:uint) : void
      {
         time = time;
         this.isGXP = true;
         this.horizenSpeed *= 2;
         TweenMax.delayedCall(time,function(_self:BasePet):*
         {
            _self.cancelGxp();
         },[this]);
      }
      
      public function cancelGxp() : void
      {
         this.isGXP = false;
         this.horizenSpeed /= 2;
      }
      
      override protected function move() : void
      {
         if(this.curAddEffect)
         {
            if(this.curAddEffect.isAnyThingElseStun(""))
            {
               this.setStatic();
               return;
            }
         }
         var curFrameAddSpeedX:Number = this.speed.x;
         var curFrameAddSpeedY:Number = this.speed.y;
         if(this.standInObj)
         {
            if(this.speed.x == 0)
            {
               if(this.standInObj is Wall)
               {
                  curFrameAddSpeedX = Wall(this.standInObj).speedX;
               }
               else
               {
                  curFrameAddSpeedX = 0;
               }
            }
         }
         if(gc.isInSea())
         {
            curFrameAddSpeedX /= 2;
            curFrameAddSpeedY /= 2;
            if(curFrameAddSpeedY > 8)
            {
               curFrameAddSpeedY = 8;
            }
            if(this.speed.y > 16)
            {
               this.speed.y = 16;
            }
         }
         this.x += curFrameAddSpeedX;
         this.y += curFrameAddSpeedY;
         this.speed.y += graity;
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      protected function myIntelligence() : void
      {
         if(this.curAddEffect)
         {
            if(this.curAddEffect.isAnyThingElseStun(""))
            {
               return;
            }
         }
         if(!this.sourceRole)
         {
            return;
         }
         if(gc.sid == this.sourceRole.sid || gc.isSingleGame())
         {
            if(!this.curAttackTarget)
            {
               this.searchTarget();
               if(this.timeCount % gc.frameClips == 0)
               {
                  this.followSource();
               }
            }
            else if(this.curAttackTarget.isDead())
            {
               this.curAttackTarget = null;
            }
            else if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) >= 500)
            {
               this.curAttackTarget = null;
            }
            else if(!this.isAttacking() && !this.isBeAttacking())
            {
               if(this.beforeSkill1Start() && this.skillCD1[0] == 0)
               {
                  this.releSkill1();
                  this.skillCD1[0] = this.skillCD1[1];
               }
               else if(this.beforeSkill2Start() && this.skillCD2[0] == 0)
               {
                  this.releSkill2();
                  this.skillCD2[0] = this.skillCD2[1];
               }
               else if(this.beforeSkill3Start() && this.skillCD3[0] == 0)
               {
                  this.releSkill3();
                  this.skillCD3[0] = this.skillCD3[1];
               }
               else if(this.beforeSkill4Start() && this.skillCD4[0] == 0)
               {
                  this.releSkill4();
                  this.skillCD4[0] = this.skillCD4[1];
               }
               else if(this.timeCount % gc.frameClips == 0)
               {
                  if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= attackRange)
                  {
                     if(RandomControllor.getIns().getRandom() <= this.attackRate)
                     {
                        this.normalHit();
                     }
                     else if(RandomControllor.getIns().getRandom() < 0.3)
                     {
                        this.setStatic();
                        if(gc.isInRoom())
                        {
                           gc.sendPetAction(this.sourceRole.getRoleId(),"wait",this.x,this.y);
                        }
                     }
                     else
                     {
                        this.followTarget();
                     }
                  }
                  else
                  {
                     this.followTarget();
                  }
               }
            }
            if(gc.isInRoomOrSingleGame())
            {
               this.checkBuffSkill();
            }
            if(this.y - this.sourceRole.y > 300)
            {
               if(!this.isAttacking() && !this.isBeAttacking())
               {
                  this.jump();
               }
            }
            else if(this.sourceRole.y - this.y > 100)
            {
               if(!this.isAttacking() && !this.isBeAttacking())
               {
                  this.getFallDown();
               }
            }
         }
      }
      
      protected function checkBuffSkill() : void
      {
         if(sxkbCount > 0)
         {
            sxkbCount--;
         }
         if(fsnlCount > 0)
         {
            fsnlCount--;
         }
         if(smjcCount > 0)
         {
            smjcCount--;
         }
         if(mfjcCount > 0)
         {
            mfjcCount--;
         }
         if(gjjcCount > 0)
         {
            gjjcCount--;
         }
         if(fyjcCount > 0)
         {
            fyjcCount--;
         }
         if(testCount > 0)
         {
            testCount--;
         }
         var totalTime:uint = 0;
         var skillValue:Number = 0;
         if(sxkbCount == 0 && this._petInfo.findHasStudySkill("sxkb") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("sxkb"))
         {
            if(this.curAddEffect)
            {
               skillValue = this._petInfo.getPetHarmObj("sxkb").first;
               totalTime = this._petInfo.getPetHarmObj("sxkb").second;
               trace("嗜血狂暴--》skillValue:" + skillValue + ",totalTime:" + totalTime);
               this.curAddEffect.add([{
                  "name":BaseAddEffect.PET_SXKB,
                  "time":totalTime * gc.frameClips,
                  "value":skillValue
               }]);
            }
            this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("sxkb"));
            sxkbCount = 4320;
         }
         if(fsnlCount == 0 && this._petInfo.findHasStudySkill("fsnl") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("fsnl"))
         {
            if(this.curAddEffect)
            {
               skillValue = this._petInfo.getPetHarmObj("fsnl").first;
               totalTime = this._petInfo.getPetHarmObj("fsnl").second;
               trace("法术能量--》skillValue:" + skillValue + ",totalTime:" + totalTime);
               this.curAddEffect.add([{
                  "name":BaseAddEffect.PET_FSNL,
                  "time":totalTime * gc.frameClips,
                  "value":skillValue
               }]);
            }
            this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("fsnl"));
            fsnlCount = 4320;
         }
         if(smjcCount == 0 && this._petInfo.findHasStudySkill("smjc") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("smjc"))
         {
            if(this.curAddEffect)
            {
               skillValue = this._petInfo.getPetHarmObj("smjc").first;
               totalTime = this._petInfo.getPetHarmObj("smjc").second;
               trace("生命加成--》skillValue:" + skillValue + ",totalTime:" + totalTime);
               if(this.sourceRole)
               {
                  this.sourceRole.curAddEffect.add([{
                     "name":BaseAddEffect.PET_SMJC,
                     "time":totalTime * gc.frameClips,
                     "value":skillValue
                  }]);
               }
            }
            this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("smjc"));
            smjcCount = 4320;
         }
         if(mfjcCount == 0 && this._petInfo.findHasStudySkill("mfjc") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("mfjc"))
         {
            if(this.curAddEffect)
            {
               skillValue = this._petInfo.getPetHarmObj("mfjc").first;
               totalTime = this._petInfo.getPetHarmObj("mfjc").second;
               trace("魔法加成--》skillValue:" + skillValue + ",totalTime:" + totalTime);
               if(this.sourceRole)
               {
                  this.sourceRole.curAddEffect.add([{
                     "name":BaseAddEffect.PET_MFJC,
                     "time":totalTime * gc.frameClips,
                     "value":skillValue
                  }]);
               }
            }
            this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("mfjc"));
            mfjcCount = 4320;
         }
         if(gjjcCount == 0 && this._petInfo.findHasStudySkill("gjjc") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("gjjc"))
         {
            if(this.curAddEffect)
            {
               skillValue = this._petInfo.getPetHarmObj("gjjc").first;
               totalTime = this._petInfo.getPetHarmObj("gjjc").second;
               trace("攻击加成--》skillValue:" + skillValue + ",totalTime:" + totalTime);
               if(this.sourceRole)
               {
                  this.sourceRole.curAddEffect.add([{
                     "name":BaseAddEffect.PET_GJJC,
                     "time":totalTime * gc.frameClips,
                     "value":skillValue
                  }]);
               }
            }
            this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("gjjc"));
            gjjcCount = 4320;
         }
         if(fyjcCount == 0 && this._petInfo.findHasStudySkill("fyjc") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("fyjc"))
         {
            if(this.curAddEffect)
            {
               skillValue = this._petInfo.getPetHarmObj("fyjc").first;
               totalTime = this._petInfo.getPetHarmObj("fyjc").second;
               trace("防御加成--》skillValue:" + skillValue + ",totalTime:" + totalTime);
               if(this.sourceRole)
               {
                  this.sourceRole.curAddEffect.add([{
                     "name":BaseAddEffect.PET_FYJC,
                     "time":totalTime * gc.frameClips,
                     "value":skillValue
                  }]);
               }
            }
            this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("fyjc"));
            fyjcCount = 4320;
         }
      }
      
      public function setOtherAction(str:String) : void
      {
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               this.setAction("wait");
               this.setStatic();
               break;
            case "jump":
               this.jump();
               break;
            case "turnLeft":
               this.turnLeft();
               this.setAction("walk");
               break;
            case "turnRight":
               this.turnRight();
               this.setAction("walk");
               break;
            case "getfalldown":
               this.getFallDown();
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var missFlag:Boolean = false;
         var preState:int = 0;
         var obj:* = null;
         var point:* = null;
         var arr:* = null;
         var i:* = 0;
         var o:* = null;
         var hurt:int = 0;
         var isCrit:Boolean = false;
         var dis:Number = NaN;
         var eb:* = 0;
         var cureHpValue:* = 0;
         var attackBackPoint:* = null;
         if(this.isYourFather())
         {
            return false;
         }
         if(force || this.colipse && HitTest.complexHitTestObject(this.colipse,_target))
         {
            if(this._petInfo)
            {
               missFlag = false;
               if(this.getCurAddEffect(BaseAddEffect.PET_RABBIT_JIFENG))
               {
                  preState = int(this._petInfo.getPetName().charAt(this._petInfo.getPetName().length - 1));
                  if(RandomControllor.getIns().getRandom() < 0.1 + preState * 0.1)
                  {
                     missFlag = true;
                  }
               }
               if(RandomControllor.getIns().getRandom() < this._petInfo.getMiss())
               {
                  missFlag = true;
               }
               if(missFlag)
               {
                  this.addMissMc();
                  this.beAttackIdArray.push(_target.getAttackId());
                  return true;
               }
            }
            if(_target is YinghuochongBullet)
            {
               (_target as YinghuochongBullet).tieToObj(this);
            }
            this.lastBeAttackedTarget = sr;
            this.curAttackTarget = sr;
            obj = _target.sourceRoleAttackInfoObject;
            if(obj)
            {
               point = this.getBeattackBackSpeed(_target,obj);
               if(_target.getImcName() != "Role1Bullet12")
               {
                  this.setAttackBack(point);
               }
               if(obj.addEffect)
               {
                  arr = AUtils.clone(obj.addEffect) as Array;
                  for(i = uint(0); i < arr.length; )
                  {
                     o = arr[i];
                     if(o.time == BaseBullet.DESIDE_BY_FRAMES_LEFT)
                     {
                        o.time = _target.getFrameLeft();
                     }
                     i++;
                  }
                  this.addCurAddEffect(arr);
               }
            }
            hurt = _target.hurt;
            isCrit = _target.isCrit;
            if(_target.getImcName() == "Role1Bullet12")
            {
               dis = AUtils.GetDisBetweenTwoObj(this,sr);
               if(dis > 1000)
               {
                  dis = 1000;
               }
               hurt *= (1000 - dis) / 1000;
            }
            hurt = this.countHurt(hurt,obj);
            if(sr is BaseHero)
            {
               if(obj && obj.attackKind == "physics")
               {
                  if(BaseHero(sr).sid == gc.sid && gc.isInRoom())
                  {
                     eb = uint(BaseHero(sr).roleProperies.getEatBlood());
                     trace("吸血：" + eb + "%");
                     cureHpValue = uint(int(eb / 100 * hurt));
                     if(cureHpValue > 0)
                     {
                        BaseHero(sr).cureHp(cureHpValue);
                     }
                  }
               }
            }
            else if(sr is Monster6)
            {
               if(RandomControllor.getIns().getRandom() <= 0.1)
               {
                  if(this.curAddEffect)
                  {
                     this.curAddEffect.add([{
                        "name":BaseAddEffect.PETHORSE_ICE,
                        "time":gc.frameClips * 1.5
                     }]);
                  }
               }
            }
            else if(sr is Monster16)
            {
               if(RandomControllor.getIns().getRandom() <= 0.2)
               {
                  if(this.curAddEffect)
                  {
                     this.curAddEffect.add([{
                        "name":BaseAddEffect.PETMONKEY_FIRE,
                        "hurt":10,
                        "time":gc.frameClips * 3
                     }]);
                  }
               }
            }
            if(_target.getImcName() == "Role1Bullet12")
            {
               this.reduceHp(hurt,false);
            }
            else
            {
               this.reduceHp(hurt,true);
            }
            attackBackPoint = this.getBeattackBackSpeed(_target,obj);
            if(gc.isInRoom())
            {
               if(sr is BaseHero && this.sourceRole.sid != gc.sid)
               {
                  if(BaseHero(sr).sid == gc.sid)
                  {
                     if(_target.getImcName() == "Role1Bullet12")
                     {
                        gc.sendPetHurt(hurt,this.sourceRole.sid,this.sourceRole.getRoleId() * 10 + BaseHero(sr).getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer,false,false);
                     }
                     else
                     {
                        gc.sendPetHurt(hurt,this.sourceRole.sid,this.sourceRole.getRoleId() * 10 + BaseHero(sr).getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer);
                     }
                  }
               }
               else if(sr is BasePet && this.sid != gc.sid)
               {
                  if(BasePet(sr).getSourceRole().sid == gc.sid)
                  {
                     if(_target.getImcName() == "Role1Bullet12")
                     {
                        gc.sendPetHurt(hurt,this.sourceRole.sid,this.sourceRole.getRoleId() * 10 + BasePet(sr).getSourceRole().getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer,false,false);
                     }
                     else
                     {
                        gc.sendPetHurt(hurt,this.sourceRole.sid,this.sourceRole.getRoleId() * 10 + BasePet(sr).getSourceRole().getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer);
                     }
                  }
               }
            }
            this.addBeAttackEffect(sr);
            return true;
         }
         return false;
      }
      
      protected function addMissMc() : void
      {
         var missMc:* = AUtils.getImageObj("miss");
         missMc.x = this.x - 20;
         missMc.y = this.y - 60;
         gc.gameSence.addChild(missMc);
         TweenMax.to(missMc,2,{
            "y":missMc.y - 60,
            "alpha":0,
            "onComplete":function():*
            {
               if(missMc && gc.gameSence && gc.gameSence.contains(missMc))
               {
                  gc.gameSence.removeChild(missMc);
               }
            }
         });
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!this.isGXP)
         {
            super.setAttackBack(p);
         }
      }
      
      protected function countHurt(hurt:int, obj:Object) : int
      {
         var mdef:Number = NaN;
         if(obj)
         {
            if(obj.attackKind == "magic")
            {
               mdef = this._petInfo.getMDef();
               if(mdef > 1)
               {
                  mdef = 0;
               }
               return hurt * (1 - mdef);
            }
            if(obj.attackKind == "physics")
            {
               if(hurt > this._petInfo.getDef())
               {
                  hurt -= this._petInfo.getDef();
               }
               else
               {
                  hurt = 1;
               }
               return hurt;
            }
         }
         return hurt;
      }
      
      protected function getCriteValue(isCanCrit:Boolean) : Boolean
      {
         var critRate:Number = NaN;
         var o:* = null;
         var isCrit:Boolean = false;
         if(isCanCrit)
         {
            critRate = 0;
            if(this.curAddEffect)
            {
               o = this.curAddEffect.getBuffByName(BaseAddEffect.PET_SXKB);
               if(o)
               {
                  trace("嗜血狂暴->暴击率:" + o.value);
                  critRate += o.value;
               }
            }
            if(this._petInfo)
            {
               critRate += this._petInfo.getCrit();
            }
            if(RandomControllor.getIns().getRandom() <= critRate)
            {
               isCrit = true;
            }
         }
         else
         {
            isCrit = false;
         }
         return isCrit;
      }
      
      protected function getMagicAddValue() : uint
      {
         var o:* = null;
         var hurtAdd:uint = 0;
         if(this.curAddEffect)
         {
            o = this.curAddEffect.getBuffByName(BaseAddEffect.PET_FSNL);
            if(o)
            {
               trace("法术能量->提升伤害:" + o.value);
               hurtAdd = o.value;
            }
         }
         return hurtAdd;
      }
      
      override protected function getFallDown() : void
      {
         if(this.standInObj && this.standInObj.getChildByName("isThroughWall"))
         {
            this.y += 20;
            if(gc.isInRoom())
            {
               gc.sendPetAction(this.sourceRole.getRoleId(),"getfalldown",this.x,this.y);
            }
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var muti:* = null;
         var rate:Number = NaN;
         if(this.isGXP)
         {
            canHurt = false;
         }
         this.showHpSlip();
         this._petInfo.setHp(this._petInfo.getHp() - re);
         if(gc.sid == this.sourceRole.sid && gc.isInRoom() || gc.isSingleGame())
         {
            this.addMonHurtMc(re,false);
            muti = gc.getMutiUserBySidAndRoleId(this.sourceRole.sid,this.sourceRole.getRoleId());
            if(muti)
            {
               muti.petHp = this._petInfo.getHp();
               gc.sendSelfMutiUserInfo(this.sourceRole.getRoleId());
            }
         }
         this.drawPetHp();
         if(this._petInfo.getHp() <= 0)
         {
            this._petInfo.setHp(0);
            if(gc.sid == this.sourceRole.sid && gc.isInRoom())
            {
               if(this.curAction != "dead")
               {
                  this.setAction("dead");
                  gc.sendPetDead(this.sourceRole.getRoleId());
               }
            }
            else if(gc.isSingleGame())
            {
               if(this.curAction != "dead")
               {
                  if(this.sourceRole)
                  {
                     this.sourceRole.checkMeiguiBuffWhenChangeEquipAndChangePet();
                  }
                  this.setYourFather(200);
                  this.setAction("dead");
                  this._petInfo.setlifetime(this._petInfo.getlifetime() - 1);
               }
            }
         }
         else if(canHurt)
         {
            if(this._petInfo.findHasStudySkill("qlfj"))
            {
               rate = this._petInfo.getPetHarmObj("qlfj").first;
               trace("强力反击概率--》rate：" + rate);
               if(RandomControllor.getIns().getRandom() <= rate)
               {
                  if(!this.isAttacking())
                  {
                     this.setYourFather(10);
                     this.normalHit();
                  }
               }
               else if(this.curAction == "hurt")
               {
                  this.bbdc.setFramePointX(0);
               }
               else
               {
                  this.setAction("hurt");
               }
            }
            else if(this.curAction == "hurt")
            {
               this.bbdc.setFramePointX(0);
            }
            else
            {
               this.setAction("hurt");
            }
         }
      }
      
      public function cureHp(add:int) : void
      {
         var muti:* = null;
         if(gc.stage531Type == 1 && (gc.curStageAndCurLevel.curStage == 53 && gc.curStageAndCurLevel.curLevel == 1))
         {
            return;
         }
         if(!this.isDead())
         {
            if(this._petInfo.getHp() + add > this._petInfo.getSHp())
            {
               this._petInfo.setHp(this._petInfo.getSHp());
            }
            else
            {
               this._petInfo.setHp(this._petInfo.getHp() + add);
            }
            if(gc.sid == this.sourceRole.sid && gc.isInRoom())
            {
               muti = gc.getMutiUserBySidAndRoleId(this.sourceRole.sid,this.sourceRole.getRoleId());
               if(muti)
               {
                  muti.petHp = this._petInfo.getHp();
                  gc.sendSelfMutiUserInfo(this.sourceRole.getRoleId());
               }
            }
            this.addCureMc(add);
         }
      }
      
      public function cureMp(add:int) : void
      {
         if(this._petInfo.getMp() + add > this._petInfo.getSMp())
         {
            this._petInfo.setMp(this._petInfo.getSMp());
         }
         else
         {
            this._petInfo.setMp(this._petInfo.getMp() + add);
         }
         this.addCureMpMc(add);
      }
      
      public function addMonHurtMc(_hurt:int, isCrit:Boolean, _isShadow:Boolean = false) : *
      {
         var monHurtNumMc:ANumber = new ANumber();
         this.gc.gameSence.addChild(monHurtNumMc);
         monHurtNumMc.aNumImage("pnum",_hurt,this.x - 20,this.y - 60,20);
      }
      
      override protected function addBeAttackEffect(b:BaseObject) : void
      {
         if(this.curAddEffect)
         {
            this.curAddEffect.updateFather();
         }
         var img:MovieClip = AUtils.getNewObj("HeroBeHurt");
         var cm:ColorMatrix = new ColorMatrix();
         cm.adjustColor(0,0,0,100);
         img.filters = [new ColorMatrixFilter(cm)];
         img.x = this.colipse.x;
         img.y = this.colipse.y;
         this.addChild(img);
      }
      
      public function addBeAttackEffectForOther() : void
      {
         this.addBeAttackEffect(null);
      }
      
      protected function normalHit() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      protected function followTarget() : void
      {
         if(this.x > this.curAttackTarget.x)
         {
            this.turnLeft();
            if(gc.isInRoom())
            {
               gc.sendPetAction(this.sourceRole.getRoleId(),"turnLeft",this.x,this.y);
            }
         }
         else
         {
            this.turnRight();
            if(gc.isInRoom())
            {
               gc.sendPetAction(this.sourceRole.getRoleId(),"turnRight",this.x,this.y);
            }
         }
      }
      
      protected function followSource() : void
      {
         if(AUtils.GetDisBetweenTwoObj(this,this.sourceRole) > this.followRange)
         {
            if(this.x > this.sourceRole.x)
            {
               this.turnLeft();
               if(gc.isInRoom())
               {
                  gc.sendPetAction(this.sourceRole.getRoleId(),"turnLeft",this.x,this.y);
               }
            }
            else
            {
               this.turnRight();
               if(gc.isInRoom())
               {
                  gc.sendPetAction(this.sourceRole.getRoleId(),"turnRight",this.x,this.y);
               }
            }
         }
         else
         {
            this.setStatic();
            if(gc.isInRoom())
            {
               gc.sendPetAction(this.sourceRole.getRoleId(),"wait",this.x,this.y);
            }
         }
      }
      
      protected function addAoyiBuff() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("AoyiBuff");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(0);
         b.setDisable();
         b.setAction("null");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function faceToTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x < this.curAttackTarget.x)
            {
               this.turnRight();
               if(gc.isInRoom())
               {
                  gc.sendPetAction(this.sourceRole.getRoleId(),"turnRight",this.x,this.y);
               }
            }
            else
            {
               this.turnLeft();
               if(gc.isInRoom())
               {
                  gc.sendPetAction(this.sourceRole.getRoleId(),"turnLeft",this.x,this.y);
               }
            }
         }
      }
      
      protected function searchTarget() : void
      {
         for each(var bo in gc.obbsiteArray)
         {
            if(AUtils.GetDisBetweenTwoObj(bo,this) <= this.searchRange)
            {
               this.curAttackTarget = bo;
               break;
            }
         }
      }
      
      protected function showHpSlip() : void
      {
         this.hpSlip.visible = true;
         TweenMax.to(this.hpSlip,2,{
            "alpha":0,
            "onComplete":function(_hpSlip:Sprite):*
            {
               _hpSlip.visible = false;
            },
            "onCompleteParams":[this.hpSlip]
         });
      }
      
      protected function newHpSlip() : void
      {
         hpSlip = new Sprite();
         hpSlip.x = -23;
         hpSlip.y = -this.colipse.height / 2 - 10;
         hpSlip.visible = false;
         addChild(hpSlip);
      }
      
      protected function drawPetHp() : void
      {
         hpSlip.graphics.clear();
         hpSlip.alpha = 1;
         var reduce:* = Number(this._petInfo.getHp() / this._petInfo.getSHp());
         reduce = reduce < 0 ? 0 : reduce;
         if(this._petInfo.getHp() >= 0)
         {
            hpSlip.graphics.lineStyle(1.2,0);
            hpSlip.graphics.drawRect(0,5,50,5);
            hpSlip.graphics.beginFill(16711680);
            if(this.getBBDC().getDirect() == 0)
            {
               hpSlip.graphics.drawRect(0,5,50 * reduce,5);
            }
            else if(this.getBBDC().getDirect() == 1)
            {
               hpSlip.graphics.drawRect(50 - 50 * reduce,5,50 * reduce,5);
            }
            hpSlip.graphics.endFill();
         }
      }
      
      override protected function jump() : void
      {
         if(this.speed.y >= 0)
         {
            this.speed.y = jumpPower;
            if(gc.sid == this.sourceRole.sid && gc.isInRoom())
            {
               gc.sendPetAction(this.sourceRole.getRoleId(),"jump",this.x,this.y);
            }
         }
      }
      
      public function addExp(exp:int) : void
      {
         if(this._petInfo)
         {
            this._petInfo.setCurExper(this._petInfo.getCurExper() + exp);
         }
      }
      
      public function getExp() : int
      {
         if(this._petInfo)
         {
            return this._petInfo.getCurExper();
         }
         return 0;
      }
      
      public function getSourceRole() : BaseHero
      {
         return this.sourceRole;
      }
      
      public function destroy() : void
      {
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         if(this.petSprite)
         {
            this.petSprite.destroy();
            this.petSprite = null;
         }
         if(this.curAddEffect)
         {
            this.curAddEffect.destroy();
            this.curAddEffect = null;
         }
         this.isReadyToDestroy = true;
         TweenMax.to(this,1,{
            "alpha":0,
            "onComplete":function(_self:BasePet):*
            {
               if(_self.parent)
               {
                  _self.parent.removeChild(_self);
               }
            },
            "onCompleteParams":[this]
         });
         for(var i:int = 0; i < this.magicBulletArray.length; )
         {
            var bb:BaseBullet = this.magicBulletArray[i] as BaseBullet;
            bb.destroy();
            i++;
         }
         if(this._petInfo)
         {
            _petInfo.removeEventListener(PetInfo.EVENT_REFRESHEQUIP,__refreshEquip);
         }
         this.magicBulletArray = [];
         if(this.sourceRole)
         {
            this.sourceRole.clearPet();
            this.sourceRole = null;
         }
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var _loc3_:* = cur;
         if("hit1" !== _loc3_)
         {
            return 0;
         }
         return 10;
      }
      
      protected function hurtBaseEffectRate() : Number
      {
         var returnNumber:Number = 1;
         if(this.curAddEffect)
         {
            if(this.curAddEffect.getBuffByName(BaseAddEffect.MONSTER114FEAR))
            {
               if(this._petInfo)
               {
                  returnNumber = 1 - this._petInfo.getHp() / this._petInfo.getSHp();
               }
            }
         }
         return returnNumber;
      }
      
      override public function isDead() : Boolean
      {
         return this._petInfo.getHp() <= 0;
      }
      
      private function getDeCodeValue(v:Number) : int
      {
         return v * 10 + 5;
      }
      
      private function enCodeValue(v:int) : Number
      {
         return (v - 5) / 10;
      }
      
      public function getMitiSaveInfo() : String
      {
         return this._petInfo.getPetName() + "," + this._petInfo.getHp() + "," + this._petInfo.getMp();
      }
   }
}
