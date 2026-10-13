package export.hero
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.HeroSkillProtect;
   import event.CommonEvent;
   import export.RoleInfo;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class Role1 extends BaseHero
   {
       
      
      private var hit11Count:uint = 35;
      
      private var shallowArray:Array;
      
      private var mm:MusicManager;
      
      public function Role1()
      {
         shallowArray = [];
         super();
         mm = MusicManager.getInstance();
         roleName = "悟空";
         userType = "悟空";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[-0.5,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-8,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-15,-2],
            "attackInterval":999,
            "attackKind":"physics"
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
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-2],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-2,-2],
            "attackInterval":5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit10_3"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,20],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10_4"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-10,-15],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11_1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-20,0],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit11_2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,-25],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit12"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit13"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit14"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[-20,0],
            "attackInterval":999,
            "attackKind":"physics"
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
            bbdc = new BaseBitmapDataClip(this.getAssetsArray("ROLE1"),200,200,new Point(0,0));
            bbdc.setOffsetXY(5,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[5,5],[4,4,4,4],[2,2,2,2],[1,1,10,100,hit11Count,hit11Count],[2,2,2,2,2],[2,2,1,1,3],[1,1,1,1,5],[1,1,1,1,12],[2,2,1,1,10],[2,2,1,6],[2,3,2,3],[17,15,8,10],[2,12,16]]);
            bbdc.setFrameCount([36,8,4,4,[1,1,1,1,1,1],5,5,5,5,5,4,4,[1,1,1,1],3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            if(this.bbdc)
            {
               this.bbdc.turnRight();
            }
         }
         else
         {
            assetsArray = this.getAssetsArray("ROLE1");
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
         return "ROLE1_" + this.getCurClothId();
      }
      
      override protected function getWeaponAssetsName() : String
      {
         return "ROLE1_EQUIP_" + this.getCurWeaponId();
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
         if(str != "hit14")
         {
            this.bbdc.setOffsetXY(5,-15);
         }
         else
         {
            this.bbdc.setOffsetXY(5,-30);
         }
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
            case "hit2":
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
            case "hit4":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               if(curPoint.y != 10)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(10);
               }
               this.bbdc.setState(str);
               break;
            case "hit7":
               if(curPoint.x != 1 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(12);
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
               if(curPoint.x != 2 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit10":
               if(curPoint.x != 3 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit11_1":
               if(curPoint.x != 4 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(4);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit11_2":
               if(curPoint.x != 5 || curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(5);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit12":
               if(curPoint.x != 0 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit13":
               if(curPoint.x != 3 || curPoint.y != 12)
               {
                  this.bbdc.setFramePointX(3);
                  this.bbdc.setFramePointY(12);
               }
               this.bbdc.setState(str);
               break;
            case "hit14":
               if(curPoint.x != 0 || curPoint.y != 13)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(13);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               this.getBBDC().show();
               this.resetGraity();
               if(curPoint.x == 2 && curPoint.y == 12)
               {
                  this.getBBDC().resetCurFrameStopCount();
               }
               else
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(12);
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
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
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
               this.getBBDC().show();
               this.setSpeedStaticOnly();
               if(!this.isInSky())
               {
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit10":
               this.hit10Over();
               break;
            case "hit11_1":
               this.hit11Over();
               break;
            case "hit11_2":
               this.hit11Over();
               break;
            case "hit12":
               this.setAction("wait");
               break;
            case "hit13":
               if(!this.isInSky())
               {
                  this.setStatic();
                  this.setAction("wait");
               }
               else
               {
                  this.setAction("jump3");
               }
               break;
            case "hit14":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var fsc:* = null;
         var count:* = 0;
         var state:String = this.bbdc.getState();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 120;
                        }
                        else
                        {
                           point.x = this.x + 120;
                        }
                        point.y = this.y + 5;
                        this.doHit1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 30;
                        }
                        else
                        {
                           point.x = this.x + 30;
                        }
                        point.y = this.y - 110;
                        this.doHit3(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit3":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 160;
                        }
                        else
                        {
                           point.x = this.x + 160;
                        }
                        point.y = this.y - 10;
                        this.doHit4(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit4",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit4":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 165;
                        }
                        else
                        {
                           point.x = this.x + 165;
                        }
                        point.y = this.y - 20;
                        this.doHit5(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit5":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 30;
                        }
                        else
                        {
                           point.x = this.x + 30;
                        }
                        point.y = this.y + 40;
                        this.doHit6(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit6",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit6":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 15)
                  {
                     if(p.x == 1)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 175;
                        }
                        else
                        {
                           point.x = this.x + 175;
                        }
                        point.y = this.y - 30;
                        this.doHit7(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit7",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               if(this.bbdc.getDirect() == 0)
               {
                  this.speed.x = -25 * this.bbdc.getCurFrameCount() / 15;
               }
               else
               {
                  this.speed.x = 25 * this.bbdc.getCurFrameCount() / 15;
               }
               break;
            case "hit7":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x + 20;
                        }
                        else
                        {
                           point.x = this.x - 20;
                        }
                        point.y = this.y + 30;
                        this.doHit8(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit8",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 0)
                  {
                     for each(var r1s in this.shallowArray)
                     {
                        if(r1s)
                        {
                           if(!r1s.isReadyToDestroy)
                           {
                              r1s.setAction("hit1");
                           }
                        }
                     }
                  }
               }
               break;
            case "hit8":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 120;
                        }
                        else
                        {
                           point.x = this.x + 120;
                        }
                        point.y = this.y - 50;
                        this.doHit9(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit9",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit9":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 100)
                  {
                     if(p.x == 3)
                     {
                        point = new Point(0,0);
                        this.doHit10_1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit10_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 95)
                  {
                     if(p.x == 3)
                     {
                        point = new Point(this.x - 10,this.y);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit10_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                        this.doHit10_2(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               if(this.lastHit == "hit10_3")
               {
                  if(this.standInObj)
                  {
                     if(gc.sid == this.sid)
                     {
                        gc.sendAttack(this.getRoleId(),"hit10_4",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                     this.doHit10_4(this.getBBDC().getDirect(),point);
                  }
               }
               break;
            case "hit10":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == hit11Count)
                  {
                     if(p.x == 4)
                     {
                        this.doHit11_1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit11_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit11_1":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  fsc = this.bbdc.getFrameStopCount();
                  count = uint(fsc[4][5]);
                  if(this.bbdc.getCurFrameCount() == count)
                  {
                     if(p.x == 5)
                     {
                        this.doHit11_2(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendPosition(this);
                           gc.sendAttack(this.getRoleId(),"hit11_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit11_2":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 17)
                  {
                     if(p.x == 0)
                     {
                        this.doHit12_1(this.getBBDC().getDirect(),point);
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit12_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(p.x == 0)
                     {
                        if(gc.sid == this.sid || gc.isSingleGame())
                        {
                           this.doHit12_2(this.getBBDC().getDirect(),point);
                        }
                     }
                  }
               }
               break;
            case "hit12":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(p.x == 3)
                  {
                     point.x = this.x;
                     point.y = this.y;
                     this.checkHit13(this.getBBDC().getDirect(),point);
                     if(gc.sid == this.sid)
                     {
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit13Check",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                     }
                  }
               }
               break;
            case "hit13":
               if(gc.sid == this.sid || gc.isSingleGame())
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(p.x == 0)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x;
                        }
                        else
                        {
                           point.x = this.x;
                        }
                        point.y = this.y - 85;
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit14_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                        this.doHit14_1(this.getBBDC().getDirect(),point);
                     }
                  }
                  else if(this.bbdc.getCurFrameCount() == 16)
                  {
                     if(p.x == 2)
                     {
                        if(this.bbdc.getDirect() == 0)
                        {
                           point.x = this.x - 145;
                        }
                        else
                        {
                           point.x = this.x + 145;
                        }
                        point.y = this.y - 60;
                        if(gc.sid == this.sid)
                        {
                           gc.sendAttack(this.getRoleId(),"hit14_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                        }
                        this.doHit14_2(this.getBBDC().getDirect(),point);
                     }
                  }
               }
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  if(p.x == 0)
                  {
                     for each(r1s in this.shallowArray)
                     {
                        if(r1s)
                        {
                           if(!r1s.isReadyToDestroy)
                           {
                              r1s.setAction("hit2");
                           }
                        }
                     }
                  }
               }
               this.speed.y = 0;
               break;
            case "hit14":
         }
      }
      
      private function doHit1(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet1");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, p:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet3");
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
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet4");
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
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet5");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit6(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit6");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet6");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit6");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit7(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit7");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet7");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit7");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit8(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit8");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet8");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit8");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit9(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit9");
         this.getBBDC().hide();
         this.setYourFather(11);
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet9");
         b.x = p.x;
         b.y = p.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit9");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -40;
         }
         else
         {
            this.speed.x = 40;
         }
      }
      
      private function doHit10_1(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit10_1");
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -28;
         }
         else
         {
            this.speed.x = 28;
         }
         this.speed.y = -35;
         this.setYourFather(5);
      }
      
      private function doHit10_2(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         this.setStatic();
         this.speed.y = 0;
         this.setLostGraity();
         this.getBBDC().hide();
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            var bmLen:uint = gc.obbsiteArray.length;
            for(var i:uint = 0; i < bmLen; )
            {
               var bm:BaseObject = gc.obbsiteArray[i] as BaseObject;
               if(AUtils.GetDisBetweenTwoObj(this,bm) < 100)
               {
                  mm.play("Role1_hit10_2");
                  this.setYourFather(45);
                  var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_2");
                  b.x = p.x;
                  b.y = p.y;
                  b.setRole(this);
                  b.setDirect(direct);
                  b.setAction("hit10_2");
                  this.lastHit = "hit10_2";
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
                  TweenMax.delayedCall(1.9,function(_self:Role1, _direct:uint, _p:Point):*
                  {
                     if(gc.sid == _self.sid)
                     {
                        gc.sendAttack(_self.getRoleId(),"hit10_3",_self.getBBDC().getDirect(),_p.x,_p.y,[]);
                     }
                     _self.doHit10_3(_direct,_p);
                  },[this,direct,p]);
                  return;
               }
               i++;
            }
            this.doHit10_3(direct,p);
            if(gc.sid == this.sid)
            {
               gc.sendAttack(this.getRoleId(),"hit10_3",this.getBBDC().getDirect(),p.x,p.y,[]);
            }
         }
      }
      
      private function doHit10_3(direct:uint, p:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_3");
         b.x = this.x;
         b.y = this.y - 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10_3");
         this.lastHit = "hit10_3";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.setYourFather(30);
         this.resetGraity();
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -40;
         }
         else
         {
            this.speed.x = 40;
         }
         this.speed.y = 40;
      }
      
      private function doHit10_4(direct:uint, p:Point) : void
      {
         direct = direct;
         p = p;
         mm.play("Role1_hit10_4");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet10_4");
         b.x = this.x;
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit10_4");
         this.lastHit = "hit10_4";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         gc.vControllor.shake(25);
         this.setStatic();
         this.setYourFather(10);
         TweenMax.delayedCall(0.45,function(_self:Role1):*
         {
            _self.hit10Over();
         },[this]);
      }
      
      private function hit10Over() : void
      {
         this.getBBDC().show();
         this.setAction("wait");
      }
      
      private function hit11Over() : *
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role1Bullet11_1" || bb.getImcName() == "Role1Bullet11_2")
            {
               bb.destroy();
            }
         }
         this.resetGraity();
         this.speed.y = 0;
         if(!this.isInSky())
         {
            this.setAction("wait");
         }
         else
         {
            this.setAction("jump3");
         }
      }
      
      private function doHit11_1(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit11");
         if(this.bbdc.getDirect() == 0)
         {
            this.speed.x = -25;
         }
         else
         {
            this.speed.x = 25;
         }
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet11_1");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit11_1");
         this.lastHit = "hit11_1";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit11_2(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit11");
         this.speed.x = 0;
         this.speed.y = -25;
         this.setLostGraity();
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Role1Bullet11_1")
            {
               bb.destroy();
            }
         }
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Role1Bullet11_2");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x;
         }
         else
         {
            b.x = this.x;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit11_2");
         this.lastHit = "hit11_2";
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit12_1(direct:uint, p:Point) : void
      {
         mm.play("Role1_hit12_1");
         var mc1:MovieClip = AUtils.getNewObj("Role1Bullet12_1_1") as MovieClip;
         var mc2:MovieClip = AUtils.getNewObj("Role1Bullet12_1_2") as MovieClip;
         if(this.bbdc.getDirect() == 0)
         {
            mc1.x = this.x - 22;
         }
         else
         {
            mc1.x = this.x + 21;
            AUtils.flipHorizontal(mc1,-1);
         }
         mc1.y = this.y - 10;
         if(this.bbdc.getDirect() == 0)
         {
            mc2.x = this.x - 55;
         }
         else
         {
            mc2.x = this.x - 65;
         }
         mc2.y = this.y;
         gc.gameSence.addChild(mc1);
         gc.gameSence.addChild(mc2);
      }
      
      private function doHit12_2(direct:uint, p:Point) : void
      {
         var target:* = null;
         var bo:* = null;
         var i:* = 0;
         var dis:Number = 9999;
         var bmLen:uint = gc.obbsiteArray.length;
         for(i = uint(0); i < bmLen; i++)
         {
            bo = gc.obbsiteArray[i] as BaseObject;
            if(this.getBBDC().getDirect() == 0)
            {
               if(bo.x > this.x)
               {
                  continue;
               }
            }
            else if(bo.x < this.x)
            {
               continue;
            }
            if(dis > AUtils.GetDisBetweenTwoObj(this,bo))
            {
               dis = AUtils.GetDisBetweenTwoObj(this,bo);
               target = bo;
            }
         }
         if(target)
         {
            this.hit12Boom(target,this,3);
         }
      }
      
      private function hit12Boom(_target:BaseObject, _self:Role1, times:uint) : void
      {
         _target = _target;
         _self = _self;
         times = times;
         if(times > 0)
         {
            if(!this.isDead())
            {
               mm.play("Role1_hit12_2");
               var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet12");
               b.x = _target.x;
               b.y = _target.y;
               b.setRole(_self);
               b.setDirect(_self.getBBDC().getDirect());
               b.setAction("hit12");
               gc.gameSence.addChild(b);
               _self.magicBulletArray.push(b);
               gc.sendAttack(this.getRoleId(),"otherShowHit12",this.getBBDC().getDirect(),_target.x,_target.y,[]);
               times--;
               TweenMax.delayedCall(2,function(__target:BaseObject, __self:Role1, _times:uint):*
               {
                  _self.hit12Boom(__target,__self,_times);
               },[_target,_self,times]);
            }
            else
            {
               var times:uint = 0;
            }
         }
      }
      
      private function otherShowHit12(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet12");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit12_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function checkHit13(direct:uint, point:Point) : void
      {
         var newPoint:* = null;
         mm.play("Role1_hit13_1");
         this.curAction = "hit13";
         if(direct == 0)
         {
            this.speed.x = -30;
         }
         else
         {
            this.speed.x = 30;
         }
         if(gc.sid == this.sid || gc.isSingleGame())
         {
            for each(var bm in gc.obbsiteArray)
            {
               if(this.colipse.hitTestObject(bm.colipse))
               {
                  trace("击中");
                  newPoint = new Point();
                  newPoint.x = bm.x;
                  newPoint.y = bm.y;
                  this.doHit13(this.getBBDC().getDirect(),newPoint);
                  if(gc.isInRoom())
                  {
                     gc.sendAttack(this.getRoleId(),"hit13",this.getBBDC().getDirect(),newPoint.x,newPoint.y,[]);
                  }
                  return;
               }
            }
         }
      }
      
      private function doHit13(direct:uint, point:Point) : void
      {
         direct = direct;
         point = point;
         mm.play("Role1_hit13_2");
         this.curAction = "hit13";
         this.getBBDC().stopFrame();
         this.setStatic();
         this.getBBDC().hide();
         TweenMax.delayedCall(1.25,function(_self:Role1):*
         {
            _self.setAction("wait");
            _self.getBBDC().continueFrame();
            _self.getBBDC().show();
         },[this]);
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet13");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit13");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function createShallow(direct:uint = 0, point:Point = null) : void
      {
         var p:* = null;
         trace("Role1-》产生分身");
         if(!point)
         {
            p = new Point();
            p.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 150;
            p.y = this.y;
         }
         else
         {
            p = point;
         }
         var r1s:Role1Shadow = new Role1Shadow(this);
         if(this.getBBDC().getDirect() == 1)
         {
            r1s.getBBDC().turnRight();
         }
         r1s.x = p.x;
         r1s.y = p.y;
         gc.gameSence.addChild(r1s);
         this.shallowArray.push(r1s);
         if(this.sid == gc.sid && gc.isInRoom())
         {
            gc.sendAttack(this.getRoleId(),"createShallow",0,p.x,p.y,[]);
         }
      }
      
      public function doHit14_1(direct:uint, point:Point) : void
      {
         mm.play("Role1_hit14");
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet14_1");
         if(direct == 0)
         {
            b.x = point.x + 15;
         }
         else
         {
            b.x = point.x - 15;
         }
         b.y = point.y;
         b.setDisable();
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit14");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function doHit14_2(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Role1Bullet14_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit14");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point);
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
            case "hit7":
               this.doHit7(direct,point);
               break;
            case "hit8":
               this.doHit8(direct,point);
               break;
            case "hit9":
               this.doHit9(direct,point);
               break;
            case "hit10_1":
               this.doHit10_1(direct,point);
               break;
            case "hit10_2":
               this.doHit10_2(direct,point);
               break;
            case "hit10_3":
               this.doHit10_3(direct,point);
               break;
            case "hit10_4":
               this.doHit10_4(direct,point);
               break;
            case "hit11_1":
               this.doHit11_1(direct,point);
               break;
            case "hit11_2":
               this.doHit11_2(direct,point);
               break;
            case "hit12_1":
               this.doHit12_1(direct,point);
               break;
            case "otherShowHit12":
               this.otherShowHit12(direct,point);
               break;
            case "hit13":
               this.doHit13(direct,point);
               break;
            case "hit13Check":
               this.checkHit13(direct,point);
               break;
            case "hit14_1":
               this.doHit14_1(direct,point);
               break;
            case "hit14_2":
               this.doHit14_2(direct,point);
               break;
            case "createShallow":
               this.createShallow(direct,point);
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
         var i:* = 0;
         var r1s:* = null;
         var idx:int = 0;
         super.step();
         var tempArray:Array = [];
         var len:uint = this.shallowArray.length;
         for(i = uint(0); i < len; )
         {
            r1s = this.shallowArray[i] as Role1Shadow;
            if(r1s)
            {
               if(!r1s.isReadyToDestroy)
               {
                  r1s.step();
               }
               if(r1s.isReadyToDestroy)
               {
                  tempArray.push(r1s);
               }
            }
            i++;
         }
         if(tempArray.length > 0)
         {
            for each(r1s in tempArray)
            {
               idx = this.shallowArray.indexOf(r1s);
               if(idx != -1)
               {
                  this.shallowArray.splice(idx,1);
               }
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
                  cannextaction = false;
                  break;
               case "0110":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  if(this.getPlayer())
                  {
                     if(this.getPlayer().findSkillIsInTheSkillAry("slz"))
                     {
                        var needMp:uint = 10;
                        if(this.roleProperies.getMMP() >= needMp)
                        {
                           this.skill_slz(needMp);
                        }
                        else
                        {
                           this.normalHit();
                        }
                     }
                     else
                     {
                        this.normalHit();
                     }
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
                     if(!gc.isInHost())
                     {
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
                     else
                     {
                        MainGame.getInstance().levelClear();
                     }
                  }
                  break;
               case "0001":
            }
         }
      }
      
      private function skill_slz(needMp:uint) : void
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
         this.hitNum = 0;
         this.timers = 15;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_zz(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit14");
         this.curAction = "hit14";
         this.hitNum = 0;
         this.timers = 20;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_qsez(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.setAction("hit13");
         this.curAction = "hit13";
         this.hitNum = 0;
         this.timers = 20;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_hmz(needMp:uint) : void
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
         this.hitNum = 0;
         this.timers = 30;
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_lys(needMp:uint) : void
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
         this.setYourFather(10);
         this.hitNum = 0;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_hytj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         this.hitNum = 0;
         this.doubleCount = 0;
         this.setAction("hit7");
         this.lastHit = "hit7";
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
      }
      
      private function skill_lyfb(needMp:uint) : void
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
      
      private function skill_jdy(needMp:uint) : void
      {
         var fsc:* = null;
         if(!this.isAttacking())
         {
            if(this.roleProperies.getMMP() < needMp)
            {
               return;
            }
         }
         if(this.curAction != "hit11_1")
         {
            if(this.isAttacking() || this.isBeAttacking())
            {
               return;
            }
         }
         if(this.curAction != "hit11_1")
         {
            this.setAction("hit11_1");
            this.lastHit = "hit11_1";
            this.hitNum = 0;
            this.timers = hit11Count;
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
            this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
         }
         else
         {
            fsc = this.bbdc.getFrameStopCount();
            fsc[4][5] = this.bbdc.getCurFrameCount();
            this.setAction("hit11_2");
            this.lastHit = "hit11_2";
            this.hitNum = 0;
            this.timers = hit11Count;
            this.newAttackId();
            if(this.getPlayer())
            {
               gc.sendPosition(this);
            }
         }
      }
      
      private function skill_hyjj(needMp:uint) : void
      {
         if(this.roleProperies.getMMP() < needMp)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.isInSky())
         {
            return;
         }
         this.setAction("hit12");
         this.curAction = "hit12";
         this.hitNum = 0;
         this.timers = 17;
         this.newAttackId();
         if(this.getPlayer())
         {
            gc.sendPosition(this);
         }
         this.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.roleProperies.getMMP() - needMp]));
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
               if(skill == "slz")
               {
                  this.skill_slz(needMp);
               }
               else if(skill == "hmz")
               {
                  this.skill_hmz(needMp);
               }
               else if(skill == "hyjj")
               {
                  this.skill_hyjj(needMp);
               }
               else if(skill == "zz")
               {
                  this.skill_zz(needMp);
               }
               else if(skill == "qsez")
               {
                  this.skill_qsez(needMp);
               }
               else if(skill == "lys")
               {
                  this.skill_lys(needMp);
               }
               else if(skill == "hytj")
               {
                  this.skill_hytj(needMp);
               }
               else if(skill == "lyfb")
               {
                  this.skill_lyfb(needMp);
               }
               else if(skill == "jdy")
               {
                  this.skill_jdy(needMp);
               }
               if(this.curAddEffect.curDebuff(BaseAddEffect.MONSTER65_AOE) || this.curAddEffect.curDebuff(BaseAddEffect.MONSTER129Buff))
               {
                  this.reduceHp(needMp);
               }
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
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.isGXP)
         {
            canHurt = false;
         }
         super.reduceHp(re,canHurt);
      }
      
      override public function isCanHurtWhenBeingAttack() : Boolean
      {
         if(this.isGXP)
         {
            return false;
         }
         return true;
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!this.isGXP)
         {
            super.setAttackBack(p);
         }
      }
      
      override public function normalHit() : *
      {
         var needMp:* = 0;
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            if(!this.isInSky())
            {
               if(!this.isRunning() && (!this.isAttacking() || this.isNormalHit()))
               {
                  if(this.curtime - this.lasttime > 1500)
                  {
                     this.hitNum = 1;
                  }
                  else if(++this.hitNum > 5)
                  {
                     this.hitNum = 1;
                  }
                  switch(int(this.hitNum) - 1)
                  {
                     case 0:
                     case 1:
                     case 2:
                        this.timers = 9;
                        break;
                     case 3:
                        this.timers = 15;
                        break;
                     case 4:
                        this.timers = 15;
                  }
                  if(this.hitNum == 1 || this.hitNum == 2)
                  {
                     mm.play("Role1_hit1AndHit2");
                  }
                  else if(this.hitNum == 3 || this.hitNum == 4)
                  {
                     mm.play("Role1_hit3AndHit4");
                  }
                  else
                  {
                     mm.play("Role1_hit5");
                  }
                  this.setAction("hit" + this.hitNum);
                  if(this.getPlayer())
                  {
                     gc.sendPosition(this);
                  }
                  this.lastHit = "hit" + this.hitNum;
                  this.newAttackId();
               }
               else if(this.isRunning() && !this.isAttacking())
               {
                  if(this.getPlayer())
                  {
                     if(this.getPlayer().findSkillIsInTheSkillAry("hytj"))
                     {
                        needMp = uint(20);
                        if(this.roleProperies.getMMP() >= needMp)
                        {
                           this.skill_hytj(needMp);
                        }
                        else
                        {
                           this.setAction("hit1");
                           if(this.getPlayer())
                           {
                              gc.sendPosition(this);
                           }
                        }
                     }
                     else
                     {
                        this.setAction("hit1");
                        if(this.getPlayer())
                        {
                           gc.sendPosition(this);
                        }
                     }
                  }
               }
            }
            else if(!this.isAttacking() && !this.isBeAttacking())
            {
               this.timers = 15;
               this.setAction("hit3");
               if(this.getPlayer())
               {
                  gc.sendPosition(this);
               }
               this.lastHit = "hit3";
               this.hitNum = 0;
               mm.play("Role1_hit3AndHit4");
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
         var addPower:Number = HeroSkillProtect.getInstance().hero1Anti.addPower1;
         if(this.isGXP)
         {
            addPower = HeroSkillProtect.getInstance().hero1Anti.addPower1dian5;
         }
         var isCrit:int = HeroSkillProtect.getInstance().hero1Anti.critNormal;
         if(crit && RandomControllor.getIns().getRandom() <= this.roleProperies.getTotalCrit() / 100)
         {
            isCrit = HeroSkillProtect.getInstance().hero1Anti.critNum;
         }
         switch(cur)
         {
            case "hit1":
            case "hit2":
            case "hit3":
            case "hit4":
            case "hit5":
               return this.roleProperies.getHurt() * addPower * isCrit;
            case "hit6":
               return HeroSkillProtect.getInstance().hero1Anti.hit6Beishu * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit7":
               return HeroSkillProtect.getInstance().hero1Anti.hit7Beishu * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit8":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("lyfb");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               if(this._anti.skillLevel == 1)
               {
                  return HeroSkillProtect.getInstance().hero1Anti.hit8Beishu * this.roleProperies.getHurt() * addPower * isCrit;
               }
               if(this._anti.skillLevel == 2)
               {
                  return HeroSkillProtect.getInstance().hero1Anti.hit8BeishuLevel2 * this.roleProperies.getHurt() * addPower * isCrit;
               }
               return 0;
               break;
            case "hit9":
               return 100;
            case "hit10_2":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("hmz");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return HeroSkillProtect.getInstance().hero1Anti.hit10_2Beishu * this.roleProperies.getHurt() * addPower * isCrit * (1 + (this._anti.skillLevel - 1) * 1);
            case "hit10_3":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("hmz");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return HeroSkillProtect.getInstance().hero1Anti.hit10_3Beishu * this.roleProperies.getHurt() * addPower * isCrit * (1 + (this._anti.skillLevel - 1) * 0.8);
            case "hit10_4":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("hmz");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return HeroSkillProtect.getInstance().hero1Anti.hit10_4Beishu * this.roleProperies.getHurt() * addPower * isCrit * (1 + (this._anti.skillLevel - 1) * 2.5);
            case "hit11_1":
               return HeroSkillProtect.getInstance().hero1Anti.hit11Beishu * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit11_2":
               return HeroSkillProtect.getInstance().hero1Anti.hit11Beishu * this.roleProperies.getHurt() * addPower * isCrit;
            case "hit12":
               if(this.getPlayer())
               {
                  this._anti.skillLevel = this.player.returnSkillLevelBySkillName("hyjj");
               }
               else
               {
                  this._anti.skillLevel = 1;
               }
               return this.roleProperies.getHurt() * addPower * isCrit * (1.5 + (this._anti.skillLevel - 1) * 0.75);
            case "hit13":
               return int(HeroSkillProtect.getInstance().hero1Anti.hit13Beishu * this.roleProperies.getHurt() * addPower * isCrit);
            case "hit14":
               return HeroSkillProtect.getInstance().hero1Anti.hit14Beishu * this.roleProperies.getHurt() * addPower * isCrit;
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
               return 10;
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
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && this.getJumpCount() == 0 || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit8" || this.curAction == "hit14";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit12" || this.curAction == "hit13" || this.curAction == "hit14";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit14";
      }
      
      override protected function isCannotMoveXWhenAttack() : Boolean
      {
         return this.curAction == "hit12";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit7" || this.curAction == "hit9" || this.curAction == "hit10" || this.curAction == "hit11_1" || this.curAction == "hit11_2" || this.curAction == "hit13";
      }
   }
}
