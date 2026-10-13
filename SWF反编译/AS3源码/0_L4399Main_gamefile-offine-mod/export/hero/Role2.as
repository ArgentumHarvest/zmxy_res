package export.hero
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.HeroSkillProtect;
   import event.CommonEvent;
   import export.RoleInfo;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.monster.Monster102;
   import export.monster.Monster104;
   import export.monster.Monster108;
   import export.monster.Monster153;
   import export.monster.Monster154;
   import export.monster.Monster48;
   import export.monster.Monster49;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import export.monster.Monster52;
   import export.monster.Monster61;
   import export.monster.Monster66;
   import export.monster.Monster67;
   import export.monster.Monster68;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.ANumber;
   import my.ExceedPower;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class Role2 extends BaseHero
   {
       
      
      private var hit11Count:uint = 35;
      
      private var hit2NeedCount:uint = 48;
      
      private var hit2CurrentCount:uint = 0;
      
      private var hit5NeedCount:uint = 48;
      
      private var hit5CurrentCount:uint = 0;
      
      private var hit4_2Point:Point;
      
      public var role2Shalldow:Role2Shadow;
      
      private var isHit7Ok:Boolean = false;
      
      private var mm:MusicManager;
      
      public function Role2()
      {
         hit4_2Point = new Point(-99,-99);
         super();
         mm = MusicManager.getInstance();
         roleName = "唐僧";
         userType = "唐僧";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[-2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-10,-1],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-7,-4],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-3],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-15,-2],
            "attackInterval":48,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-25],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":3,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-2],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.exceedPowerSprite = new ExceedPower(this.colipse.width,9,hit2NeedCount);
         this.exceedPowerSprite.x = this.x - this.colipse.width / 2;
         this.exceedPowerSprite.y = this.y - this.colipse.height / 2 - 20;
         this.addChild(this.exceedPowerSprite);
         nameTextField.y = -this.colipse.height / 2 - 20;
         nameTextField.x = -this.colipse.width / 2 - 30;
         nameTextField.selectable = false;
         nameTextField.autoSize = "center";
         nameTextField.cacheAsBitmap = true;
         this.addChild(nameTextField);
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
            this.bbdc.turnRight();
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
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function getBodyEquipAssetsName() : String
      {
         return "ROLE2_" + this.getCurClothId();
      }
      
      override protected function getWeaponAssetsName() : String
      {
         return "ROLE2_EQUIP_" + this.getCurWeaponId();
      }
      
      override public function setAction(str:String) : void
      {
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
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
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
               for each(var bb in this.magicBulletArray)
               {
                  if(bb.name == "Role1Bullet4_1")
                  {
                     bb.destroy();
                  }
               }
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
            case "hurt":
               this.hit5CurrentCount = 0;
               this.hit2CurrentCount = 0;
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
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
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
               if(!this.isInSky())
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
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit7":
               this.setStatic();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
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
         var initTimer:* = 0;
         var flag:Boolean = false;
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(p.x == 1)
                  {
                     if(this.getPlayer())
                     {
                        if(this.getPlayer().findSkillIsInTheSkillAry("blb"))
                        {
                           if(this.roleProperies.getMMP() >= 20 && this.keyarray[1] == 1)
                           {
                              this.hit2CurrentCount++;
                              this.bbdc.resetCurFrameStopCount();
                           }
                           else
                           {
                              this.bbdc.setFramePointX(2);
                              this.bbdc.resetCurFrameStopCount();
                           }
                        }
                        else
                        {
                           this.bbdc.setFramePointX(2);
                           this.bbdc.resetCurFrameStopCount();
                        }
                     }
                  }
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
                        if(this.hit2NeedCount <= this.hit2CurrentCount)
                        {
                           this.doHit2(this.getBBDC().getDirect(),point);
                           if(gc.sid == this.sid)
                           {
                              gc.sendAttack(this.getRoleId(),"hit2",this.getBBDC().getDirect(),point.x,point.y,[]);
                           }
                           this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - 20]));
                        }
                        else
                        {
                           initTimer = uint(getTimer());
                           this.doHit1(this.getBBDC().getDirect(),point,initTimer);
                           if(gc.sid == this.sid)
                           {
                              gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[],initTimer);
                           }
                        }
                        this.hit2CurrentCount = 0;
                     }
                  }
               }
               else if(p.x == 1)
               {
                  this.bbdc.resetCurFrameStopCount();
               }
               break;
            case "hit3":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
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
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  if(p.x == 3)
                  {
                     if(this.bbdc.getCurFrameCount() >= 20 && this.bbdc.getCurFrameCount() % 8 == 0)
                     {
                        gc.vControllor.shake(25);
                     }
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
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  flag = false;
                  for each(var bb in this.magicBulletArray)
                  {
                     if(bb.name == "Role1Bullet4_1")
                     {
                        this.hit4_2Point.x = bb.x;
                        this.hit4_2Point.y = bb.y;
                        flag = true;
                        break;
                     }
                  }
                  if(!flag && this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 130;
                        }
                        else
                        {
                           point.x = this.x + 130;
                        }
                        point.y = this.y + 10;
                        this.doHit4_1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit4_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               this.speed.y = -4;
               break;
            case "hit4_2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 6)
                  {
                     if(p.x == 2)
                     {
                        point.x = this.hit4_2Point.x;
                        point.y = this.hit4_2Point.y - 320;
                        this.doHit4_2(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit4_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit5":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(p.x == 0)
                  {
                     this.hit5CurrentCount++;
                  }
                  if(this.bbdc.getCurFrameCount() == 15)
                  {
                     if(p.x == 2)
                     {
                        hit5CurrentCount = 0;
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
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit6":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
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
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
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
               this.speed.y = 0;
               break;
            case "hit7":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
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
               }
               break;
            case "hit8":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(p.x == 2)
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
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
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
               if(gc.sid == this.sid || gc.isSingleGame())
               {
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
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
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
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               this.speed.y = 0;
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
      
      private function doHit1(direct:uint, p:Point, initTimer:uint) : void
      {
         mm.play("Role2_hit1");
         if(this.sid != gc.sid)
         {
            this.bbdc.setFramePointX(2);
            this.bbdc.resetCurFrameStopCount();
         }
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.initTimer = initTimer;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit2");
         if(this.sid != gc.sid)
         {
            this.bbdc.setFramePointX(2);
            this.bbdc.resetCurFrameStopCount();
         }
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
      
      private function doHit4_1(direct:uint, p:Point) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Role2Bullet4_1");
         var child:MovieClip = b.getChildAt(0) as MovieClip;
         if(child)
         {
            child.x = -child.width / 2;
         }
         b.name = "Role1Bullet4_1";
         b.x = p.x;
         b.y = p.y;
         if(direct == 0)
         {
            b.setSpeed(-10);
         }
         else
         {
            b.setSpeed(10);
         }
         b.setDistance(9999);
         b.setHurtCanCutDownEffect(true);
         b.setRole(this);
         b.setDisable();
         b.setDirect(0);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_2(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role2_hit4");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet4_2");
         if(direct == 0)
         {
            b.x = p.x - 30;
         }
         else
         {
            b.x = p.x + 30;
         }
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(0.75,function(_self:Role2):*
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
         TweenMax.delayedCall(0.9,function(_b:BaseBullet, _self:Role2):*
         {
            var playerArray:Array = gc.getPlayerArray();
            for each(var bh in playerArray)
            {
               if(AUtils.GetDisBetweenTwoObj(bh,_b) < 100)
               {
                  bh.addCurAddEffect([{
                     "name":BaseAddEffect.SLOWLY_ADDHP,
                     "value":0.25 * _self.roleProperies.getHurt(),
                     "time":10 * gc.frameClips
                  }]);
               }
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
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            var hit7Point:Point = new Point();
            if(direct == 0)
            {
               hit7Point.x = this.x - 200;
            }
            else
            {
               hit7Point.x = this.x + 200;
            }
            hit7Point.y = this.y - 70;
            if(gc.isInWeiPk() || gc.isInPk())
            {
               if(hit7Point.y < 100)
               {
                  hit7Point.y = 100;
               }
            }
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit7",this.getBBDC().getDirect(),p.x,p.y,[]);
            }
            var obbsiteArray:Array = gc.obbsiteArray.concat();
            var bmLen:uint = obbsiteArray.length;
            var sidArr:Array = [];
            for(var i:uint = 0; i < bmLen; )
            {
               var bo:BaseObject = obbsiteArray[i] as BaseObject;
               if(!bo.isYourFather() && !(bo is Monster49) && !(bo is Monster50) && !(bo is Monster51) && !(bo is Monster52) && !(bo is Monster48) && !(bo is Monster61) && !(bo is Monster66) && !(bo is Monster67) && !(bo is Monster68) && !(bo is Monster102) && !(bo is Monster104) && !(bo is Monster108) && !(bo is Monster154) && !(bo is Monster153))
               {
                  if(AUtils.GetDisBetweenTwoObj(b,bo) <= 240)
                  {
                     TweenMax.to(bo,0.625,{
                        "x":hit7Point.x,
                        "y":hit7Point.y - 30,
                        "onComplete":function(_bo:BaseObject):*
                        {
                           _bo = _bo;
                           if(!_bo.isDead())
                           {
                              TweenMax.to(_bo,0.625,{
                                 "x":_bo.x,
                                 "y":_bo.y - 10,
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
                        "onCompleteParams":[bo]
                     });
                     if(bo is BaseHero)
                     {
                        sidArr.push(bo.sid);
                     }
                     else if(bo is BaseMonster)
                     {
                        sidArr.push(BaseMonster(bo).entityId);
                     }
                  }
               }
               i++;
            }
            if(gc.isInRoom())
            {
               if(sidArr.length > 0)
               {
                  gc.sendAttack(bo.getRoleId(),"Role2Hit7",this.getBBDC().getDirect(),hit7Point.x,hit7Point.y,sidArr);
               }
            }
         }
         this.isHit7Ok = true;
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
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            if(this.getPlayer())
            {
               this._anti.skillLevel = this.player.returnSkillLevelBySkillName("tjgl");
            }
            else
            {
               this._anti.skillLevel = 1;
            }
            TweenMax.delayedCall(1.2,function(_b:SpecialEffectBullet, skillLevel:uint, isGxp:Boolean):*
            {
               var bh:* = null;
               var i:* = 0;
               var cureValue:* = 0;
               var player:Array = gc.getPlayerArray();
               var pLen:uint = player.length;
               for(i = uint(0); i < pLen; )
               {
                  bh = player[i] as BaseHero;
                  cureValue = uint(bh.roleProperies.getSHHP() * (0.3 + (skillLevel - 1) * 0.1));
                  if(isGxp)
                  {
                     cureValue *= 1.5;
                  }
                  if(AUtils.GetDisBetweenTwoObj(bh,_b) <= 150)
                  {
                     bh.cureHp(cureValue);
                  }
                  if(bh.getPet())
                  {
                     if(AUtils.GetDisBetweenTwoObj(bh.getPet(),_b) <= 150)
                     {
                        bh.getPet().cureHp(cureValue);
                     }
                  }
                  i++;
               }
            },[b,this._anti.skillLevel,this.isGXP]);
         }
         else if(gc.nodeInfo.PK_OR_FB == 1)
         {
            if(gc.sid != this.sid)
            {
               TweenMax.delayedCall(1.2,function(_b:SpecialEffectBullet):*
               {
                  var bh:* = null;
                  var i:* = 0;
                  var cureValue:* = 0;
                  var player:Array = gc.getPlayerArray();
                  var pLen:uint = player.length;
                  for(i = uint(0); i < pLen; )
                  {
                     bh = player[i] as BaseHero;
                     cureValue = uint(bh.roleProperies.getSHHP() * 0.3);
                     if(AUtils.GetDisBetweenTwoObj(bh,_b) <= 200)
                     {
                        bh.cureHp(cureValue);
                     }
                     i++;
                  }
               },[b]);
            }
         }
      }
      
      public function doHit9_1(direct:uint, p:Point) : void
      {
         mm.play("Role2_hit9");
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
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit10",direct,point.x,point.y,[]);
            }
         }
         else
         {
            this.x = this.role2Shalldow.x;
            this.y = this.role2Shalldow.y;
            this.role2Shalldow.destroy();
            this.role2Shalldow = null;
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit10",direct,this.x,this.y,[]);
            }
         }
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point,initTimer);
               break;
            case "hit2":
               this.doHit2(direct,point);
               break;
            case "hit3":
               this.doHit3(direct,point);
               break;
            case "hit4_1":
               this.doHit4_1(direct,point);
               break;
            case "hit4_2":
               this.doHit4_2(direct,point);
               break;
            case "hit5":
               this.doHit5(direct,point);
               break;
            case "hit6":
               this.doHit6(direct,point);
               break;
            case "hit7":
               this.doHit7(direct,point);
               break;
            case "hit8":
               this.doHit8(direct,point);
               break;
            case "hit9_1":
               this.doHit9_1(direct,point);
               break;
            case "hit9_2":
               this.doHit9_2(direct,point);
               break;
            case "hit10":
               this.doHit10(direct,point);
               break;
            case "wushuangStart":
               this.turnToGXP();
               break;
            case "wushuangOver":
               this.turnToNormal();
               break;
            case "Role2Hit7":
               this.beAttackByRole2Hit7(point);
               break;
            case "Role3Hit6":
               this.beAttackByRole3Hit6(point);
         }
      }
      
      override public function setOtherBuff(action:String, params:Array) : void
      {
         switch(action)
         {
            case "poison_bomb":
               this.curAddEffect.poison_times_bomb_other();
               break;
            case "Role4_hit6":
               if(this.curAddEffect)
               {
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.POISON_TIMES,
                     "time":gc.frameClips * 7
                  }]);
                  this.curAddEffect.add([{
                     "name":BaseAddEffect.STUN,
                     "time":gc.frameClips * 2
                  }]);
               }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         var sjt:Boolean = false;
         sjt = false;
         super.step();
         if(hit2CurrentCount > 0)
         {
            this.exceedPowerSprite.step(hit2CurrentCount);
         }
         else if(hit5CurrentCount > 0)
         {
            this.exceedPowerSprite.step(hit5CurrentCount);
         }
         if(hit2CurrentCount == 0 && hit5CurrentCount == 0)
         {
            this.exceedPowerSprite.clear();
         }
         if(this.role2Shalldow)
         {
            this.role2Shalldow.step();
         }
         if(this.hit2NeedCount == 48 || this.hit5NeedCount == 48)
         {
            if(this.getPlayer())
            {
               sjt = this.getPlayer().findSkillIsInTheSkillAry("sjt");
               if(sjt)
               {
                  hit2NeedCount = 12;
                  hit5NeedCount = 12;
                  bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,14],[4,4,4,4],[2,2,2,2],[1,1,30,55,8],[2,2,2,2,2],[2,4,12],[2,10,2,40],[2,2],[2,2,6],[24,2,15],[2,2,20],[2,2,10]]);
                  this.exceedPowerSprite.setMaxPower(hit2NeedCount);
               }
            }
         }
         else if(this.getPlayer())
         {
            sjt = this.getPlayer().findSkillIsInTheSkillAry("sjt");
            if(!sjt)
            {
               hit2NeedCount = 48;
               hit5NeedCount = 48;
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,14],[4,4,4,4],[2,2,2,2],[1,1,30,55,8],[2,2,2,2,2],[2,4,12],[2,10,2,40],[2,2],[2,2,6],[48,2,15],[2,2,20],[2,2,10]]);
               this.exceedPowerSprite.setMaxPower(hit2NeedCount);
            }
         }
      }
      
      override protected function myKeyDown(keyStr:String) : *
      {
         keyStr = keyStr;
         super.myKeyDown(keyStr);
         if(cannextaction)
         {
            switch(keyStr)
            {
               case "0010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.jump();
                  cannextaction = false;
                  break;
               case "0100":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.normalHit();
                  cannextaction = false;
                  break;
               case "1100":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.getFallDown();
                  cannextaction = false;
                  break;
               case "1010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  cannextaction = false;
                  break;
               case "0110":
                  gc.pWorld.getBaseLevelListener().keyBoardDownForWAtCommon(this);
                  if(this.checkTransferDoor())
                  {
                     gc.pWorld.getBaseLevelListener().keyBoardDownForW(this);
                     if(gc.curStageAndCurLevel.curStage == 8 && gc.curStageAndCurLevel.curLevel == 1 || gc.curStageAndCurLevel.curStage == 62 && gc.curStageAndCurLevel.curLevel == 1)
                     {
                        return;
                     }
                  }
                  if(!gc.isLevelClear && this.checkTransferDoor())
                  {
                     gc.isLevelClear = true;
                     gc.keyboardControl.destroy();
                     TweenMax.to(gc.gameInfo,1,{"alpha":0});
                     TweenMax.to(gc.gameSence,1,{
                        "alpha":0,
                        "onComplete":function():*
                        {
                           gc.eventManger.dispatchEvent(new Event("LevelVictor"));
                           MainGame.getInstance().levelClear();
                        }
                     });
                  }
                  break;
               case "0001":
            }
         }
      }
      
      override protected function showSkill(skill:String) : void
      {
         var skillArray:* = null;
         var needMp:* = 0;
         super.showSkill(skill);
         if(this.cannotuseskill())
         {
            return;
         }
         if(this.getPlayer())
         {
            skillArray = this.getPlayer().returnSkillNameBySkillKey(skill);
            if(skillArray)
            {
               skill = skillArray[0];
               needMp = uint(parseInt(skillArray[1]));
               if(skill == "sgq")
               {
                  this.skill_sgq(needMp);
               }
               else if(skill == "myhc")
               {
                  this.skill_myhc(needMp);
               }
               else if(skill == "jgz")
               {
                  this.skill_jgz(needMp);
               }
               else if(skill == "tjgl")
               {
                  this.skill_tjgl(needMp);
               }
               else if(skill == "jhsj")
               {
                  this.skill_jhsj(needMp);
               }
               else if(skill == "blb")
               {
                  this.skill_blb(needMp);
               }
               else if(skill == "xbz")
               {
                  this.skill_xbz(needMp);
               }
               else if(skill == "shy")
               {
                  this.skill_shy(needMp);
               }
               else if(skill == "smb")
               {
                  this.skill_smb(needMp);
               }
               if(this.curAddEffect.curDebuff(BaseAddEffect.MONSTER65_AOE) || this.curAddEffect.curDebuff(BaseAddEffect.MONSTER129Buff))
               {
                  this.reduceHp(needMp);
               }
            }
         }
      }
      
      private function skill_sgq(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit5");
         this.curAction = "hit5";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_myhc(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit6");
         this.lastHit = "hit6";
         this.newAttackId();
         this.hitNum = 0;
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_jgz(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit7");
         this.curAction = "hit7";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_tjgl(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit8");
         this.lastHit = "hit8";
         this.newAttackId();
         this.hitNum = 0;
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_jhsj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit9");
         this.curAction = "hit9";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_blb(needMp:uint) : void
      {
      }
      
      private function skill_xbz(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit3");
         this.curAction = "hit3";
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_shy(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.doHit10(this.getBBDC().getDirect(),new Point(this.x,this.y));
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_smb(needMp:uint) : void
      {
         if(!this.isAttacking())
         {
            if(this.roleProperies.getMMP() < needMp)
            {
               return;
            }
         }
         if(this.curAction != "hit4_1" && !this.standInObj || this.isAttacking() && this.curAction != "hit4_1" || this.isBeAttacking())
         {
            return;
         }
         var flag:Boolean = false;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.name == "Role1Bullet4_1")
            {
               this.hit4_2Point.x = bb.x;
               this.hit4_2Point.y = bb.y;
               flag = true;
               break;
            }
         }
         if(this.curAction != "hit4_1")
         {
            this.setAction("hit4_1");
            this.lastHit = "hit4_1";
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
            this.hit4_2Point.x = -99;
            this.hit4_2Point.y = -99;
            this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
         }
         else if(flag)
         {
            this.setAction("hit4_2");
            this.lastHit = "hit4_2";
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
         }
      }
      
      override protected function showSkillKongGe() : void
      {
         var ri:* = null;
         if(gc.isSingleGame())
         {
            ri = gc.gameInfo.getRoleInfoByPlayer(this.player) as RoleInfo;
            if(ri.isGXPReady() && !this.isGXP)
            {
               this.turnToGXP();
               if(this.getPlayer())
               {
                  if(gc.isInRoom())
                  {
                     gc.sendRoleWushuangStart(this.getRoleId());
                  }
               }
            }
         }
      }
      
      override public function normalHit() : *
      {
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit1");
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.lastHit = "hit1";
         this.hitNum = 0;
         this.newAttackId();
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override public function refreshEquip() : void
      {
         super.refreshEquip();
         this.initBBDC();
      }
      
      private function isDefending() : Boolean
      {
         return this.curAction == "hit6";
      }
      
      override public function isNormalHit() : Boolean
      {
         return this.curAction == "hit1";
      }
      
      private function runAttack() : void
      {
         if(!this.isInSky())
         {
            this.doubleCount = 0;
            this.normalHit();
         }
      }
      
      override public function clearAllBullets() : void
      {
         super.clearAllBullets();
         if(this.role2Shalldow)
         {
            this.role2Shalldow.destroy();
            this.role2Shalldow = null;
         }
      }
      
      override public function __keyBoardDown(evt:KeyboardEvent) : void
      {
         super.__keyBoardDown(evt);
      }
      
      override public function __keyBoardUp(evt:KeyboardEvent) : void
      {
         super.__keyBoardUp(evt);
      }
      
      override public function upGrade(first:Boolean = true) : *
      {
         super.upGrade();
         if(!first)
         {
            this.roleProperies.removeAllEquipAndPassive();
         }
         this.roleProperies.initAll();
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var sjt:Boolean = false;
         var v:int = 0;
         v = 0;
         var pinzhi:* = 0;
         var equip:* = null;
         pinzhi = 0;
         equip = null;
         pinzhi = 0;
         equip = null;
         var arr:* = null;
         var kind:* = 0;
         var jieshu:Number = NaN;
         equip = null;
         var addPower:Number = HeroSkillProtect.getInstance().hero2Anti.addPower1;
         if(this.isGXP)
         {
            addPower = HeroSkillProtect.getInstance().hero2Anti.addPower1dian5;
         }
         var isCrit:int = HeroSkillProtect.getInstance().hero2Anti.critNormal;
         if(crit && RandomControllor.getIns().getRandom() <= this.roleProperies.getTotalCrit() / 100)
         {
            isCrit = HeroSkillProtect.getInstance().hero2Anti.critNum;
         }
         var hit7Add:Number = HeroSkillProtect.getInstance().hero2Anti.addPower1;
         if(isHit7Ok)
         {
            hit7Add = HeroSkillProtect.getInstance().hero2Anti.addPower1dian3;
            isHit7Ok = false;
         }
         var sjtAdd:Number = HeroSkillProtect.getInstance().hero2Anti.addPower1;
         if(this.getPlayer())
         {
            sjt = this.getPlayer().findSkillIsInTheSkillAry("sjt");
            if(sjt)
            {
               sjtAdd = HeroSkillProtect.getInstance().hero2Anti.addPower1dian3;
            }
         }
         switch(cur)
         {
            case "hit1":
               return this.roleProperies.getHurt() * addPower * isCrit * hit7Add;
            case "hit2":
               return int(HeroSkillProtect.getInstance().hero2Anti.hit2Beishu * this.roleProperies.getHurt() * addPower * isCrit * hit7Add * sjtAdd);
            case "hit3":
               return int(HeroSkillProtect.getInstance().hero2Anti.hit3Beishu * this.roleProperies.getHurt() * addPower * isCrit * hit7Add * sjtAdd);
            case "hit4":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("smb");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return (HeroSkillProtect.getInstance().hero2Anti.hit4Beishu + (this._anti.skillLevel - 1) * 3) * this.roleProperies.getHurt() * addPower * isCrit * hit7Add * sjtAdd;
            case "hit5":
               return HeroSkillProtect.getInstance().hero2Anti.hit5Beishu * this.roleProperies.getHurt() * addPower * isCrit * hit7Add * sjtAdd;
            case "hit6":
               return 10;
            case "hit7":
               return 10;
            case "hit8":
               return 10;
            case "hit9_1":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("jhsj");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return this.roleProperies.getHurt() * addPower * isCrit * hit7Add * sjtAdd * (1 + (this._anti.skillLevel - 1) * 0.5);
            case "hit9_2":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("jhsj");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return this.roleProperies.getHurt() * addPower * isCrit * hit7Add * sjtAdd * (1 + (this._anti.skillLevel - 1) * 0.5);
            case "fabao-sword":
               return this.roleProperies.getHurt() * addPower * isCrit;
            case "hitNiumowangSzBuff":
               pinzhi = uint(1);
               equip = this.getPlayer().getCurEquipByType("zbsz");
               if(equip)
               {
                  if(equip.getFillName() == "yxnmwsz")
                  {
                     pinzhi = uint(2);
                  }
                  else if(equip.getFillName() == "jlnmwsz")
                  {
                     pinzhi = uint(3);
                  }
                  else if(equip.getFillName() == "ssnmwsz")
                  {
                     pinzhi = uint(4);
                  }
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (0.25 * pinzhi * pinzhi);
            case "hitZhuanlunwangSzBuff":
               pinzhi = uint(1);
               equip = this.getPlayer().getCurEquipByType("zbsz");
               if(equip)
               {
                  if(equip.getFillName() == "yxzlwsz")
                  {
                     pinzhi = uint(2);
                  }
                  else if(equip.getFillName() == "jlzlwsz")
                  {
                     pinzhi = uint(3);
                  }
                  else if(equip.getFillName() == "sszlwsz")
                  {
                     pinzhi = uint(4);
                  }
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (0.25 * pinzhi * pinzhi);
            case "hitTiantingZhanshenSzBuff":
               pinzhi = uint(1);
               equip = this.getPlayer().getCurEquipByType("zbsz");
               if(equip)
               {
                  if(equip.getFillName() == "yxttzssz")
                  {
                     pinzhi = uint(2);
                  }
                  else if(equip.getFillName() == "jlttzssz")
                  {
                     pinzhi = uint(3);
                  }
                  else if(equip.getFillName() == "ssttzssz")
                  {
                     pinzhi = uint(4);
                  }
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (0.25 * pinzhi * pinzhi);
            case "BossSkill_bs_qlj":
               return (3 + RandomControllor.getIns().getRandom() * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_nh":
               return 100;
            case "BossSkill_bs_xz":
               return (1 + RandomControllor.getIns().getRandom() * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_sfjz":
               return (3 + RandomControllor.getIns().getRandom() * 5) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_hlcj":
               return (3 + RandomControllor.getIns().getRandom() * 5) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_tl":
               return (3 + RandomControllor.getIns().getRandom() * 5) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_jt":
               return (3 + RandomControllor.getIns().getRandom() * 4) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_lx":
               return (1 + RandomControllor.getIns().getRandom() * 2) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_syfy":
               return (3 + RandomControllor.getIns().getRandom() * 6) * this.roleProperies.getHurt() * addPower * isCrit;
            case "BossSkill_bs_erishiba_1":
            case "BossSkill_bs_erishiba_2":
            case "BossSkill_bs_erishiba_3":
            case "BossSkill_bs_erishiba_4":
            case "BossSkill_bs_erishiba_5":
            case "BossSkill_bs_erishiba_6":
            case "BossSkill_bs_erishiba_7":
            case "BossSkill_bs_erishiba_8":
            case "BossSkill_bs_erishiba_9":
            case "BossSkill_bs_erishiba_10":
            case "BossSkill_bs_erishiba_11":
            case "BossSkill_bs_erishiba_12":
            case "BossSkill_bs_erishiba_13":
               break;
            case "BossSkill_bs_erishiba_14":
               break;
            case "hzlFan":
               equip = this.getPlayer().getCurEquipByType("zbfb");
               if(equip && equip.getWX().indexOf("木") != -1)
               {
                  return 2 * this.roleProperies.getHurt();
               }
               return this.roleProperies.getHurt();
               break;
            case "football1":
            case "football2":
               return 8 * this.roleProperies.getHurt();
            default:
               return 0;
         }
         arr = cur.split("_");
         kind = uint(arr[arr.length - 1]);
         jieshu = gc.getAnalyzeConstellationsLevel(kind);
         if(jieshu <= 0)
         {
            jieshu = 0.5;
         }
         else if(jieshu > 10)
         {
            jieshu = 10;
         }
         return jieshu * this.roleProperies.getHurt() * addPower * isCrit;
      }
      
      override public function addHeroHurtMc(_hurt:int) : void
      {
         var monHurtNumMc:ANumber = new ANumber();
         gc.gameSence.addChild(monHurtNumMc);
         monHurtNumMc.aNumImage("pnum",_hurt,this.x - 20,this.y - 60,20);
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4_1" || this.curAction == "hit4_2" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit8" || this.curAction == "hit6" || this.curAction == "hit9";
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
