package base
{
   import com.greensock.TweenMax;
   import com.hexagonstar.util.debug.Debug;
   import com.superkaka.game.Manager.Keyboard.KeyboardInput;
   import event.CommonEvent;
   import export.RoleInfo;
   import export.WsEffect;
   import export.bullet.FollowBaseObjectBullet;
   import export.hero.Role1;
   import export.hero.Role2;
   import export.hero.Role3;
   import export.hero.Role4;
   import export.honor.AllianceData;
   import export.honor.AllianceSecondInterface;
   import export.honor.PlayerHonor;
   import export.magicWeapon.MagicBagua;
   import export.magicWeapon.MagicBalloon;
   import export.magicWeapon.MagicBigBottle;
   import export.magicWeapon.MagicBottle;
   import export.magicWeapon.MagicCowKing;
   import export.magicWeapon.MagicDikuihualan;
   import export.magicWeapon.MagicFan;
   import export.magicWeapon.MagicFlute;
   import export.magicWeapon.MagicFootball;
   import export.magicWeapon.MagicLDBSword;
   import export.magicWeapon.MagicLXFB;
   import export.magicWeapon.MagicLeaf;
   import export.magicWeapon.MagicLianhua;
   import export.magicWeapon.MagicRedBottle;
   import export.magicWeapon.MagicRing;
   import export.magicWeapon.MagicSXFB;
   import export.magicWeapon.MagicShenxing;
   import export.magicWeapon.MagicSword;
   import export.magicWeapon.MagicTurnRoundKing;
   import export.magicWeapon.MagicTurtle;
   import export.magicWeapon.MagicUmbrella;
   import export.magicWeapon.MagicYXFB;
   import export.magicWeapon.MagicYaowangBottle;
   import export.magicWeapon.MagicYuJinPing;
   import export.magicWeapon.MagicYyb;
   import export.monster.Monster121;
   import export.monster.Monster150Children.YinghuochongBullet;
   import export.monster.Monster16;
   import export.monster.Monster34;
   import export.monster.Monster6;
   import export.pet.PetDragon1;
   import export.pet.PetDragon2;
   import export.pet.PetDragon3;
   import export.pet.PetDragon4;
   import export.pet.PetHorse1;
   import export.pet.PetHorse2;
   import export.pet.PetHorse3;
   import export.pet.PetHorse4;
   import export.pet.PetKabu1;
   import export.pet.PetKabu2;
   import export.pet.PetKabu3;
   import export.pet.PetMonkey1;
   import export.pet.PetMonkey2;
   import export.pet.PetMonkey3;
   import export.pet.PetMonkey4;
   import export.pet.PetMouse1;
   import export.pet.PetMouse2;
   import export.pet.PetMouse3;
   import export.pet.PetMouse4;
   import export.pet.PetNeat1;
   import export.pet.PetNeat4;
   import export.pet.PetNian1;
   import export.pet.PetNian2;
   import export.pet.PetNian3;
   import export.pet.PetNian4;
   import export.pet.PetNian5;
   import export.pet.PetPhoenix1;
   import export.pet.PetPhoenix2;
   import export.pet.PetPhoenix3;
   import export.pet.PetPhoenix4;
   import export.pet.PetRabbit1;
   import export.pet.PetRabbit2;
   import export.pet.PetRabbit3;
   import export.pet.PetRabbit4;
   import export.pet.PetRoomHorse1;
   import export.pet.PetRoomHorse2;
   import export.pet.PetRoomHorse3;
   import export.pet.PetRoomHorse4;
   import export.pet.PetTiger1;
   import export.pet.PetTiger2;
   import export.pet.PetTiger3;
   import export.pet.PetTiger4;
   import export.pet.PetTurtle1;
   import export.pet.PetTurtle2;
   import export.pet.PetTurtle3;
   import export.pet.PetTurtle4;
   import export.pet.PetYingTiger1;
   import export.pet.PetYingTiger4;
   import export.summon.SummonCowKing;
   import export.summon.SummonTurnRoundKing;
   import export.summon.SummonTurtle;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import loader.PlayerAssetsLoaderManager;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.ColorMatrix;
   import my.ExceedPower;
   import my.HitTest;
   import my.KeyCodeCombo;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   import user.MutiUser;
   import user.User;
   
   public class BaseHero extends BaseObject
   {
      
      public static const USE_MAGICWEAPON:String = "use_magicweapon";
       
      
      private var roleId:uint;
      
      private var mm:MusicManager;
      
      private var isFabaoJiasu:Boolean = false;
      
      public var keyboard:KeyboardInput;
      
      public var playerFightingScore:Number = 0.1;
      
      protected var allianceBitmap:Bitmap;
      
      public var levelexp:Array;
      
      public var roleName:String = "";
      
      public var roleProperies:BaseRoleProperies;
      
      public var userType:String = "";
      
      protected var cannextaction:Boolean = true;
      
      protected var curUpTime:int;
      
      protected var curtime:int = 0;
      
      public var doubleCount:uint;
      
      protected var exceedPowerSprite:ExceedPower;
      
      protected var hitNum:uint = 1;
      
      protected var keyId:int;
      
      protected var keyList:Array;
      
      protected var keyarray:Array;
      
      protected var lastDirbtn:uint;
      
      protected var lastKey:Object;
      
      protected var lastUpTime:int;
      
      protected var lasttime:int = 0;
      
      protected var player:User;
      
      protected var timers:int = 0;
      
      protected var myPet:BasePet;
      
      protected var summon:BaseSummon;
      
      protected var comboKeyArray:Array;
      
      private var skillKeyArr:Array;
      
      protected var equipCounter:uint = 0;
      
      protected var equipLoadingMc:MovieClip;
      
      public function BaseHero()
      {
         keyboard = new KeyboardInput();
         levelexp = [135,145,155,165,175,185,625,675,725,775,825,875,1950,2050,2150,2250,2350,2450,5000];
         keyList = [];
         lastKey = {};
         comboKeyArray = [];
         skillKeyArr = [89,76,85,73,79,32,72];
         super();
         mm = MusicManager.getInstance();
         roleProperies = new BaseRoleProperies(this);
         this.attackBackInfoDict["hitNiumowangSzBuff"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,0],
            "attackInterval":24,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hitZhuanlunwangSzBuff"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 5
            }]
         };
         this.attackBackInfoDict["hitTiantingZhanshenSzBuff"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.TIANTINGZHANSHEN,
               "time":gc.frameClips * 2
            }]
         };
         this.attackBackInfoDict["fabao-sword"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_qlj"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_nh"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_xz"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_sfjz"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.PETHORSE_ICE,
               "time":gc.frameClips * 2,
               "rate":0.1
            }]
         };
         this.attackBackInfoDict["BossSkill_bs_hlcj"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.PETMONKEY_FIRE,
               "time":gc.frameClips * 3,
               "hurt":500
            }]
         };
         this.attackBackInfoDict["BossSkill_bs_tl"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_jt"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 2
            }]
         };
         this.attackBackInfoDict["BossSkill_bs_lx"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_syfy"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_3"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.FIX,
               "time":BaseBullet.DESIDE_BY_FRAMES_LEFT
            }]
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_4"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_5"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_6"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_8"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_9"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_10"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_11"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_12"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_13"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["BossSkill_bs_erishiba_14"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hzlFan"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["football1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["football2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "attackKind":"physics"
         };
         this._anti.yiwan = 10000;
         this._anti.yiwanwuqian = 15000;
         this._anti.liangqiansanbai = 2300;
         this._anti.yiwansanqianerbai = 13200;
         this._anti.sanqiansanbai = 3300;
         this._anti.liangqianbabai = 2800;
         this._anti.yiwanyiqian = 11000;
      }
      
      public function start() : void
      {
         Debug.trace("---start---");
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
         if(this.getPlayer())
         {
            this.changeEquip(this.getPlayer().getEquipNum());
         }
         else
         {
            this.refreshAlliance();
         }
         if(this.player)
         {
            this.initPopertits();
            if(this.roleProperies)
            {
               this.roleProperies.dispatchEvent(new CommonEvent("AddExper",[0]));
            }
         }
         if(gc.isSingleGame())
         {
            if(!gc.isInWeiPk())
            {
               this.initPet();
               this.initMagicWeapon();
               this.curAddEffect.add([{
                  "name":"father",
                  "time":gc.frameClips * 1,
                  "interval":1000,
                  "isForever":1
               }]);
            }
         }
         else if(gc.isInRoom() || gc.isInHost())
         {
            this.curAddEffect.add([{
               "name":"father",
               "time":gc.frameClips * 1,
               "interval":1000,
               "isForever":1
            }]);
         }
         this.keyarray = gc.keyboardControl.getZeroKeyArray();
         this.setAction("wait");
      }
      
      protected function getAssetsArray(roleName:String) : Array
      {
         var equipName:* = null;
         var weaponName:* = null;
         var body:* = null;
         var equip:* = null;
         trace("===getAssetsArra->:" + roleName);
         var bodyId:uint = this.getCurClothId();
         var weaponId:uint = this.getCurWeaponId();
         var assetsArray:Array = [];
         roleName = roleName.toUpperCase();
         if(roleName == "ROLE4")
         {
            if(!(weaponId == 4 || weaponId == 5 || weaponId == 7 || weaponId == 8 || weaponId == 9))
            {
               equipName = "ROLE4_SHOVEL_" + bodyId;
            }
            else
            {
               equipName = "ROLE4_ARROW_" + bodyId;
            }
            weaponName = "ROLE4_EQUIP_" + weaponId;
         }
         else
         {
            equipName = roleName + "_" + bodyId;
            weaponName = roleName + "_EQUIP_" + weaponId;
         }
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(equipName);
         var eqArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(weaponName);
         if(!bmdArray)
         {
            body = {
               "name":"body",
               "source":[]
            };
            this.addEquipLoading();
            PlayerAssetsLoaderManager.getInstance().addSingle(equipName + ".swf",assetsLoadComplete);
         }
         else
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
         }
         assetsArray.push(body);
         if(!eqArray)
         {
            equip = {
               "name":"equip",
               "source":[]
            };
            this.addEquipLoading();
            PlayerAssetsLoaderManager.getInstance().addSingle(weaponName + ".swf",assetsLoadComplete);
         }
         else
         {
            equip = {
               "name":"equip",
               "source":eqArray
            };
         }
         assetsArray.push(equip);
         return assetsArray;
      }
      
      protected function assetsLoadComplete() : void
      {
         this.refreshEquip();
         this.removeEquipLoading();
      }
      
      private function addEquipLoading() : void
      {
         if(!this.equipLoadingMc)
         {
            this.equipLoadingMc = AUtils.getNewObj("EquipLoading") as MovieClip;
            this.addChild(this.equipLoadingMc);
         }
      }
      
      private function removeEquipLoading() : void
      {
         if(this.equipLoadingMc)
         {
            if(this.contains(this.equipLoadingMc))
            {
               this.removeChild(this.equipLoadingMc);
            }
            this.equipLoadingMc = null;
         }
      }
      
      private function refreshAlliance() : void
      {
         var txname:* = null;
         txname = null;
         var bhMutiUser:* = null;
         var hd:* = null;
         if(this.getPlayer())
         {
            if(this.isPlayer3())
            {
               if(AllianceSecondInterface.getIns().honorData)
               {
                  if(AllianceSecondInterface.getIns().honorData.groupId != -1)
                  {
                     if(!this.allianceBitmap)
                     {
                        this.allianceBitmap = PlayerHonor.getHonorBitmap(AllianceSecondInterface.getIns().honorData);
                        this.allianceBitmap.x = -this.allianceBitmap.width / 2;
                        this.addChild(this.allianceBitmap);
                     }
                     txname = this.player.getEquipNum().zbtx;
                     if(txname != "")
                     {
                        this.allianceBitmap.y = -120;
                     }
                     else
                     {
                        this.allianceBitmap.y = -90;
                     }
                  }
               }
            }
            else if(gc.honorData.groupId != -1)
            {
               if(!this.allianceBitmap)
               {
                  this.allianceBitmap = PlayerHonor.getHonorBitmap(gc.honorData);
                  this.allianceBitmap.x = -this.allianceBitmap.width / 2;
                  this.addChild(this.allianceBitmap);
               }
               txname = this.player.getEquipNum().zbtx;
               if(txname != "")
               {
                  this.allianceBitmap.y = -120;
               }
               else
               {
                  this.allianceBitmap.y = -90;
               }
            }
         }
         else
         {
            bhMutiUser = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId()) as MutiUser;
            trace("bhMutiUser:" + bhMutiUser);
            if(bhMutiUser)
            {
               if(bhMutiUser.honorName != "")
               {
                  if(!this.allianceBitmap)
                  {
                     hd = new AllianceData();
                     hd.honorName = bhMutiUser.honorName;
                     hd.jobName = bhMutiUser.jobName;
                     this.allianceBitmap = PlayerHonor.getHonorBitmap(hd);
                     this.allianceBitmap.x = -this.allianceBitmap.width / 2;
                     this.addChild(this.allianceBitmap);
                     this.allianceBitmap.y = -90;
                  }
               }
            }
         }
      }
      
      public function __keyBoardDown(evt:KeyboardEvent) : void
      {
         if(this.isDead())
         {
            return;
         }
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,evt.keyCode))
         {
            return;
         }
         if(!this.cannotusebossskill())
         {
            this.comboKeyArray.push(new KeyCodeCombo(evt.keyCode));
         }
         if(this.lastKey.keyCode == undefined)
         {
            this.lastKey.keyCode = evt.keyCode;
         }
         if(this.lastKey.keyId == undefined)
         {
            this.lastKey.keyId = this.keyId;
         }
         if(evt.keyCode != this.lastKey.keyCode)
         {
            this.keyId++;
         }
         switch(evt.keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               moveLeft();
               this.addDoubleCount(evt.keyCode);
               lastDirbtn = evt.keyCode;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               moveRight();
               this.addDoubleCount(evt.keyCode);
               lastDirbtn = evt.keyCode;
         }
         this.checkDoubleCount(evt.keyCode);
         this.lastKey.keyCode = evt.keyCode;
         this.lastKey.keyId = this.keyId;
         for(var k:uint = this.keyList.length; k-- > 0; )
         {
            if(this.keyList[k] == evt.keyCode)
            {
               this.keyarray[k] = 1;
            }
         }
         if(!this.isBeAttacking() && !this.isAttacking() && !this.isStatic())
         {
            if(this.isRunning())
            {
               if(!this.isJump())
               {
                  this.setAction("run");
               }
            }
            else
            {
               if(!this.isJump())
               {
                  this.setAction("walk");
               }
               if(getTimer() - lastWalkSendInterval > 500)
               {
                  if(gc.isInRoom())
                  {
                     gc.sendWalkInfo(this);
                  }
               }
               lastWalkSendInterval = getTimer();
            }
         }
      }
      
      public function execKeyboardDown(keyCode:int) : void
      {
         if(this.isDead())
         {
            return;
         }
         this.keyboard.keyDown(keyCode);
         if(!this.cannotusebossskill())
         {
            this.comboKeyArray.push(new KeyCodeCombo(keyCode));
         }
         if(this.lastKey.keyCode == undefined)
         {
            this.lastKey.keyCode = keyCode;
         }
         if(this.lastKey.keyId == undefined)
         {
            this.lastKey.keyId = this.keyId;
         }
         if(keyCode != this.lastKey.keyCode)
         {
            this.keyId++;
         }
         switch(keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               moveLeft();
               this.addDoubleCount(keyCode);
               lastDirbtn = keyCode;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               moveRight();
               this.addDoubleCount(keyCode);
               lastDirbtn = keyCode;
         }
         this.checkDoubleCount(keyCode);
         this.lastKey.keyCode = keyCode;
         this.lastKey.keyId = this.keyId;
         for(var k:uint = this.keyList.length; k-- > 0; )
         {
            if(this.keyList[k] == keyCode)
            {
               this.keyarray[k] = 1;
            }
         }
         if(!this.isBeAttacking() && !this.isAttacking() && !this.isStatic())
         {
            if(this.isRunning())
            {
               if(!this.isJump())
               {
                  this.setAction("run");
               }
            }
            else
            {
               if(!this.isJump())
               {
                  this.setAction("walk");
               }
               if(getTimer() - lastWalkSendInterval > 500)
               {
                  if(gc.isInRoom())
                  {
                     gc.sendWalkInfo(this);
                  }
               }
               lastWalkSendInterval = getTimer();
            }
         }
         var skillIdx1:int = skillKeyArr.indexOf(keyCode);
         if(skillIdx1 != -1)
         {
            this.sendSkill(skillIdx1);
         }
      }
      
      public function execKeyboardUp(keyCode:int) : void
      {
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,keyCode))
         {
            return;
         }
         this.keyboard.keyUp(keyCode);
         if(keyCode == this.lastKey.keyCode)
         {
            this.keyId++;
         }
         switch(keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               stopMoveLeft();
               if(this.lastDirbtn == keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               stopMoveRight();
               if(this.lastDirbtn == keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
         }
         for(var k:uint = this.keyList.length; k-- > 0; )
         {
            if(this.keyList[k] == keyCode)
            {
               this.cannextaction = true;
               this.keyarray[k] = 0;
            }
         }
      }
      
      public function callSummonByType(type:uint, level:uint) : void
      {
         if(this.summon)
         {
            this.clearSummon();
            this.summon = null;
         }
         if(type == BaseSummon.SUMMON_TURTLE)
         {
            this.summon = new SummonTurtle(this,level);
         }
         else if(type == BaseSummon.SUMMON_COWKING)
         {
            this.summon = new SummonCowKing(this,level);
         }
         else if(type == BaseSummon.SUMMON_TURNROUNDKING)
         {
            this.summon = new SummonTurnRoundKing(this,level);
         }
         if(this.summon)
         {
            this.summon.x = this.x;
            this.summon.y = this.y - 50;
            gc.gameSence.addChild(this.summon);
         }
      }
      
      public function initPopertits() : void
      {
         if(this.roleProperies)
         {
            this.roleProperies.setInitValue();
            if(!gc.isHideDebug)
            {
               this.roleProperies.dispatchEvent(new CommonEvent("SetLevel",[300]));
            }
            else
            {
               this.roleProperies.dispatchEvent(new CommonEvent("SetLevel",[this.player.getCurLevel()]));
            }
            this.roleProperies.dispatchEvent(new CommonEvent("SetInitExper",[this.player.getCurExp()]));
         }
         this.upGrade();
         this.attackBackInfoDict["BossSkill_bs_erishiba_7"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 5,
               "power":this.roleProperies.getPower() / 2
            }]
         };
      }
      
      public function resetKey() : void
      {
         this.keyarray = gc.keyboardControl.getZeroKeyArray();
         this.lastDirbtn = 0;
         this.lastKey = {};
      }
      
      public function cureHp(add:int) : void
      {
         var obj:* = null;
         var obj2:* = null;
         var bhMutiUser:* = null;
         if(gc.isInWeiPk())
         {
            add *= 1.2 - this.playerFightingScore;
            if(add <= 0)
            {
               add = 1;
            }
         }
         if(gc.stage531Type == 1 && (gc.curStageAndCurLevel.curStage == 53 && gc.curStageAndCurLevel.curLevel == 1))
         {
            return;
         }
         if(!this.isDead())
         {
            if(this.curAddEffect)
            {
               obj = this.curAddEffect.getBuffByName(BaseAddEffect.PETTURTKE_BUFF);
               if(obj)
               {
                  if(this.getPet() && this.getPet().curAddEffect)
                  {
                     obj2 = this.getPet().curAddEffect.getBuffByName(BaseAddEffect.PETTURTKE_BUFF);
                     if(obj2)
                     {
                        this.getPet().cureHp(add);
                     }
                  }
               }
            }
            if(gc.sid == this.sid && gc.isInRoom())
            {
               bhMutiUser = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId()) as MutiUser;
               if(bhMutiUser)
               {
                  bhMutiUser.hp += add;
                  gc.sendSelfHpInfo(this.getRoleId());
               }
            }
            if(this.roleProperies)
            {
               this.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.roleProperies.getHHP() + add]));
            }
            this.addCureMc(add);
         }
      }
      
      protected function initPet() : void
      {
         var pi:* = null;
         var muti:* = null;
         if(this.getPlayer())
         {
            pi = this.getPlayer().findCurrentPet();
         }
         else
         {
            muti = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(muti)
            {
               if(muti.petName != "")
               {
                  pi = new PetInfo();
                  pi.setPetNameAndLevel(muti.petName,muti.petLevel);
                  pi.setHp(muti.petHp);
                  pi.setSHp(muti.petHp);
                  pi.setMp(muti.petMp);
                  pi.setSMp(muti.petMp);
               }
            }
         }
         if(pi)
         {
            if(pi.getHp() > 0)
            {
               pi.setDoWhenLevelUp(doWhenLevelUp);
               pi.setDoWhenChangeState(doWhenChangeState);
               this.myPet = this.addPetByPi(pi);
               this.myPet.x = this.x;
               this.myPet.y = this.y - 100;
               gc.gameSence.addChild(this.myPet);
            }
         }
         this.checkMeiguiBuffWhenChangeEquipAndChangePet();
      }
      
      public function doWhenLevelUp() : *
      {
         var mc:* = null;
         if(this.getPet())
         {
            mc = AUtils.getNewObj("PetLevelUpMc") as MovieClip;
            this.getPet().addChild(mc);
         }
      }
      
      public function doWhenChangeState() : *
      {
         if(this.getPet())
         {
            this.changePet();
         }
      }
      
      public function addPetByPi(pi:PetInfo) : BasePet
      {
         var returnPet:* = null;
         var petName:String = pi.getPetName();
         if(petName == "monkey1")
         {
            returnPet = new PetMonkey1(this,pi);
         }
         else if(petName == "monkey2")
         {
            returnPet = new PetMonkey2(this,pi);
         }
         else if(petName == "monkey3")
         {
            returnPet = new PetMonkey3(this,pi);
         }
         else if(petName == "monkey4")
         {
            returnPet = new PetMonkey4(this,pi);
         }
         else if(petName == "horse1")
         {
            returnPet = new PetHorse1(this,pi);
         }
         else if(petName == "horse2")
         {
            returnPet = new PetHorse2(this,pi);
         }
         else if(petName == "horse3")
         {
            returnPet = new PetHorse3(this,pi);
         }
         else if(petName == "horse4")
         {
            returnPet = new PetHorse4(this,pi);
         }
         else if(petName == "ufo1")
         {
            returnPet = new PetKabu1(this,pi);
         }
         else if(petName == "ufo2")
         {
            returnPet = new PetKabu2(this,pi);
         }
         else if(petName == "ufo3")
         {
            returnPet = new PetKabu3(this,pi);
         }
         else if(petName == "tigress1")
         {
            returnPet = new PetTiger1(this,pi);
         }
         else if(petName == "tigress2")
         {
            returnPet = new PetTiger2(this,pi);
         }
         else if(petName == "tigress3")
         {
            returnPet = new PetTiger3(this,pi);
         }
         else if(petName == "tigress4")
         {
            returnPet = new PetTiger4(this,pi);
         }
         else if(petName == "turtle1")
         {
            returnPet = new PetTurtle1(this,pi);
         }
         else if(petName == "turtle2")
         {
            returnPet = new PetTurtle2(this,pi);
         }
         else if(petName == "turtle3")
         {
            returnPet = new PetTurtle3(this,pi);
         }
         else if(petName == "turtle4")
         {
            returnPet = new PetTurtle4(this,pi);
         }
         else if(petName == "phoenix1")
         {
            returnPet = new PetPhoenix1(this,pi);
         }
         else if(petName == "phoenix2")
         {
            returnPet = new PetPhoenix2(this,pi);
         }
         else if(petName == "phoenix3")
         {
            returnPet = new PetPhoenix3(this,pi);
         }
         else if(petName == "phoenix4")
         {
            returnPet = new PetPhoenix4(this,pi);
         }
         else if(petName == "dragon1")
         {
            returnPet = new PetDragon1(this,pi);
         }
         else if(petName == "dragon2")
         {
            returnPet = new PetDragon2(this,pi);
         }
         else if(petName == "dragon3")
         {
            returnPet = new PetDragon3(this,pi);
         }
         else if(petName == "dragon4")
         {
            returnPet = new PetDragon4(this,pi);
         }
         else if(petName == "rabbit1")
         {
            returnPet = new PetRabbit1(this,pi);
         }
         else if(petName == "rabbit2")
         {
            returnPet = new PetRabbit2(this,pi);
         }
         else if(petName == "rabbit3")
         {
            returnPet = new PetRabbit3(this,pi);
         }
         else if(petName == "rabbit4")
         {
            returnPet = new PetRabbit4(this,pi);
         }
         else if(petName == "nian1")
         {
            returnPet = new PetNian1(this,pi);
         }
         else if(petName == "nian2")
         {
            returnPet = new PetNian2(this,pi);
         }
         else if(petName == "nian3")
         {
            returnPet = new PetNian3(this,pi);
         }
         else if(petName == "nian4")
         {
            returnPet = new PetNian4(this,pi);
         }
         else if(petName == "nian5")
         {
            returnPet = new PetNian5(this,pi);
         }
         else if(petName == "mouse1")
         {
            returnPet = new PetMouse1(this,pi);
         }
         else if(petName == "mouse2")
         {
            returnPet = new PetMouse2(this,pi);
         }
         else if(petName == "mouse3")
         {
            returnPet = new PetMouse3(this,pi);
         }
         else if(petName == "mouse4")
         {
            returnPet = new PetMouse4(this,pi);
         }
         else if(petName == "neat1")
         {
            returnPet = new PetNeat1(this,pi);
         }
         else if(petName == "neat2")
         {
            returnPet = new PetNeat1(this,pi);
         }
         else if(petName == "neat3")
         {
            returnPet = new PetNeat1(this,pi);
         }
         else if(petName == "neat4")
         {
            returnPet = new PetNeat4(this,pi);
         }
         else if(petName == "roomhorse1")
         {
            returnPet = new PetRoomHorse1(this,pi);
         }
         else if(petName == "roomhorse2")
         {
            returnPet = new PetRoomHorse2(this,pi);
         }
         else if(petName == "roomhorse3")
         {
            returnPet = new PetRoomHorse3(this,pi);
         }
         else if(petName == "roomhorse4")
         {
            returnPet = new PetRoomHorse4(this,pi);
         }
         else if(petName == "terribletiger1" || petName == "terribletiger2" || petName == "terribletiger3")
         {
            returnPet = new PetYingTiger1(this,pi);
         }
         else if(petName == "terribletiger4")
         {
            returnPet = new PetYingTiger4(this,pi);
         }
         return returnPet;
      }
      
      protected function initMagicWeapon() : void
      {
         var fb:* = null;
         var muti:* = null;
         if(gc.curStageAndCurLevel.curStage == 60)
         {
            return;
         }
         if(this.getPlayer())
         {
            fb = this.getPlayer().getCurEquipByType("zbfb");
            if(fb)
            {
               if(fb.getFillName() == "xhhl")
               {
                  this.curMagicWeapon = new MagicBottle(this);
               }
               else if(fb.getFillName() == "kyl")
               {
                  this.curMagicWeapon = new MagicLeaf(this);
               }
               else if(fb.getFillName() == "qyj")
               {
                  this.curMagicWeapon = new MagicSword(this);
               }
               else if(fb.getFillName() == "hyzzs")
               {
                  this.curMagicWeapon = new MagicUmbrella(this);
               }
               else if(fb.getFillName() == "zjld")
               {
                  this.curMagicWeapon = new MagicRing(this);
               }
               else if(fb.getFillName() == "gcxdyy")
               {
                  this.curMagicWeapon = new MagicTurtle(this);
               }
               else if(fb.getFillName() == "yjp")
               {
                  this.curMagicWeapon = new MagicYuJinPing(this);
               }
               else if(fb.getFillName() == "qljfb")
               {
                  this.curMagicWeapon = new MagicBigBottle(this);
               }
               else if(fb.getFillName() == "nmwdnh")
               {
                  this.curMagicWeapon = new MagicCowKing(this);
               }
               else if(fb.getFillName() == "zlwdah")
               {
                  this.curMagicWeapon = new MagicTurnRoundKing(this);
               }
               else if(fb.getFillName() == "xhhhl")
               {
                  this.curMagicWeapon = new MagicRedBottle(this);
               }
               else if(fb.getFillName() == "yyzlj")
               {
                  this.curMagicWeapon = new MagicLDBSword(this);
               }
               else if(fb.getFillName() == "ywhl")
               {
                  this.curMagicWeapon = new MagicYaowangBottle(this);
               }
               else if(fb.getFillName() == "zhyx")
               {
                  this.curMagicWeapon = new MagicFlute(this);
               }
               else if(fb.getFillName() == "bjs")
               {
                  this.curMagicWeapon = new MagicFan(this);
               }
               else if(fb.getFillName() == "hsqq" || fb.getFillName() == "zsqq" || fb.getFillName() == "h_sqq" || fb.getFillName() == "lsqq" || fb.getFillName() == "csqq" || fb.getFillName() == "l_sqq" || fb.getFillName() == "fsqq")
               {
                  this.curMagicWeapon = new MagicBalloon(this,fb.getFillName());
               }
               else if(fb.getFillName() == "sxyg")
               {
                  this.curMagicWeapon = new MagicShenxing(this);
               }
               else if(fb.getFillName() == "dkhl")
               {
                  this.curMagicWeapon = new MagicDikuihualan(this);
               }
               else if(fb.getFillName() == "yyb")
               {
                  this.curMagicWeapon = new MagicYyb(this);
               }
               else if(fb.getFillName() == "hehua")
               {
                  this.curMagicWeapon = new MagicLianhua(this);
               }
               else if(fb.getFillName() == "tjbg")
               {
                  this.curMagicWeapon = new MagicBagua(this);
               }
               else if(fb.getFillName() == "lxfb")
               {
                  this.curMagicWeapon = new MagicLXFB(this);
               }
               else if(fb.getFillName() == "sxfb")
               {
                  this.curMagicWeapon = new MagicSXFB(this);
               }
               else if(fb.getFillName() == "bxzq")
               {
                  this.curMagicWeapon = new MagicFootball(this);
               }
               else if(fb.getFillName() == "yxfb")
               {
                  this.curMagicWeapon = new MagicYXFB(this);
               }
               if(this.curMagicWeapon)
               {
                  gc.gameSence.addChild(this.curMagicWeapon);
               }
            }
         }
         else
         {
            muti = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
            if(muti)
            {
               if(muti.bmwId == BaseMagicWeapon.BMW_Bottle)
               {
                  this.curMagicWeapon = new MagicBottle(this);
               }
               else if(muti.bmwId == BaseMagicWeapon.BMW_Leaf)
               {
                  this.curMagicWeapon = new MagicLeaf(this);
               }
               else if(muti.bmwId == BaseMagicWeapon.BMW_Ring)
               {
                  this.curMagicWeapon = new MagicRing(this);
               }
               else if(muti.bmwId == BaseMagicWeapon.BMW_Sword)
               {
                  this.curMagicWeapon = new MagicSword(this);
               }
               else if(muti.bmwId == BaseMagicWeapon.BMW_Umbrella)
               {
                  this.curMagicWeapon = new MagicUmbrella(this);
               }
               else if(muti.bmwId == BaseMagicWeapon.BMW_YuJinPing)
               {
                  this.curMagicWeapon = new MagicYuJinPing(this);
               }
               if(this.curMagicWeapon)
               {
                  gc.gameSence.addChild(this.curMagicWeapon);
               }
            }
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var obj:* = null;
         var petHurt:* = 0;
         var bhMutiUser:* = null;
         var fb:* = null;
         var b:* = null;
         var shsjt:* = null;
         var level:* = 0;
         b = null;
         b = null;
         super.reduceHp(re,canHurt);
         if(gc.isInWeiPk())
         {
            re *= this.playerFightingScore;
            if(re <= 0)
            {
               re = 1;
            }
         }
         if(this.curAddEffect)
         {
            if(this.curAddEffect.curDebuff(BaseAddEffect.MAGIC_UMBRELLA_DEFEND))
            {
               this.curAddEffect.reduceMagicUmbDef(re);
               this.setStatic();
               return;
            }
            if(this.curAddEffect)
            {
               obj = this.curAddEffect.getBuffByName(BaseAddEffect.PETTURTKE_BUFF);
               if(obj)
               {
                  if(this.getPet() && this.getPet().curAddEffect)
                  {
                     if(this.getPet().curAddEffect.getBuffByName(BaseAddEffect.PETTURTKE_BUFF))
                     {
                        petHurt = uint(obj.value * re / 100);
                        re -= petHurt;
                        this.getPet().reduceHp(petHurt,false);
                     }
                  }
               }
            }
         }
         if(gc.sid == this.sid && gc.isInRoom())
         {
            bhMutiUser = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId()) as MutiUser;
            if(bhMutiUser)
            {
               bhMutiUser.hp -= re;
               gc.sendSelfHpInfo(this.getRoleId());
            }
         }
         if(this.roleProperies)
         {
            this.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.roleProperies.getHHP() - re]));
         }
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            this.addHeroHurtMc(re);
         }
         if(!this.isDead())
         {
            if(canHurt)
            {
               this.setAction("hurt");
               this.doubleCount = 0;
            }
         }
         else
         {
            if(gc.isSingleGame() && this.getPlayer())
            {
               fb = this.getPlayer().getCurEquipByType("zbfb");
               if(fb)
               {
                  if(fb.getFillName() == "tjbg")
                  {
                     if(!this.getPlayer().isRealiveByBagua)
                     {
                        if(this.roleProperies)
                        {
                           this.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.roleProperies.getSHHP()]));
                        }
                        if(fb.getWX().indexOf("木") != -1)
                        {
                           if(this.roleProperies)
                           {
                              this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() + this.roleProperies.getSMMP() / 2]));
                           }
                        }
                        b = new FollowBaseObjectBullet("HeroReLive");
                        b.x = this.x;
                        b.y = this.y;
                        b.setRole(this);
                        b.setDirect(0);
                        b.setDisable();
                        b.setAction("relive");
                        gc.gameSence.addChild(b);
                        this.magicBulletArray.push(b);
                        this.setYourFather(gc.frameClips * 2);
                        this.getPlayer().isRealiveByBagua = true;
                        return;
                     }
                  }
               }
               shsjt = this.getPlayer().getCurEquipByType("zbsp");
               if(shsjt)
               {
                  if(shsjt.getFillName() == "shsjt")
                  {
                     level = uint(shsjt.getStrengthValue());
                     if(this.roleProperies)
                     {
                        this.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.roleProperies.getSHHP() * (level + 1) * 0.2]));
                     }
                     b = new FollowBaseObjectBullet("HeroReLive");
                     b.x = this.x;
                     b.y = this.y;
                     b.setRole(this);
                     b.setDirect(0);
                     b.setDisable();
                     b.setAction("relive");
                     gc.gameSence.addChild(b);
                     this.magicBulletArray.push(b);
                     this.getPlayer().removeCurEquip(shsjt);
                     this.setYourFather(gc.frameClips * 2);
                     return;
                  }
                  if(shsjt.getFillName() == "clj")
                  {
                     if(this.roleProperies)
                     {
                        this.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.roleProperies.getSHHP()]));
                        this.roleProperies.removeAllEquip();
                        this.getPlayer().doWhenCljBroken();
                        this.roleProperies.addAllEquip();
                     }
                     b = new FollowBaseObjectBullet("HeroReLive");
                     b.x = this.x;
                     b.y = this.y;
                     b.setRole(this);
                     b.setDirect(0);
                     b.setDisable();
                     b.setAction("relive");
                     gc.gameSence.addChild(b);
                     this.magicBulletArray.push(b);
                     this.setYourFather(gc.frameClips * 2);
                     return;
                  }
               }
            }
            if(!this.isAlreadyDead)
            {
               this.isAlreadyDead = true;
               this.destroy();
               if(gc.sid == this.sid && gc.isInRoom())
               {
                  gc.sendDead(this.getRoleId());
               }
               gc.eventManger.dispatchEvent(new CommonEvent("heroDead",this));
            }
         }
      }
      
      override public function isWaiting() : Boolean
      {
         return this.curAction == "wait" || this.curAction == "wait2";
      }
      
      public function cureMp(re:int) : void
      {
         if(this.roleProperies)
         {
            this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() + re]));
         }
         this.addCureMpMc(re);
      }
      
      public function reduceMp(re:int) : void
      {
         if(this.roleProperies)
         {
            this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - re]));
         }
         this.addHeroMpReduceMc(re);
      }
      
      protected function setPet() : void
      {
         this.updatePet();
      }
      
      protected function updateSummon() : void
      {
         if(this.summon)
         {
            if(this.summon.isDead())
            {
               this.clearSummon();
            }
            else
            {
               this.summon.step();
            }
         }
      }
      
      protected function updateEquip() : void
      {
         var eq:* = null;
         if(this.player)
         {
            eq = this.player.getCurEquipByType("zbsp");
            if(eq)
            {
               if(eq.getFillName() == "zhhz" || eq.getFillName() == "cs_sp_hy")
               {
                  for each(var bm in gc.pWorld.monsterArray)
                  {
                     if(bm.isFly && !bm.isBoss && !(gc.curStageAndCurLevel.curStage >= 24 && gc.curStageAndCurLevel.curStage <= 30) && gc.curStageAndCurLevel.curStage != 61)
                     {
                        if(!bm.isYourFather())
                        {
                           if(AUtils.GetDisBetweenTwoObj(bm,this) <= 300)
                           {
                              bm.addCurAddEffect([{
                                 "name":BaseAddEffect.MONSTER117SLEEP,
                                 "time":gc.frameClips * 0.5
                              }]);
                           }
                        }
                     }
                  }
               }
               if(eq.getFillName() == "bxhy" || eq.getFillName() == "cs_sp_hy")
               {
                  if(getTimer() - this.lastHitTime >= 10000)
                  {
                     if(equipCounter == 0)
                     {
                        this.cureHp(this.roleProperies.getSHHP() * this.roleProperies.getTotalHx() / 10000);
                     }
                  }
               }
            }
         }
         if(equipCounter >= 0)
         {
            equipCounter++;
            if(equipCounter == gc.frameClips)
            {
               equipCounter = 0;
            }
         }
      }
      
      public function getCurMagicWeapon() : BaseMagicWeapon
      {
         return this.curMagicWeapon;
      }
      
      public function updateMagicWeapon() : void
      {
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.step();
         }
      }
      
      public function updatePet() : void
      {
         if(this.myPet)
         {
            this.myPet.step();
         }
      }
      
      public function clearPet() : void
      {
         this.myPet = null;
      }
      
      public function sendSkill(idx:int) : void
      {
         if(this.isDead())
         {
            return;
         }
         if(!this.cannotusebossskill())
         {
            this.comboKeyArray.push(new KeyCodeCombo(gc.keyboardControl.getSkillKeyByPlayerAndIndex(this.player,idx)));
         }
         var skill:String = "";
         switch(int(idx))
         {
            case 0:
               if(this.getPlayer().controlPlayer == 0)
               {
                  skill = "Y";
               }
               else
               {
                  skill = "8";
               }
               this.showSkill(skill);
               break;
            case 1:
               if(this.getPlayer().controlPlayer == 0)
               {
                  skill = "L";
               }
               else
               {
                  skill = "3";
               }
               this.showSkill(skill);
               break;
            case 2:
               if(this.getPlayer().controlPlayer == 0)
               {
                  skill = "U";
               }
               else
               {
                  skill = "4";
               }
               this.showSkill(skill);
               break;
            case 3:
               if(this.getPlayer().controlPlayer == 0)
               {
                  skill = "I";
               }
               else
               {
                  skill = "5";
               }
               this.showSkill(skill);
               break;
            case 4:
               if(this.getPlayer().controlPlayer == 0)
               {
                  skill = "O";
               }
               else
               {
                  skill = "6";
               }
               this.showSkill(skill);
               break;
            case 5:
               this.showSkillKongGe();
               break;
            case 6:
               this.showSkillFaBao();
         }
      }
      
      protected function cannotuseskill() : Boolean
      {
         if(gc.curStageAndCurLevel.curStage == 61)
         {
            return true;
         }
         return false;
      }
      
      protected function cannotusebossskill() : Boolean
      {
         if(gc.curStageAndCurLevel.curStage == 61)
         {
            return true;
         }
         return false;
      }
      
      protected function showSkill(skill:String) : void
      {
         if(this.curAddEffect)
         {
            this.curAddEffect.resetBuffTimeByKind(BaseAddEffect.MONSTER151BUFF);
         }
      }
      
      protected function showSkillKongGe() : void
      {
      }
      
      protected function showSkillFaBao() : void
      {
         if(!gc.isSingleGame())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.useSkill();
         }
         this.dispatchEvent(new Event("use_magicweapon"));
      }
      
      public function __keyBoardUp(evt:KeyboardEvent) : void
      {
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,evt.keyCode))
         {
            return;
         }
         if(evt.keyCode == this.lastKey.keyCode)
         {
            this.keyId++;
         }
         switch(evt.keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               stopMoveLeft();
               if(this.lastDirbtn == evt.keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               stopMoveRight();
               if(this.lastDirbtn == evt.keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
         }
         for(var k:uint = this.keyList.length; k-- > 0; )
         {
            if(this.keyList[k] == evt.keyCode)
            {
               this.cannextaction = true;
               this.keyarray[k] = 0;
            }
         }
      }
      
      public function stopMoveLeft() : void
      {
         this.isLeft = false;
         if(!this.isRight)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  if(!this.isWaiting())
                  {
                     this.setAction("wait");
                  }
                  if(this.sid == gc.sid && gc.isInRoom())
                  {
                     gc.sendPosition(this);
                  }
               }
               else if(this.sid == gc.sid && gc.isInRoom())
               {
                  gc.sendLorRInfo(this);
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else if(this.bbdc)
         {
            this.bbdc.turnRight();
         }
      }
      
      public function stopMoveRight() : void
      {
         this.isRight = false;
         if(!this.isLeft)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  if(!this.isWaiting())
                  {
                     this.setAction("wait");
                  }
                  if(this.sid == gc.sid && gc.isInRoom())
                  {
                     gc.sendPosition(this);
                  }
               }
               else if(this.sid == gc.sid && gc.isInRoom())
               {
                  gc.sendLorRInfo(this);
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else if(this.bbdc)
         {
            this.bbdc.turnLeft();
         }
      }
      
      override public function getHurtByPig8(hurt:int) : void
      {
         this.reduceHp(hurt);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var hurtSource:int = 0;
         var obj:* = null;
         var dis:Number = NaN;
         var addObj:* = null;
         var hurt:int = 0;
         var eb:* = 0;
         var cureHpValue:* = 0;
         var attackBackPoint:* = null;
         var arr:* = null;
         var i:* = 0;
         var o:* = null;
         if(this._anti.isYourFather || !this.roleProperies)
         {
            return false;
         }
         if(force || this.colipse && HitTest.complexHitTestObject(this.colipse,_target))
         {
            if(RandomControllor.getIns().getRandom() <= this.roleProperies.getMiss() / 100)
            {
               this.addMissMc();
               this.beAttackIdArray.push(_target.getAttackId());
               return true;
            }
            if(_target is YinghuochongBullet)
            {
               (_target as YinghuochongBullet).tieToObj(this);
            }
            if(_target.isBingo)
            {
               trace("bingo!");
               this.reduceHp(this.roleProperies.getHHP() * 10);
               this.addBingoMc();
               return true;
            }
            hurtSource = _target.hurt;
            obj = _target.sourceRoleAttackInfoObject;
            if(_target.getImcName() == "Role1Bullet12")
            {
               dis = AUtils.GetDisBetweenTwoObj(this,sr);
               if(dis > 1000)
               {
                  dis = 1000;
               }
               hurtSource = hurtSource * (1000 - dis) / 1000;
            }
            else if(_target.getImcName() == "Monster138Bullet3")
            {
               hurtSource += this.roleProperies.getHHP() / 10;
            }
            else if(_target.getImcName() == "Monster54Bullet3")
            {
               hurtSource += this.roleProperies.getSHHP() * 0.3;
            }
            addObj = this.curAddEffect.getBuffByName(BaseAddEffect.MONSTER137BUFF);
            if(addObj)
            {
               hurtSource += addObj.times * 100;
            }
            hurt = this.countHurt(hurtSource,obj);
            _target.finallHurt = hurt;
            if(_target.getImcName() == "Role1Bullet12")
            {
               this.reduceHp(hurt,false);
            }
            else
            {
               this.reduceHp(hurt,true);
            }
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
                        "time":gc.frameClips * 2
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
            else if(sr is Monster34)
            {
               if(obj && obj.attackKind == "physics")
               {
                  Monster34(sr).cureHp(hurt * 0.05);
               }
            }
            else if(sr is Monster121)
            {
               if(obj && obj.attackKind == "physics")
               {
                  Monster121(sr).cureHp(hurt * Monster121(sr).getEatBlood());
               }
            }
            attackBackPoint = this.getBeattackBackSpeed(_target,obj);
            if(gc.isInRoom())
            {
               if(sr is BaseHero && this.sid != gc.sid)
               {
                  if(BaseHero(sr).sid == gc.sid)
                  {
                     if(_target.getImcName() == "Role1Bullet12")
                     {
                        gc.sendHurt(hurt,this.sid,this.getRoleId() * 10 + BaseHero(sr).getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer,false,false);
                     }
                     else
                     {
                        gc.sendHurt(hurt,this.sid,this.getRoleId() * 10 + BaseHero(sr).getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer);
                     }
                  }
               }
               else if(sr is BasePet && this.sid != gc.sid)
               {
                  if(BasePet(sr).getSourceRole().sid == gc.sid)
                  {
                     if(_target.getImcName() == "Role1Bullet12")
                     {
                        gc.sendHurt(hurt,this.sid,this.getRoleId() * 10 + BasePet(sr).getSourceRole().getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer,false,false);
                     }
                     else
                     {
                        gc.sendHurt(hurt,this.sid,this.getRoleId() * 10 + BasePet(sr).getSourceRole().getRoleId(),_target.curAction,attackBackPoint.x,attackBackPoint.y,_target.initTimer);
                     }
                  }
               }
               else if(sr is BaseMonster && this.sid == gc.sid)
               {
                  gc.sendBeHurtedByMonster(this,BaseMonster(sr).entityId,attackBackPoint.x,attackBackPoint.y);
               }
            }
            if(this is Role3)
            {
               if(this.curAction == "hit12")
               {
                  trace("反弹");
                  if(sr is BaseMonster)
                  {
                     sr.reduceHp(hurt * 2);
                     BaseMonster(sr).addMonHurtMc(hurt * 2,false);
                  }
                  else if(sr.sid == gc.sid)
                  {
                     sr.reduceHp(hurt / 10);
                  }
               }
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(Role3(this).getPlayer())
                  {
                     if(Role3(this).getPlayer().findSkillIsInTheSkillAry("rj"))
                     {
                        if(RandomControllor.getIns().getRandom() <= 0.1)
                        {
                           this.cureHp(this.roleProperies.getHurt());
                        }
                     }
                  }
               }
            }
            if(_target.getImcName() != "Role1Bullet12")
            {
               this.setAttackBack(attackBackPoint);
            }
            if(obj && obj.addEffect)
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
            this.beAttackIdArray.push(_target.getAttackId());
            this.beAttackDoing();
            if(this is Role1)
            {
               mm.play("Role1_beAttack");
            }
            else if(this is Role2)
            {
               mm.play("Role2_beAttack");
            }
            else if(this is Role3)
            {
               mm.play("Role3_beAttack");
            }
            else if(this is Role4)
            {
               mm.play("Role3_beAttack");
            }
            return true;
         }
         return false;
      }
      
      protected function countHurt(hurt:int, obj:Object) : int
      {
         var muti:* = null;
         var mDef:Number = NaN;
         var def:int = 0;
         if(obj)
         {
            if(obj.attackKind == "magic")
            {
               if(this.getPlayer())
               {
                  mDef = this.roleProperies.getMagicDefWhenCountHurt() / 100;
               }
               else
               {
                  muti = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
                  mDef = muti.mDef / 100;
               }
               if(mDef > 1)
               {
                  mDef = 0.999;
               }
               return int(hurt * (1 - mDef));
            }
            if(obj.attackKind == "physics")
            {
               if(this.getPlayer())
               {
                  def = this.roleProperies.getDefenseWhenCountHurt();
               }
               else
               {
                  muti = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
                  def = muti.def;
               }
               if(hurt > def)
               {
                  hurt -= def;
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
      
      public function beAttackDoing() : void
      {
         this.resetGraity();
         this.addBeAttackEffect(null);
         if(this.curAddEffect)
         {
            this.curAddEffect.updateFather();
         }
      }
      
      override protected function addBeAttackEffect(b:BaseObject) : void
      {
         var img:MovieClip = AUtils.getNewObj("HeroBeHurt");
         var cm:ColorMatrix = new ColorMatrix();
         if(this is Role2)
         {
            cm.adjustColor(0,0,0,160);
         }
         img.filters = [new ColorMatrixFilter(cm)];
         img.x = this.colipse.x;
         img.y = this.colipse.y;
         this.addChild(img);
      }
      
      public function getPet() : BasePet
      {
         return this.myPet;
      }
      
      public function getKeyArray() : Array
      {
         return this.keyarray;
      }
      
      public function getPlayer() : User
      {
         return this.player;
      }
      
      override public function isAttacking() : Boolean
      {
         return false;
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk" || this.doubleCount == 1;
      }
      
      public function normalHit() : *
      {
      }
      
      override public function resetGraity() : void
      {
         super.resetGraity();
      }
      
      public function setKeyList(keyArray:Array) : void
      {
         this.keyList = keyArray;
      }
      
      public function setPlayer(p:User) : void
      {
         this.player = p;
      }
      
      public function setLostKeyboard() : void
      {
         var i:int = 0;
         gc.keyboardControl.setNoControlByPlayer(this.getPlayer());
         for(i = 0; i < keyarray.length; )
         {
            keyarray[i] = 0;
            i++;
         }
         this.lastDirbtn = 0;
         this.lastKey = {};
         this.cannextaction = true;
      }
      
      public function reSetLostKeyboard() : void
      {
         gc.keyboardControl.setYesControlByPlayer(this.getPlayer());
      }
      
      override public function step() : void
      {
         super.step();
         this.stepOther();
         if(this.curAction == "jump1" && this.speed.y > 0)
         {
            this.setAction("jump3");
         }
         this.stepCombo();
         if(this.curMagicWeapon)
         {
            if(this.curMagicWeapon is MagicYuJinPing)
            {
               (this.curMagicWeapon as MagicYuJinPing).checkCombo(this.comboKeyArray);
            }
         }
         this.setPet();
         this.updateMagicWeapon();
         this.updateSummon();
         this.updateEquip();
         var globalPoint:Point = gc.gameSence.localToGlobal(new Point(this.x,this.y));
         var localPoint:Point = gc.gameSence.globalToLocal(new Point(20,0));
         if(globalPoint.x < 20)
         {
            this.x = localPoint.x;
         }
         else if(globalPoint.x > 920)
         {
            this.x = localPoint.x + 900;
         }
      }
      
      protected function stepCombo() : void
      {
         var temp:* = null;
         var kccTemp:* = null;
         var idx:int = 0;
         for each(var kcc in this.comboKeyArray)
         {
            kcc.step();
         }
         if(this.comboKeyArray.length > 0)
         {
            temp = this.comboKeyArray.concat();
            while(temp.length > 0)
            {
               kccTemp = temp.shift() as KeyCodeCombo;
               if(kccTemp.isDestroy)
               {
                  idx = this.comboKeyArray.indexOf(kccTemp);
                  if(idx != -1)
                  {
                     this.comboKeyArray.splice(idx,1);
                  }
               }
            }
         }
      }
      
      protected function stepOther() : void
      {
         var ri:* = null;
         if(this.isGXP)
         {
            if(this.getPlayer())
            {
               ri = gc.gameInfo.getRoleInfoByPlayer(this.player);
            }
            shadowCount++;
            if(this.shadowCount % 4 == 0)
            {
               this.shadowEffect();
               if(this.getPlayer())
               {
                  if(ri.isGXPAlive())
                  {
                     ri.reduceGXP(1);
                  }
                  else
                  {
                     this.isGXP = false;
                     this.turnToNormal();
                     if(gc.isInRoom())
                     {
                        if(gc.sid == this.sid)
                        {
                           gc.sendRoleWushuangOver(this.getRoleId());
                        }
                     }
                  }
               }
            }
         }
         if(this.getPlayer())
         {
            if(this.roleProperies)
            {
               this.roleProperies.step();
            }
            this.executeKeyCode();
            this.executeLastDirKey();
            this.keyboard.step();
         }
      }
      
      public function upGrade(first:Boolean = true) : *
      {
         if(this.roleProperies)
         {
            this.roleProperies.removeAllBuff();
         }
      }
      
      protected function addDoubleCount(key:uint) : *
      {
         if(key == this.lastKey.keyCode && this.keyId != this.lastKey.keyId)
         {
            this.curUpTime = getTimer();
            if(this.curUpTime - this.lastUpTime >= 500)
            {
               this.doubleCount = 0;
            }
            else
            {
               if(this.doubleCount == 0)
               {
                  if(this.getPlayer() && gc.isInRoom())
                  {
                     gc.sendRun(this);
                  }
               }
               this.doubleCount = 1;
            }
            this.lastUpTime = this.curUpTime;
         }
         if(key != this.lastKey.keyCode)
         {
            this.doubleCount = 0;
            this.curUpTime = getTimer();
            this.lastUpTime = this.curUpTime;
         }
      }
      
      public function addHeroHurtMc(_hurt:int) : void
      {
         if(this.cureHpQueue)
         {
            this.cureHpQueue.addHpLose(_hurt,this.x - 20,this.y - 60);
         }
      }
      
      public function addHeroMpReduceMc(mp:int) : void
      {
         if(this.cureHpQueue)
         {
            this.cureHpQueue.addMpLose(mp,this.x - 20,this.y - 60);
         }
      }
      
      protected function addMissMc() : void
      {
         var missMc:* = AUtils.getImageObj("miss");
         missMc.x = this.x - 20;
         missMc.y = this.y - 60;
         this.gc.gameSence.addChild(missMc);
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
      
      protected function checkDirect() : void
      {
         if(this.isLeft)
         {
            if(this.bbdc)
            {
               this.bbdc.turnLeft();
            }
         }
         if(this.isRight)
         {
            if(this.bbdc)
            {
               this.bbdc.turnRight();
            }
         }
      }
      
      protected function checkDoubleCount(key:uint) : void
      {
      }
      
      protected function doWsEffect() : void
      {
         var wsEffect:WsEffect = new WsEffect();
         wsEffect.x = 470;
         wsEffect.y = 295;
         if(this is Role1)
         {
            wsEffect.Role2Mc.visible = false;
            wsEffect.Role3Mc.visible = false;
         }
         else if(this is Role2)
         {
            wsEffect.Role1Mc.visible = false;
            wsEffect.Role3Mc.visible = false;
         }
         else if(this is Role3)
         {
            wsEffect.Role1Mc.visible = false;
            wsEffect.Role2Mc.visible = false;
         }
         gc.gameInfo.addChild(wsEffect);
      }
      
      protected function executeKeyCode() : *
      {
         this.myKeyDown(this.keyarray.join(""));
      }
      
      protected function executeLastDirKey() : void
      {
         if(!this.isAttacking())
         {
            switch(this.lastDirbtn)
            {
               case 65:
                  this.turnLeft();
                  break;
               case 37:
               case 68:
                  this.turnRight();
                  break;
               case 39:
            }
         }
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return false;
      }
      
      override protected function isRunning() : Boolean
      {
         return this.doubleCount == 1;
      }
      
      override protected function jump() : void
      {
         if(!this.isAttacking() && !this.isBeAttacking())
         {
            if(this._anti.jumpCount < 2)
            {
               this.speed.y = jumpPower;
               if(this._anti.jumpCount == 0)
               {
                  this._anti.jumpCount = 1;
                  this.setAction("jump1");
                  if(this.getPlayer() && gc.isInRoom())
                  {
                     gc.sendWalkInfo(this);
                  }
               }
               else
               {
                  this._anti.jumpCount = 2;
                  this.setAction("jump2");
                  if(this.getPlayer() && gc.isInRoom())
                  {
                     gc.sendWalkInfo(this);
                  }
               }
            }
            else if(this._anti.jumpCount == 2)
            {
               if(gc.isInSea())
               {
                  this.speed.y = jumpPower;
                  this.setAction("jump2");
                  if(this.getPlayer() && gc.isInRoom())
                  {
                     gc.sendWalkInfo(this);
                  }
               }
            }
         }
      }
      
      public function doJump() : void
      {
         this.jump();
      }
      
      override protected function move() : void
      {
         var fb:* = null;
         var obj:* = null;
         var obj115:* = null;
         var speedReduceRate:Number = 1;
         var isBuffStun:Boolean = false;
         var graityValue:Number = this.graity;
         var graityOffset:Number = 0;
         if(gc.isSingleGame())
         {
            fb = this.getCurMagicWeapon();
            if(fb && fb is MagicBalloon)
            {
               graityOffset = -0.5;
               if(this.keyarray.join("") == "1000")
               {
                  graityOffset += 3;
               }
            }
         }
         graityValue += graityOffset;
         if(this.curAddEffect)
         {
            if(this.curAddEffect.isAnyThingElseStun(""))
            {
               isBuffStun = true;
            }
            obj = this.curAddEffect.getBuffByName(BaseAddEffect.MONSTER47SLOW);
            if(obj)
            {
               speedReduceRate = 0.5;
            }
            obj115 = this.curAddEffect.getBuffByName(BaseAddEffect.MONSTER115SLOW);
            if(obj115)
            {
               speedReduceRate = 0.25;
            }
         }
         var curFrameAddSpeedX:Number = this.speed.x;
         var curFrameAddSpeedY:Number = this.speed.y;
         if(isBuffStun)
         {
            curFrameAddSpeedX = 0;
            curFrameAddSpeedY = 0;
         }
         if(this.isCanMoveByStage())
         {
            if(this.standInObj)
            {
               if(curFrameAddSpeedX == 0)
               {
                  if(this.standInObj is Wall)
                  {
                     this.speed.x = Wall(this.standInObj).speedX;
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
            }
            curFrameAddSpeedX *= speedReduceRate;
            this.x += curFrameAddSpeedX;
         }
         curFrameAddSpeedY *= speedReduceRate;
         if(gc.isInSea())
         {
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
         this.y += curFrameAddSpeedY;
         if(!isBuffStun)
         {
            this.speed.y += graityValue;
         }
         else
         {
            this.speed.y = graityValue;
         }
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      override public function isCanMoveByStage() : Boolean
      {
         if(gc.isSingleGame() || gc.sid == this.sid)
         {
            return super.isCanMoveByStage();
         }
         return true;
      }
      
      protected function myKeyDown(keyStr:String) : *
      {
         if(this.timers > 0)
         {
            this.timers--;
         }
      }
      
      override protected function setSpeed() : void
      {
         super.setSpeed();
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 1000)
         {
            if(this.roleProperies)
            {
               this.reduceHp(this.roleProperies.getSHHP(),false);
            }
         }
      }
      
      override protected function turnToGXP() : void
      {
         var shizhuang:* = null;
         var level:* = 0;
         var b:* = null;
         level = 0;
         b = null;
         level = 0;
         level = 0;
         b = null;
         b = null;
         level = 0;
         var bos:* = null;
         var totalHp:int = 0;
         this.isGXP = true;
         this.graity = 3.75;
         this.horizenSpeed *= 1.5;
         this.horizenRunSpeed *= 1.5;
         this.jumpPower *= 1.5;
         if(gc.isSingleGame())
         {
            shizhuang = this.getPlayer().getCurEquipByType("zbsz");
            if(shizhuang)
            {
               if(shizhuang.getFillName() == "yxnmwsz" || shizhuang.getFillName() == "jlnmwsz" || shizhuang.getFillName() == "ssnmwsz")
               {
                  level = uint(1);
                  if(shizhuang.getFillName() == "yxnmwsz")
                  {
                     level = uint(1);
                  }
                  else if(shizhuang.getFillName() == "jlnmwsz")
                  {
                     level = uint(2);
                  }
                  else if(shizhuang.getFillName() == "ssnmwsz")
                  {
                     level = uint(3);
                  }
                  b = new FollowBaseObjectBullet("PetMonkey1Bullet2");
                  if(this.getBBDC().getDirect() == 0)
                  {
                     b.x = this.x - 50;
                  }
                  else
                  {
                     b.x = this.x + 50;
                  }
                  b.y = this.y - 60;
                  b.setRole(this);
                  b.setDestroyWhenLastFrame(false);
                  b.setHurtCanCutDownEffect(false);
                  b.setDestroyInCount(gc.frameClips * 10);
                  b.setDirect(this.getBBDC().getDirect());
                  b.setAction("hitNiumowangSzBuff");
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
               }
               else if(shizhuang.getFillName() == "yxzlwsz" || shizhuang.getFillName() == "jlzlwsz" || shizhuang.getFillName() == "sszlwsz")
               {
                  level = uint(1);
                  if(shizhuang.getFillName() == "yxzlwsz")
                  {
                     level = uint(1);
                  }
                  else if(shizhuang.getFillName() == "jlzlwsz")
                  {
                     level = uint(2);
                  }
                  else if(shizhuang.getFillName() == "sszlwsz")
                  {
                     level = uint(3);
                  }
                  this.attackBackInfoDict["hitZhuanlunwangSzBuff"] = {
                     "hitMaxCount":100,
                     "attackBackSpeed":[0,0],
                     "attackInterval":999,
                     "attackKind":"magic",
                     "addEffect":[{
                        "name":BaseAddEffect.STUN,
                        "time":gc.frameClips * (2 + level)
                     }]
                  };
                  b = new FollowBaseObjectBullet("ZhuanLunWangSzEffect");
                  b.x = this.x;
                  b.y = this.y;
                  b.setRole(this);
                  b.setDirect(this.getBBDC().getDirect());
                  b.setAction("hitZhuanlunwangSzBuff");
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
               }
               else if(shizhuang.getFillName() == "yxsmsrsz" || shizhuang.getFillName() == "jlsmsrsz" || shizhuang.getFillName() == "sssmsrsz")
               {
                  level = uint(1);
                  if(shizhuang.getFillName() == "yxsmsrsz")
                  {
                     level = uint(1);
                  }
                  else if(shizhuang.getFillName() == "jlsmsrsz")
                  {
                     level = uint(2);
                  }
                  else if(shizhuang.getFillName() == "sssmsrsz")
                  {
                     level = uint(3);
                  }
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.SHENMISHANGRENSHIZHUANG,
                     "time":gc.frameClips * 10,
                     "hurt":this.roleProperies.getBasePower() * level / 4
                  }]);
               }
               else if(shizhuang.getFillName() == "yxttzssz" || shizhuang.getFillName() == "jlttzssz" || shizhuang.getFillName() == "ssttzssz")
               {
                  level = uint(1);
                  if(shizhuang.getFillName() == "yxttzssz")
                  {
                     level = uint(1);
                  }
                  else if(shizhuang.getFillName() == "jlttzssz")
                  {
                     level = uint(2);
                  }
                  else if(shizhuang.getFillName() == "ssttzssz")
                  {
                     level = uint(3);
                  }
                  this.attackBackInfoDict["hitTiantingZhanshenSzBuff"] = {
                     "hitMaxCount":100,
                     "attackBackSpeed":[0,0],
                     "attackInterval":999,
                     "attackKind":"magic",
                     "addEffect":[{
                        "name":BaseAddEffect.TIANTINGZHANSHEN,
                        "time":gc.frameClips * (level * 2)
                     }]
                  };
                  b = new FollowBaseObjectBullet("tiantingzhanshenBullet1_1");
                  if(this.getBBDC().getDirect() == 0)
                  {
                     b.x = this.x;
                  }
                  else
                  {
                     b.x = this.x;
                  }
                  b.y = this.y;
                  b.setRole(this);
                  b.setHurtCanCutDownEffect(false);
                  b.setDirect(this.getBBDC().getDirect());
                  b.setAction("hitTiantingZhanshenSzBuff");
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
                  b = new FollowBaseObjectBullet("tiantingzhanshenBullet1_2");
                  if(this.getBBDC().getDirect() == 0)
                  {
                     b.x = this.x;
                  }
                  else
                  {
                     b.x = this.x;
                  }
                  b.y = this.y;
                  b.setRole(this);
                  b.setHurtCanCutDownEffect(false);
                  b.setDirect(this.getBBDC().getDirect());
                  b.setAction("hitTiantingZhanshenSzBuff");
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
               }
               else if(shizhuang.getFillName() == "sszqsz" || shizhuang.getFillName() == "yxzqsz" || shizhuang.getFillName() == "jlzqsz")
               {
                  level = uint(1);
                  if(shizhuang.getFillName() == "yxzqsz")
                  {
                     level = uint(1);
                  }
                  else if(shizhuang.getFillName() == "jlzqsz")
                  {
                     level = uint(2);
                  }
                  else if(shizhuang.getFillName() == "sszqsz")
                  {
                     level = uint(3);
                  }
                  bos = gc.getPlayerAndPetAndSummonArray();
                  for each(var bo in bos)
                  {
                     totalHp = 10;
                     if(bo is BaseHero)
                     {
                        totalHp = (bo as BaseHero).roleProperies.getSHHP() / 10;
                     }
                     else if(bo is BasePet)
                     {
                        totalHp = (bo as BasePet).sHp / 10;
                     }
                     else if(bo is BaseSummon)
                     {
                        totalHp = (bo as BaseSummon).getShp() / 10;
                     }
                     bo.addCurAddEffect([{
                        "name":BaseAddEffect.MID_BUFF,
                        "time":level * 5 * gc.frameClips,
                        "value":totalHp
                     }]);
                  }
               }
            }
         }
      }
      
      override public function isDead() : Boolean
      {
         var mutiUser:* = null;
         if(this.player)
         {
            if(this.roleProperies)
            {
               return this.roleProperies.getHHP() <= 0;
            }
            return true;
         }
         mutiUser = gc.getMutiUserBySidAndRoleId(this.sid,this.getRoleId());
         if(mutiUser)
         {
            return mutiUser.hp <= 0;
         }
         return true;
      }
      
      override public function setStatic() : void
      {
         super.setStatic();
         this.doubleCount = 0;
      }
      
      public function setSpeedStaticOnly() : void
      {
         super.setStatic();
      }
      
      protected function turnToNormal() : void
      {
         this.graity = 1.5;
         this.horizenSpeed /= 1.5;
         this.horizenRunSpeed /= 1.5;
         this.jumpPower /= 1.5;
      }
      
      public function checkTransferDoor() : Boolean
      {
         var i:int = 0;
         var mc:* = null;
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(i = 0; i < ta.length; )
         {
            mc = ta[i] as MovieClip;
            if(mc.hitTestObject(this.colipse) && mc.visible)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function setCurPower() : void
      {
      }
      
      override public function isNormalHit() : Boolean
      {
         return true;
      }
      
      public function setCurClothId(v:int) : void
      {
         this._anti.curClothId = v;
      }
      
      public function getCurClothId() : int
      {
         return this._anti.curClothId;
      }
      
      public function setCurWeaponId(v:int) : void
      {
         this._anti.curWeaponId = v;
      }
      
      public function getCurWeaponId() : int
      {
         return this._anti.curWeaponId;
      }
      
      override public function getRoleId() : uint
      {
         if(this.getPlayer())
         {
            return this.getPlayer().roleid;
         }
         return this.roleId;
      }
      
      public function setRoleId(r:uint) : void
      {
         this.roleId = r;
      }
      
      public function setSummon(s:BaseSummon) : void
      {
         this.summon = s;
      }
      
      public function getSummon() : BaseSummon
      {
         return this.summon;
      }
      
      public function clearSummon() : void
      {
         if(this.summon)
         {
            this.summon.destroy();
            this.summon = null;
         }
      }
      
      public function clearAllBullets() : void
      {
         var i:int = 0;
         var bb:* = null;
         for(i = 0; i < this.magicBulletArray.length; )
         {
            bb = this.magicBulletArray[i] as BaseBullet;
            bb.setDisable();
            TweenMax.killChildTweensOf(bb);
            bb.destroy();
            i++;
         }
         this.magicBulletArray = [];
      }
      
      public function getServerSaveInfo() : String
      {
         var str:String = "";
         return str + this.roleProperies.getLevel();
      }
      
      public function destroy() : void
      {
         trace("---destroy---");
         this.removeEquipLoading();
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         if(this.allianceBitmap)
         {
            if(this.allianceBitmap.parent)
            {
               this.allianceBitmap.parent.removeChild(this.allianceBitmap);
            }
            this.allianceBitmap = null;
         }
         if(this.isGXP)
         {
            this.isGXP = false;
            this.turnToNormal();
         }
         if(this.getPlayer())
         {
            if(gc.keyboardControl)
            {
               this.keyarray = gc.keyboardControl.getZeroKeyArray();
            }
         }
         if(this.roleProperies)
         {
            this.roleProperies.destroy();
         }
         this.clearSummon();
         this.resetGraity();
         this.setStatic();
         this.speed.y = 0;
         this.doubleCount = 0;
         this.lastKey = {};
         this.lasttime = 0;
         this.lastUpTime = 0;
         this.lastDirbtn = 0;
         this.fatherCount = 0;
         if(this.curAddEffect)
         {
            this.curAddEffect.destroy();
            this.curAddEffect = null;
         }
         this.beAttackIdArray = [];
         this.clearAllBullets();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.isReadyToDestroy = true;
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.destroy();
            this.curMagicWeapon = null;
         }
         if(this.getPet())
         {
            this.getPet().destroy();
            this.myPet = null;
         }
         this.comboKeyArray.length = 0;
      }
      
      protected function loadEquipAndWeapon() : void
      {
         PlayerAssetsLoaderManager.getInstance().add(this.getBodyEquipAssetsName() + ".swf",this.getWeaponAssetsName() + ".swf");
      }
      
      protected function getBodyEquipAssetsName() : String
      {
         return "";
      }
      
      protected function getWeaponAssetsName() : String
      {
         return "";
      }
      
      public function refreshEquip() : void
      {
         var child:* = undefined;
         var txname:* = null;
         var img:* = undefined;
         var curW:int = 0;
         if(this.player)
         {
            child = this.getChildByName("Role_Title");
            if(child)
            {
               this.removeChild(child);
            }
            if(gc.isSingleGame())
            {
               txname = this.player.getEquipNum().zbtx;
               if(txname != "")
               {
                  img = AUtils.getImageObj("role_title_" + txname);
                  img.x = -img.width / 2;
                  img.y = -90;
                  img.name = "Role_Title";
                  this.addChild(img);
                  if(txname == "_ssggjtg")
                  {
                     if(this.getRoleId() == 4)
                     {
                        curW = this.getCurWeaponId();
                        if(curW == 4 || curW == 5 || curW == 7 || curW == 8 || curW == 9)
                        {
                           this.setCurClothId(0);
                           this.setCurWeaponId(5);
                        }
                        else
                        {
                           this.setCurClothId(0);
                           this.setCurWeaponId(0);
                        }
                     }
                     else
                     {
                        this.setCurClothId(0);
                        this.setCurWeaponId(0);
                     }
                  }
               }
            }
         }
      }
      
      public function changeEquip(obj:Object) : void
      {
         this.setCurClothId(obj.zbfj);
         this.setCurWeaponId(obj.zbwq);
         this.refreshEquip();
         this.refreshAlliance();
         this.checkMeiguiBuffWhenChangeEquipAndChangePet();
      }
      
      public function checkMeiguiBuffWhenChangeEquipAndChangePet() : void
      {
         var equip:* = null;
         var o:* = null;
         o = null;
         var meiguiFlag:Boolean = false;
         var recoverValue:uint = 20;
         if(this.player)
         {
            equip = this.player.getCurEquipByType("zbwq");
            if(equip)
            {
               if(equip.getFillName() == "jlqrzr" || equip.getFillName() == "jlqrmj" || equip.getFillName() == "jlqrcs" || equip.getFillName() == "jlqrhd")
               {
                  if(this.getPet() && !this.getPet().isDead())
                  {
                     meiguiFlag = true;
                  }
               }
               else if(equip.getFillName() == "ssqrzr" || equip.getFillName() == "ssqrmj" || equip.getFillName() == "ssqrcs" || equip.getFillName() == "ssqrhd")
               {
                  if(this.getPet() && !this.getPet().isDead())
                  {
                     meiguiFlag = true;
                     recoverValue = 40;
                  }
               }
            }
         }
         if(meiguiFlag)
         {
            if(this.curAddEffect)
            {
               this.curAddEffect.add([{
                  "name":BaseAddEffect.MEIGUI_BUFF,
                  "value":recoverValue,
                  "isForever":1
               }]);
            }
            if(this.getPet().curAddEffect)
            {
               this.getPet().curAddEffect.add([{
                  "name":BaseAddEffect.MEIGUI_BUFF,
                  "value":recoverValue,
                  "isForever":1
               }]);
            }
         }
         else
         {
            if(this.curAddEffect)
            {
               o = this.curAddEffect.getBuffByName(BaseAddEffect.MEIGUI_BUFF);
               if(o)
               {
                  this.curAddEffect.remove(o);
               }
            }
            if(this.getPet())
            {
               if(this.getPet().curAddEffect)
               {
                  o = this.getPet().curAddEffect.getBuffByName(BaseAddEffect.MEIGUI_BUFF);
                  if(o)
                  {
                     this.getPet().curAddEffect.remove(o);
                  }
               }
            }
         }
      }
      
      public function changePet() : void
      {
         if(this.getPet())
         {
            this.getPet().destroy();
         }
         this.initPet();
      }
      
      public function changeMagicWeapon() : void
      {
         if(this.getCurMagicWeapon())
         {
            this.getCurMagicWeapon().destroy();
         }
         this.initMagicWeapon();
      }
      
      protected function beAttackByRole2Hit7(p:Point) : void
      {
         p = p;
         this.resetGraity();
         TweenMax.to(this,0.625,{
            "x":p.x,
            "y":p.y - 30,
            "onComplete":function(_bo:BaseObject):*
            {
               _bo = _bo;
               if(!_bo.isDead())
               {
                  TweenMax.to(_bo,0.625,{
                     "y":_bo.y - 20,
                     "onComplete":function(__bo:BaseObject):*
                     {
                        if(!__bo.isDead())
                        {
                           __bo.speed.y = 0;
                        }
                     },
                     "onCompleteParams":[_bo]
                  });
               }
            },
            "onCompleteParams":[this]
         });
      }
      
      protected function beAttackByRole3Hit6(p:Point) : void
      {
         p = p;
         this.resetGraity();
         TweenMax.to(this,1,{
            "x":p.x,
            "y":p.y,
            "onComplete":function(__bo:BaseObject):*
            {
               if(!__bo.isDead())
               {
                  __bo.speed.y = 0;
               }
            },
            "onCompleteParams":[this]
         });
      }
      
      public function turnToWushuang() : void
      {
         this.turnToGXP();
      }
      
      public function WushuangOver() : void
      {
         this.isGXP = false;
         this.turnToNormal();
      }
      
      public function fabaoJiasu() : void
      {
         if(this.isFabaoJiasu)
         {
            return;
         }
         this.isFabaoJiasu = true;
         this.horizenSpeed *= 2;
         this.horizenRunSpeed *= 2;
         var jiasuBuff:MovieClip = AUtils.getNewObj("shenxingBuff") as MovieClip;
         jiasuBuff.name = "shenxingBuff";
         jiasuBuff.x = 15;
         jiasuBuff.y = 30;
         this.addChild(jiasuBuff);
      }
      
      public function resetFabaoJiasu() : void
      {
         if(!this.isFabaoJiasu)
         {
            return;
         }
         this.isFabaoJiasu = false;
         this.horizenSpeed /= 2;
         this.horizenRunSpeed /= 2;
         var jiasuBuff:MovieClip = this.getChildByName("shenxingBuff") as MovieClip;
         if(jiasuBuff)
         {
            this.removeChild(jiasuBuff);
         }
      }
      
      public function isPlayer3() : Boolean
      {
         if(!this.getPlayer())
         {
            return false;
         }
         return this.getPlayer() == gc.player3;
      }
   }
}
