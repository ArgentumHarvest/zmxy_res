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
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.bullet.StabBullet;
   import export.monster.Monster102;
   import export.monster.Monster104;
   import export.monster.Monster108;
   import export.monster.Monster153;
   import export.monster.Monster154;
   import export.monster.Monster49;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import export.monster.Monster52;
   import export.monster.Monster61;
   import export.monster.Monster66;
   import export.monster.Monster67;
   import export.monster.Monster68;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.ANumber;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class Role3 extends BaseHero
   {
       
      
      private var isHit6Ok:Boolean = false;
      
      private var mm:MusicManager;
      
      public function Role3()
      {
         super();
         mm = MusicManager.getInstance();
         roleName = "八戒";
         userType = "八戒";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-30,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-2],
            "attackInterval":5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit7_2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-30,-2],
            "attackInterval":gc.frameClips,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit8_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-22],
            "attackInterval":2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[10,-4],
            "attackInterval":8,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-5,-4],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":7,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-5],
            "attackInterval":7,
            "attackKind":"magic"
         };
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
            bbdc = new BaseBitmapDataClip(this.getAssetsArray("ROLE3"),300,200,new Point(0,0));
            bbdc.setOffsetXY(-15,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[3,3,3,9,5,9],[4,4,4,4],[2,2,2,2],[1,1,8,6,2,160],[2,2,2,2,2],[2,2,6],[2,2,6],[2,2,2,10],[24,2,8],[2,2,20],[2,2,2,20],[2,2,2,20],[4,3,25]]);
            bbdc.setFrameCount([36,6,4,4,[1,1,1,1,1,1],5,3,3,4,3,3,4,4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.bbdc.turnRight();
         }
         else
         {
            assetsArray = this.getAssetsArray("ROLE3");
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
         return "ROLE3_" + this.getCurClothId();
      }
      
      override protected function getWeaponAssetsName() : String
      {
         return "ROLE3_EQUIP_" + this.getCurWeaponId();
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               this.getBBDC().show();
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
            case "hit2":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit8":
               if(curPoint.y != 11)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(11);
               }
               this.bbdc.setState(str);
               break;
            case "hit9":
               if(curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               if(curPoint.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(str);
               break;
            case "hit11":
               if(curPoint.x != 4 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit11Frame2":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit12":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               this.lastHit = "hurt";
               if(curPoint.x != 2 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(2);
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
            case "wait":
               this.getBBDC().show();
               this.setAction("wait2");
               break;
            case "wait2":
               this.setAction("wait");
               break;
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "run":
               this.bbdc.setFramePointX(0);
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
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               this.setAction("wait");
               break;
            case "hit7":
               this.setAction("wait");
               break;
            case "hit8":
               this.setAction("wait");
               break;
            case "hit9":
               this.setAction("wait");
               break;
            case "hit10":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit11":
               this.setAction("hit11Frame2");
               break;
            case "hit11Frame2":
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hit12":
               this.lastHit = "";
               this.getBBDC().show();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.getBBDC().show();
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
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 130;
                        }
                        else
                        {
                           point.x = this.x + 130;
                        }
                        point.y = this.y - 72;
                        this.doHit1(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 140;
                        }
                        else
                        {
                           point.x = this.x + 140;
                        }
                        point.y = this.y - 30;
                        this.doHit2(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
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
                           point.x = this.x - 180;
                        }
                        else
                        {
                           point.x = this.x + 180;
                        }
                        point.y = this.y - 140;
                        this.doHit3(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit4":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 35;
                        }
                        else
                        {
                           point.x = this.x + 35;
                        }
                        point.y = this.y - 55;
                        this.doHit4(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit4",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 160)
                  {
                     if(p.x == 5)
                     {
                        this.bbdc.setCurFrameCount(4);
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 70;
                        }
                        else
                        {
                           point.x = this.x + 70;
                        }
                        point.y = this.y - 110;
                        this.doHit5(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit6":
               if(this.bbdc.getCurFrameCount() == 6)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getDirect() == 0)
                     {
                        point.x = this.x - 120;
                     }
                     else
                     {
                        point.x = this.x + 120;
                     }
                     point.y = this.y - 115;
                     this.doHit6(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit7":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 140;
                        }
                        else
                        {
                           point.x = this.x + 140;
                        }
                        point.y = this.y - 160;
                        this.doHit7_1(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit7_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 135;
                        }
                        else
                        {
                           point.x = this.x + 135;
                        }
                        point.y = this.y - 145;
                        this.doHit7_2(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit7_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit8":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(p.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 95;
                        }
                        else
                        {
                           point.x = this.x + 95;
                        }
                        point.y = this.y;
                        this.doHit8_1(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit8_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x + 20;
                        }
                        else
                        {
                           point.x = this.x - 20;
                        }
                        point.y = this.y - 20;
                        this.doHit8_2(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit8_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit9":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     if(p.x == 3)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 195;
                        }
                        else
                        {
                           point.x = this.x + 195;
                        }
                        point.y = this.y - 160;
                        this.doHit9(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit9",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit10":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 25)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 55;
                        }
                        else
                        {
                           point.x = this.x + 55;
                        }
                        point.y = this.y - 25;
                        this.doHit10(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit10",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               if(p.x == 2)
               {
                  if(this.isCanMoveByStage())
                  {
                     if(this.getBBDC().getDirect() == 0)
                     {
                        this.speed.x = -15;
                     }
                     else
                     {
                        this.speed.x = 15;
                     }
                  }
                  else
                  {
                     this.speed.y = -10;
                  }
               }
               break;
            case "hit11Frame2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 160)
                  {
                     if(p.x == 5)
                     {
                        this.getBBDC().hide();
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 135;
                        }
                        else
                        {
                           point.x = this.x + 135;
                        }
                        point.y = this.y - 90;
                        this.doHit11(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit11Frame2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        this.bbdc.setCurFrameCount(28);
                     }
                  }
               }
               break;
            case "hit12":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 160)
                  {
                     if(p.x == 5)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x;
                        }
                        else
                        {
                           point.x = this.x;
                        }
                        point.y = this.y;
                        this.doHit12_1(this.getBBDC().getDirect(),point);
                        gc.sendAttack(this.getRoleId(),"hit12_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 150)
                  {
                     this.getBBDC().hide();
                  }
               }
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet1");
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
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet3");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit4");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet4");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit5");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.curAddEffect)
         {
            this.curAddEffect.add([{
               "name":BaseAddEffect.BAJIE_DUNPAI_BUFF,
               "time":gc.frameClips * 10
            }]);
         }
      }
      
      private function doHit6(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role3_hit6");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            var obbsiteArray:Array = gc.obbsiteArray.concat();
            var bmLen:uint = obbsiteArray.length;
            var sidArr:Array = [];
            for(var i:uint = 0; i < bmLen; )
            {
               var bo:BaseObject = obbsiteArray[i] as BaseObject;
               if(!bo.isYourFather() && !(bo is Monster49) && !(bo is Monster50) && !(bo is Monster51) && !(bo is Monster52) && !(bo is Monster61) && !(bo is Monster66) && !(bo is Monster67) && !(bo is Monster68) && !(bo is Monster102) && !(bo is Monster104) && !(bo is Monster108) && !(bo is Monster154) && !(bo is Monster153))
               {
                  TweenMax.to(bo,1,{
                     "x":this.x,
                     "y":this.y - 100,
                     "onComplete":function(_bo:BaseObject):*
                     {
                        if(!_bo.isDead())
                        {
                           _bo.speed.y = 0;
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
               i++;
            }
            if(gc.isInRoom())
            {
               if(sidArr.length > 0)
               {
                  gc.sendAttack(bo.getRoleId(),"Role3Hit6",this.getBBDC().getDirect(),this.x,this.y - 100,sidArr);
               }
            }
         }
         this.isHit6Ok = true;
      }
      
      private function doHit7_1(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit7");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet7_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit7_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit7_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet7_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8_1(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit8");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet8_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit8_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit8_2(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet8_2");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit9");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role3Bullet9");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit10(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit10");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet10");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit11(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit11");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet11");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit11");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12_1(direct:uint, p:Point) : void
      {
         mm.play("Role3_hit12_1");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role3Bullet12_1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit12");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12_2(direct:*, point:*, targetPoint:Point = null, stabNum:uint = 10) : void
      {
         var randObject:* = null;
         var stab:* = null;
         var source:* = null;
         var i:int = 0;
         var rota:Number = NaN;
         mm.play("Role3_hit12_2");
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role3Bullet12_1")
            {
               if(bb.getImgMc())
               {
                  bb.getImgMc().gotoAndPlay(140);
               }
            }
         }
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            stabNum = 10;
            if(this.isGXP)
            {
               stabNum = 20;
            }
            randObject = gc.obbsiteArray[int(RandomControllor.getIns().getRandom() * gc.obbsiteArray.length)] as BaseObject;
            targetPoint = !!randObject ? new Point(randObject.x,randObject.y) : new Point(this.x + 1,this.y + 300);
         }
         else
         {
            targetPoint = !!targetPoint ? targetPoint : new Point(this.x + 1,this.y + 300);
         }
         var hit6Add:Boolean = false;
         if(this.isHit6Ok)
         {
            hit6Add = true;
         }
         for(i = 0; i < stabNum; )
         {
            rota = 360 / stabNum * i;
            source = new Point(point.x + Math.sin(rota * 3.141592653589793 / 180) * 100,point.y - Math.cos(rota * 3.141592653589793 / 180) * 100);
            stab = new StabBullet("Role3Bullet12_2",targetPoint,1,source);
            stab.setRole(this);
            stab.setDestroyWhenLastFrame(false);
            stab.setAction("hit12");
            stab.rotation = rota;
            stab.x = source.x;
            stab.y = source.y;
            if(hit6Add)
            {
               stab.setHurtAdd(0.3);
            }
            gc.gameSence.addChild(stab);
            this.magicBulletArray.push(stab);
            i++;
         }
         if(gc.sid == this.sid)
         {
            gc.sendAttack(this.getRoleId(),"hit12_2",this.getBBDC().getDirect(),this.x,this.y,[targetPoint.x,targetPoint.y,stabNum]);
         }
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         var targetPoint:* = null;
         var maxNum:* = 0;
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point);
               break;
            case "hit2":
               this.doHit2(direct,point);
               break;
            case "hit3":
               this.doHit3(direct,point);
               break;
            case "hit4":
               this.doHit4(direct,point);
               break;
            case "hit5":
               this.doHit5(direct,point);
               break;
            case "hit6":
               this.doHit6(direct,point);
               break;
            case "hit7_1":
               this.doHit7_1(direct,point);
               break;
            case "hit7_2":
               this.doHit7_2(direct,point);
               break;
            case "hit8_1":
               this.doHit8_1(direct,point);
               break;
            case "hit8_2":
               this.doHit8_2(direct,point);
               break;
            case "hit9":
               this.doHit9(direct,point);
               break;
            case "hit10":
               this.doHit10(direct,point);
               break;
            case "hit11Frame2":
               this.doHit11(direct,point);
               break;
            case "hit12_1":
               this.doHit12_1(direct,point);
               break;
            case "hit12_2":
               targetPoint = new Point(parseInt(params[0]),parseInt(params[1]));
               maxNum = uint(parseInt(params[2]));
               this.doHit12_2(direct,point,targetPoint,maxNum);
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
         super.step();
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12")
         {
            canHurt = false;
         }
         if(this.isGXP)
         {
            re *= 0.5;
         }
         super.reduceHp(re,canHurt);
      }
      
      override public function isCanHurtWhenBeingAttack() : Boolean
      {
         if(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12")
         {
            return false;
         }
         return true;
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!(this.curAddEffect && this.curAddEffect.curDebuff(BaseAddEffect.BAJIE_DUNPAI_BUFF) || this.curAction == "hit12"))
         {
            super.setAttackBack(p);
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
                  if(this.getPlayer().isstudyskill[3] != 1)
                  {
                     return;
                  }
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  if(this.roleProperies.getMMP() >= 20)
                  {
                     mm.play("Role3_hit6");
                     this.lastHit = "hit8";
                     this.curAction = "hit8";
                     this.hitNum = 0;
                     this.timers = 40;
                     this.newAttackId();
                     this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - 20]));
                  }
                  else
                  {
                     this.normalHit();
                     cannextaction = false;
                  }
                  break;
               case "0101":
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
         var keyArrays:* = null;
         var skillArray:* = null;
         var needMp:* = 0;
         super.showSkill(skill);
         if(this.cannotuseskill())
         {
            return;
         }
         if(this.getPlayer())
         {
            keyArrays = ["Y","U","I","O","L"];
            skillArray = this.getPlayer().returnSkillNameBySkillKey(skill);
            if(skillArray)
            {
               skill = skillArray[0];
               needMp = uint(parseInt(skillArray[1]));
               if(skill == "dj")
               {
                  this.skill_dj(needMp);
               }
               else if(skill == "sd")
               {
                  this.skill_sd(needMp);
               }
               else if(skill == "zznh")
               {
                  this.skill_zznh(needMp);
               }
               else if(skill == "syzq")
               {
                  this.skill_syzq(needMp);
               }
               else if(skill == "ssp")
               {
                  this.skill_ssp(needMp);
               }
               else if(skill == "jsp")
               {
                  this.skill_jsp(needMp);
               }
               else if(skill == "dgq")
               {
                  this.skill_dgq(needMp);
               }
               else if(skill == "xgq")
               {
                  this.skill_xgq(needMp);
               }
               else if(skill == "tmc")
               {
                  this.skill_tmc(needMp);
               }
               if(this.curAddEffect.curDebuff(BaseAddEffect.MONSTER65_AOE) || this.curAddEffect.curDebuff(BaseAddEffect.MONSTER129Buff))
               {
                  this.reduceHp(needMp);
               }
            }
         }
      }
      
      private function skill_dj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit4";
         this.setAction("hit4");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_sd(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit5";
         this.setAction("hit5");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_zznh(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit6";
         this.setAction("hit6");
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_syzq(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit7";
         this.setAction("hit7");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_ssp(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit8";
         this.setAction("hit8");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_jsp(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit9";
         this.setAction("hit9");
         this.hitNum = 0;
         this.newAttackId();
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_dgq(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit10";
         this.setAction("hit10");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_xgq(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.lastHit = "hit11";
         this.setAction("hit11");
         this.newAttackId();
         this.hitNum = 0;
         if(gc.sid == this.sid)
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_tmc(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() && this.curAction != "hit12" || this.isBeAttacking())
         {
            return;
         }
         if(this.lastHit == "hit12" && this.getBBDC().getCurFrameCount() <= 130)
         {
            this.lastHit = "hit12_2";
            this.getBBDC().setCurFrameCount(20);
            this.doHit12_2(this.getBBDC().getDirect(),new Point(this.x,this.y));
            this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
         }
         else if(this.lastHit != "hit12_2" && this.lastHit != "hit12")
         {
            this.lastHit = "hit12";
            this.setAction("hit12");
            this.hitNum = 0;
            if(gc.sid == this.sid)
            {
               gc.sendPosition(this);
            }
            this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
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
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            if(!this.isInSky())
            {
               if(!this.isRunning() && (!this.isAttacking() || this.isNormalHit()))
               {
                  this.timers = 13;
                  if(this.curtime - this.lasttime > 1500)
                  {
                     this.hitNum = 1;
                  }
                  else if(++this.hitNum > 3)
                  {
                     this.hitNum = 1;
                  }
                  mm.play("Role3_hit" + this.hitNum);
                  if(this.hitNum == 1)
                  {
                     this.setAction("hit2");
                     this.lastHit = "hit2";
                  }
                  else if(this.hitNum == 2)
                  {
                     this.setAction("hit1");
                     this.lastHit = "hit1";
                  }
                  else if(this.hitNum == 3)
                  {
                     this.lastHit = "hit3";
                     this.setAction("hit3");
                  }
                  if(this.getPlayer())
                  {
                     gc.sendPosition(this);
                  }
                  this.newAttackId();
               }
               else if(this.isRunning() && !this.isAttacking())
               {
                  this.doubleCount = 0;
                  this.normalHit();
               }
            }
            else
            {
               this.timers = 15;
               this.setAction("hit1");
               if(this.getPlayer())
               {
                  gc.sendPosition(this);
               }
               this.lastHit = "hit1";
               this.hitNum = 0;
               mm.play("Role3_hit3");
               this.newAttackId();
            }
         }
         this.lasttime = this.curtime;
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
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
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
         var v:int = 0;
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
         var addPower:Number = HeroSkillProtect.getInstance().hero3Anti.addPower1;
         if(this.isGXP)
         {
            addPower = HeroSkillProtect.getInstance().hero3Anti.addPower1dian5;
         }
         var isCrit:int = HeroSkillProtect.getInstance().hero3Anti.critNormal;
         if(crit && RandomControllor.getIns().getRandom() <= this.roleProperies.getTotalCrit() / 100)
         {
            isCrit = HeroSkillProtect.getInstance().hero3Anti.critNum;
         }
         var hit6Add:Number = HeroSkillProtect.getInstance().hero3Anti.addPower1;
         if(isHit6Ok)
         {
            hit6Add = HeroSkillProtect.getInstance().hero3Anti.addPower1dian3;
            isHit6Ok = false;
         }
         switch(cur)
         {
            case "hit1":
            case "hit2":
            case "hit3":
               return this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
            case "hit4":
               return HeroSkillProtect.getInstance().hero3Anti.hit4Beishu * this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
            case "hit5":
               return 0;
            case "hit6":
               return 0;
            case "hit7_1":
               return 0;
            case "hit7_2":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("syzq");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return (HeroSkillProtect.getInstance().hero3Anti.hit7Beishu + (this._anti.skillLevel - 1) * 1) * this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
            case "hit8_1":
               return 0;
            case "hit8_2":
               return this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
            case "hit9":
               return int(HeroSkillProtect.getInstance().hero3Anti.hit9Beishu * this.roleProperies.getHurt() * addPower * isCrit * hit6Add);
            case "hit10":
               return this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
            case "hit11":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("xgq");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               trace("hit11--this._anti.skillLevel:" + this._anti.skillLevel);
               if(this._anti.skillLevel == 1)
               {
                  return HeroSkillProtect.getInstance().hero3Anti.hit11Beishu * this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
               }
               if(this._anti.skillLevel == 2)
               {
                  return HeroSkillProtect.getInstance().hero3Anti.hit11BeishuLevel2 * this.roleProperies.getHurt() * addPower * isCrit * hit6Add;
               }
               return 0;
               break;
            case "hit12":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("tmc");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               trace("hit12--this._anti.skillLevel:" + this._anti.skillLevel);
               return HeroSkillProtect.getInstance().hero3Anti.hit12Beishu * this.roleProperies.getHurt() * addPower * isCrit + this.roleProperies.getSHHP() * (0.04 + (this._anti.skillLevel - 1) * 0.04);
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
         if(this.isGXP)
         {
            _hurt /= 2;
         }
         var monHurtNumMc:ANumber = new ANumber();
         gc.gameSence.addChild(monHurtNumMc);
         monHurtNumMc.aNumImage("pnum",_hurt,this.x - 20,this.y - 60,20);
      }
      
      private function isAttackingButCanAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && this.getJumpCount() == 0 || this.curAction == "hit4" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11" || this.curAction == "hit11Frame2" || this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit5" || this.curAction == "hit10";
      }
   }
}
