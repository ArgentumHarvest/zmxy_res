package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import export.hero.Role2Shadow;
   import export.rank.RankUser;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import loader.PlayerAssetsLoaderManager;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   
   public class Monster122 extends BaseMonster
   {
       
      
      public var role2Shalldow:Role2Shadow;
      
      private var _equipId:uint = 0;
      
      private var _weaponId:uint = 0;
      
      private var gxpCount:uint = 0;
      
      private var curSkillArray:Array;
      
      private var skillKind:uint = 0;
      
      private var skillKindArray:Array;
      
      public var fightingScoreDiff:Number = 0.1;
      
      private var mm:MusicManager;
      
      private var shallowCount:uint = 4;
      
      public function Monster122(ru:RankUser)
      {
         var eq:* = null;
         curSkillArray = [];
         skillKindArray = [["hit4_1","hit7"],["hit10"]];
         var equipId:uint = 1;
         var weaponId:uint = 1;
         var equipArray:Array = ru.curEquipArray;
         for each(eq in equipArray)
         {
            if(eq.type == "zbwq")
            {
               weaponId = eq.showid;
            }
            else if(eq.type == "zbfj")
            {
               equipId = eq.showid;
            }
         }
         for each(eq in equipArray)
         {
            if(eq.type == "zbsz")
            {
               equipId = eq.showid;
               break;
            }
         }
         this._equipId = equipId;
         this._weaponId = weaponId;
         super();
         mm = MusicManager.getInstance();
         this.horizenSpeed = 5;
         this.setHp(ru.getHp());
         this.setSHp(this.getHp());
         this.setMiss(ru.getMiss() / 100);
         this.setCrit(ru.getCrit() / 100);
         this.setEatBlood(ru.getEatBlood() / 100);
         this._anti.def = ru.getDefense();
         this._anti.mDef = ru.getMagicDef() / 100;
         var baseHurt:uint = ru.getAtk();
         this.attackRange = 250;
         this.alertRange = 1000;
         this.normalAttackRate = 0;
         this.gxpCount = gc.frameClips * 10;
         this._anti.exp = 0;
         this._anti.gxp = 0;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":12,
            "attackBackSpeed":[-2,-3],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-10,-1],
            "attackInterval":4,
            "power":baseHurt * 0.3,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-7,-4],
            "attackInterval":999,
            "power":baseHurt * 0.8,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-3],
            "attackInterval":999,
            "power":baseHurt * 13,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-15,-2],
            "attackInterval":48,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-25],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":4,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":3,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":5,
            "power":baseHurt * 1,
            "attackKind":"magic"
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 2,gc.frameClips * 3];
         var ttf:TextFormat = new TextFormat();
         ttf.size = 20;
         nameTextField.defaultTextFormat = ttf;
         nameTextField.y = -this.colipse.height / 2 - 30;
         nameTextField.x = -this.colipse.width / 2 - 30;
         nameTextField.selectable = false;
         nameTextField.autoSize = "center";
         nameTextField.cacheAsBitmap = true;
         nameTextField.text = ru.getUserName();
         this.addChild(nameTextField);
         this.skillKind = RandomControllor.getIns().getRandom() * this.skillKindArray.length;
         this.curSkillArray = this.skillKindArray[this.skillKind] as Array;
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override protected function initBBDC() : void
      {
         var assetsArray:* = null;
         if(!bbdc)
         {
            bbdc = new BaseBitmapDataClip(this.getAssetsArray("ROLE2"),200,200,new Point(0,0));
            bbdc.setOffsetXY(15,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,14],[4,4,4,4],[2,2,2,2],[1,1,30,55,8],[2,2,2,2,2],[2,4,12],[2,10,2,40],[2,2],[2,2,6],[48,2,15],[2,2,20],[2,2,10]]);
            bbdc.setFrameCount([36,4,4,4,[1,1,1,1,1,1],5,3,4,24,3,3,3,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
         }
         else
         {
            assetsArray = this.getAssetsArray("ROLE2");
            for each(var obj in assetsArray)
            {
               if(obj.name == "body")
               {
                  this.bbdc.replaceBitmapDataByName("body",obj.source);
               }
               else if(obj.name == "equip")
               {
                  this.bbdc.replaceBitmapDataByName("equip",obj.source);
               }
            }
         }
      }
      
      protected function getAssetsArray(roleName:String) : Array
      {
         var equipName:* = null;
         var weaponName:* = null;
         var body:* = null;
         var equip:* = null;
         var bodyId:uint = this._equipId;
         var weaponId:uint = this._weaponId;
         var assetsArray:Array = [];
         equipName = roleName + "_" + bodyId;
         weaponName = roleName + "_EQUIP_" + weaponId;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(equipName);
         var eqArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(weaponName);
         if(!bmdArray)
         {
            body = {
               "name":"body",
               "source":[]
            };
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
         this.initBBDC();
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         str = str;
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "wait2":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               this.setAction("run");
               break;
            case "run":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "jump1":
               if(curPoint.x != 0 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "jump2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "jump3":
               if(curPoint.x != 1 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit4_1":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit4_2":
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(curPoint.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(curPoint.x != 0 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit8":
               if(curPoint.x != 2 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit9":
               if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               this.doHit10(this.getBBDC().getDirect(),new Point(this.x,this.y - 10));
               break;
            case "hurt":
               if(curPoint.x == 4 && curPoint.y == 4)
               {
                  this.getBBDC().resetCurFrameStopCount();
               }
               else
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
               TweenMax.to(this,1,{
                  "alpha":0,
                  "onComplete":function(_self:BaseMonster):*
                  {
                     _self.dropAura();
                     _self.destroy();
                  },
                  "onCompleteParams":[this]
               });
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         row = row;
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "jump1":
               this.bbdc.setFramePointX(0);
               break;
            case "jump2":
               this.setAction("jump3");
               break;
            case "jump3":
               this.bbdc.setFramePointX(1);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit3":
               this.resetGraity();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit4_1":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit4_2":
               if(RandomControllor.getIns().getRandom() < 0.5)
               {
                  this.faceToTarget();
                  this.setAction("hit7");
                  this.lastHit = "hit7";
               }
               else if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               if(this.skillKind == 0)
               {
                  if(RandomControllor.getIns().getRandom() < 0.5)
                  {
                     this.faceToTarget();
                     this.setAction("hit7");
                     this.lastHit = "hit7";
                  }
                  else if(!this.isInSky())
                  {
                     this.setAction("wait");
                  }
                  else
                  {
                     this.setAction("jump3");
                  }
               }
               else if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit7":
               if(this.skillKind == 0)
               {
                  this.faceToTarget();
                  this.setAction("hit4_1");
                  this.lastHit = "hit4_1";
                  TweenMax.delayedCall(0.5,function(_self:Monster122):*
                  {
                     _self.setAction("hit4_2");
                  },[this]);
               }
               else
               {
                  this.setStatic();
                  if(!this.isInSky())
                  {
                     this.setAction("wait");
                  }
                  else
                  {
                     this.setAction("jump3");
                  }
               }
               break;
            case "hit8":
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit9":
               this.resetGraity();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hurt":
               this.resetGraity();
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(this.bbdc.getCurFrameCount() == 12)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 50;
                     }
                     else
                     {
                        point.x = this.x + 50;
                     }
                     point.y = this.y + 10;
                     if(RandomControllor.getIns().getRandom() <= 0.5)
                     {
                        this.doHit2(this.getBBDC().getDirect(),point);
                     }
                     else
                     {
                        this.doHit1(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               break;
            case "hit3":
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x;
                     }
                     else
                     {
                        point.x = this.x;
                     }
                     point.y = this.y + 10;
                     this.doHit3(this.getBBDC().getDirect(),point);
                  }
               }
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() >= 20 && this.bbdc.getCurFrameCount() % 8 == 0)
                  {
                     gc.vControllor.shake(25);
                  }
               }
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit1");
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit4_1":
               this.speed.y = -4;
               break;
            case "hit4_2":
               if(this.bbdc.getCurFrameCount() == 6)
               {
                  if(p.x == 2)
                  {
                     this.doHit4_2(this.getBBDC().getDirect(),point);
                  }
               }
               this.speed.y = 0;
               break;
            case "hit5":
               if(this.bbdc.getCurFrameCount() == 15)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 175;
                     }
                     else
                     {
                        point.x = this.x + 175;
                     }
                     point.y = this.y - 110;
                     this.doHit5(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit6":
               if(this.bbdc.getCurFrameCount() == 20)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x;
                     }
                     else
                     {
                        point.x = this.x;
                     }
                     point.y = this.y - 25;
                     this.doHit6(this.getBBDC().getDirect(),point);
                  }
               }
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit2");
                     }
                  }
               }
               break;
            case "hit7":
               if(this.bbdc.getCurFrameCount() == 10)
               {
                  if(p.x == 2)
                  {
                     if(this.getBBDC().getDirect() == 0)
                     {
                        point.x = this.x - 210;
                     }
                     else
                     {
                        point.x = this.x + 210;
                     }
                     point.y = this.y + 30;
                     this.doHit7(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit8":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x + 5;
                     }
                     else
                     {
                        point.x = this.x - 5;
                     }
                     point.y = this.y - 60;
                     this.doHit8(this.getBBDC().getDirect(),point);
                  }
               }
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit3");
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit9":
               if(this.bbdc.getCurFrameCount() == 55)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 20;
                     }
                     else
                     {
                        point.x = this.x + 20;
                     }
                     point.y = this.y - 20;
                     this.doHit9_1(this.getBBDC().getDirect(),point);
                  }
               }
               else if(this.bbdc.getCurFrameCount() == 45)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 150;
                     }
                     else
                     {
                        point.x = this.x + 150;
                     }
                     point.y = this.y - 150;
                     this.doHit9_2(this.getBBDC().getDirect(),point);
                  }
               }
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 55)
                  {
                     if(this.role2Shalldow)
                     {
                        this.role2Shalldow.setAction("hit4");
                     }
                  }
               }
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit1");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit2");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit3(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit3");
         this.setStatic();
         this.setLostGraity();
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet3");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setHurtCanCutDownEffect(false);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_2(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role2_hit4");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet4_2");
         if(this.curAttackTarget)
         {
            b.x = this.curAttackTarget.x;
         }
         else
         {
            b.x = this.x;
         }
         b.y = 100;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(0.75,function(_self:Monster122):*
         {
            _self.resetGraity();
            gc.vControllor.shake(20);
         },[this]);
      }
      
      private function doHit5(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit5");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit6(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role2_hit6");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit6");
         var idx:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(0.9,function(_b:BaseBullet, _self:Monster122):*
         {
            var playerArray:Array = gc.getPlayerArray();
            if(AUtils.GetDisBetweenTwoObj(_self,_b) < 100)
            {
               _self.addCurAddEffect([{
                  "name":BaseAddEffect.SLOWLY_ADDHP,
                  "value":0.5 * _self.getRealPower("hit6"),
                  "time":10 * gc.frameClips
               }]);
            }
         },[b,this]);
      }
      
      private function doHit7(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role2_hit7");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet7");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var hit7Point:Point = new Point();
         if(direct == 0)
         {
            hit7Point.x = this.x - 200;
         }
         else
         {
            hit7Point.x = this.x + 200;
         }
         hit7Point.y = this.y - 20;
         if(hit7Point.y < 100)
         {
            hit7Point.y = 100;
         }
         var bmLen:uint = gc.getPlayerAndPetArray().length;
         for(var i:uint = 0; i < bmLen; )
         {
            var bo:BaseObject = gc.getPlayerAndPetArray()[i] as BaseObject;
            if(AUtils.GetDisBetweenTwoObj(b,bo) <= 240)
            {
               bo.setLostGraity();
               TweenMax.to(bo,0.625,{
                  "x":hit7Point.x,
                  "y":hit7Point.y - 30,
                  "onComplete":function(_bo:BaseObject):*
                  {
                     _bo.resetGraity();
                     if(!_bo.isDead())
                     {
                        TweenMax.to(_bo,0.625,{
                           "x":_bo.x,
                           "y":_bo.y - 10
                        });
                     }
                  },
                  "onCompleteParams":[bo]
               });
            }
            i++;
         }
      }
      
      public function doHit8(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role2_hit8");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet8");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit8");
         var idx:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(1.2,function(_b:SpecialEffectBullet, _self:Monster122):*
         {
            var cureValue:* = 0;
            if(AUtils.GetDisBetweenTwoObj(_self,b) <= 150)
            {
               cureValue = uint(3 * _self.getRealPower("hit8"));
               if(_self.isGXP)
               {
                  cureValue *= 1.5;
               }
               _self.cureHp(cureValue);
            }
         },[b,this]);
      }
      
      public function doHit9_1(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit9");
         this.setLostGraity();
         this.setStatic();
         this.speed.y = 0;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet9_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setHurtCanCutDownEffect(true);
         b.setDirect(direct);
         b.setAction("hit9_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit9_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet9_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setHurtCanCutDownEffect(true);
         b.setDirect(direct);
         b.setAction("hit9_2");
         gc.gameSence.addChild(b);
         var idx:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10(direct:uint, point:Point) : void
      {
         mm.play("Role2_hit10");
         if(!this.role2Shalldow)
         {
            this.role2Shalldow = new Role2Shadow(this);
            this.role2Shalldow.x = point.x;
            this.role2Shalldow.y = point.y;
            this.role2Shalldow.setDirect(direct);
            gc.gameSence.addChild(this.role2Shalldow);
         }
         else
         {
            this.x = this.role2Shalldow.x;
            this.y = this.role2Shalldow.y;
            this.role2Shalldow.destroy();
            this.role2Shalldow = null;
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         var tempArray:Array = this.curSkillArray.concat();
         if(this.skillKind == 0)
         {
            if(this.getHp() <= this.getSHp() * 0.6)
            {
               tempArray.push("hit6");
            }
         }
         else if(this.skillKind == 1)
         {
            if(this.getHp() <= this.getSHp() * 0.6)
            {
               tempArray.push("hit8");
            }
         }
         if(this.role2Shalldow)
         {
            if(RandomControllor.getIns().getRandom() < 0.5)
            {
               if(tempArray.indexOf("hit3"))
               {
                  tempArray = ["hit3"];
               }
            }
            else if(tempArray.indexOf("hit9"))
            {
               tempArray = ["hit9"];
            }
         }
         trace("tempArray:" + tempArray);
         var randSkil:String = tempArray[int(RandomControllor.getIns().getRandom() * tempArray.length)];
         trace("释放技能：" + randSkil);
         this.faceToTarget();
         this.setYourFather(10);
         this.setAction(randSkil);
         this.lastHit = randSkil;
         if(randSkil == "hit4_1")
         {
            TweenMax.delayedCall(0.5,function(_self:Monster122):*
            {
               _self.setAction("hit4_2");
            },[this]);
         }
         if(randSkil == "hit10")
         {
            this.skillCD1[1] = gc.frameClips;
         }
         else
         {
            this.skillCD1[1] = gc.frameClips * 3;
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(this.isGXP)
         {
            if(this.shallowCount > 0)
            {
               this.shallowCount--;
            }
            if(this.shallowCount == 0)
            {
               AUtils.shallowEffect(this);
               this.shallowCount = 4;
            }
         }
         if(this.role2Shalldow)
         {
            this.role2Shalldow.step();
         }
         if(this.gxpCount > 0)
         {
            this.gxpCount--;
            if(this.gxpCount == 0)
            {
               this.turnToGXP();
               this.gxpCount = gc.frameClips * 20;
               TweenMax.delayedCall(10,function(_self:Monster122):*
               {
                  _self.turnToNormal();
               },[this]);
            }
         }
         if(this.curAction == "run")
         {
            this.horizenSpeed = 10;
         }
         else
         {
            this.horizenSpeed = 5;
         }
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function doWhenSetYourFatherByFatherCount() : void
      {
         this.faceToTarget();
         if(this.skillKind == 0)
         {
            this.setAction("hit6");
            this.lastHit = "hit6";
         }
         else
         {
            this.setAction("hit8");
            this.lastHit = "hit8";
         }
      }
      
      override protected function move() : void
      {
         if(this.isCanMoveByStage())
         {
            super.move();
         }
      }
      
      override protected function turnToGXP() : void
      {
         this.isGXP = true;
         this.graity = 3.75;
         this.horizenSpeed *= 1.5;
      }
      
      protected function turnToNormal() : void
      {
         this.isGXP = false;
         this.graity = 1.5;
         this.horizenSpeed /= 1.5;
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!this.isGXP)
         {
            super.setAttackBack(p);
         }
      }
      
      override public function cureHp(addHp:int) : void
      {
         if(gc.isInWeiPk())
         {
            addHp *= 1.2 - this.fightingScoreDiff;
            if(addHp < 1)
            {
               addHp = 1;
            }
         }
         super.cureHp(addHp);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(gc.isInWeiPk())
         {
            re *= this.fightingScoreDiff;
            if(re < 1)
            {
               re = 1;
            }
         }
         if(this.isGXP)
         {
            canHurt = false;
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit8";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit8" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit13";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.role2Shalldow)
         {
            this.role2Shalldow.destroy();
            this.role2Shalldow = null;
         }
      }
   }
}
