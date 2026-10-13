package export.taskInterface
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import export.bigzp.SpecialTaskMask;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import my.PetEquipObj;
   import petInfo.PetInfo;
   import task.Task;
   
   public class TaskInterface extends Sprite
   {
       
      
      public var btn_close:SimpleButton;
      
      public var dailymc:MovieClip;
      
      public var activitymc:MovieClip;
      
      public var getaward:MovieClip;
      
      public var prepage:SimpleButton;
      
      public var nextpage:SimpleButton;
      
      public var txtinstr:TextField;
      
      public var txtcur:TextField;
      
      public var t1:TaskTile;
      
      public var t2:TaskTile;
      
      public var t3:TaskTile;
      
      public var t4:TaskTile;
      
      public var t5:TaskTile;
      
      public var alist1:AwardList;
      
      public var alist2:AwardList;
      
      public var alist3:AwardList;
      
      public var alist4:AwardList;
      
      public var txtpage:TextField;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 1;
      
      private var gc:Config;
      
      private var curAry:Array;
      
      private var selectTask:Task;
      
      private var selectId:uint = 0;
      
      private var whichTaskSelect:String = "";
      
      private var _anti:Antiwear;
      
      public function TaskInterface()
      {
         this.curAry = [];
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         dailymc.buttonMode = true;
         activitymc.buttonMode = true;
         getaward.buttonMode = true;
         txtinstr.selectable = false;
         txtcur.selectable = false;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_close.addEventListener("click",closed);
         dailymc.addEventListener("click",dailyClick);
         activitymc.addEventListener("click",activityClick);
         prepage.addEventListener("click",prePage);
         nextpage.addEventListener("click",nextPage);
         dailymc.dispatchEvent(new MouseEvent("click"));
      }
      
      private function removed(e:Event) : void
      {
         var i:* = 0;
         btn_close.removeEventListener("click",closed);
         dailymc.removeEventListener("click",dailyClick);
         activitymc.removeEventListener("click",activityClick);
         getaward.removeEventListener("click",awardClick);
         prepage.removeEventListener("click",prePage);
         nextpage.removeEventListener("click",nextPage);
         i = 0;
         while(i < 5)
         {
            this["t" + (i + 1)].removeEventListener("click",selected);
            i++;
         }
         if(gc.keyboardControl)
         {
            gc.keyboardControl.continueAllControl();
         }
      }
      
      private function closed(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function dailyClick(e:MouseEvent) : void
      {
         trace("[TaskInterface.dailyClick] gc:",gc," player1:",!!gc ? gc.player1 : null," allTask:",!!gc ? gc.allTask : null);
         this.whichTaskSelect = "dailyClick";
         this.dailymc.gotoAndStop(2);
         this.activitymc.gotoAndStop(1);
         if(gc.player1.roleid > 0)
         {
            this.curAry = gc.allTask.getdayTask(gc.player1.getCurLevel());
         }
         this.curPage = 1;
         var dlen:uint = curAry.length;
         this.allPage = Math.ceil(dlen / 5);
         this.setTaskList(curAry);
         this.setPageTxt();
      }
      
      private function activityClick(e:MouseEvent) : void
      {
         this.whichTaskSelect = "activityClick";
         this.dailymc.gotoAndStop(1);
         this.activitymc.gotoAndStop(2);
         curAry = gc.allTask.getactTask();
         this.curPage = 1;
         var dlen:uint = curAry.length;
         this.allPage = Math.ceil(dlen / 5) > 0 ? Math.ceil(dlen / 5) : 1;
         this.setTaskList(curAry);
         this.setPageTxt();
      }
      
      private function awardClick(e:MouseEvent) : void
      {
         this.analyseAward();
      }
      
      private function prePage(e:MouseEvent) : void
      {
         if(this.curPage > 1)
         {
            this.curPage--;
         }
         else
         {
            this.curPage = 1;
         }
         this.setTaskListToFirstFrame();
         this.setTaskList(this.curAry);
         this.setPageTxt();
      }
      
      private function nextPage(e:MouseEvent) : void
      {
         if(this.curPage < this.allPage)
         {
            this.curPage++;
         }
         else
         {
            this.curPage = this.allPage;
         }
         this.setTaskListToFirstFrame();
         this.setTaskList(this.curAry);
         this.setPageTxt();
      }
      
      private function setTaskList(data:Array) : void
      {
         var i:* = 0;
         i = 0;
         i = 0;
         while(i < 5)
         {
            this["t" + (i + 1)].visible = true;
            this["t" + (i + 1)].removeEventListener("click",selected);
            this["t" + (i + 1)].removeIcon();
            i++;
         }
         i = 0;
         while(i < 5)
         {
            if(data[i + (this.curPage - 1) * 5])
            {
               this["t" + (i + 1)].addEventListener("click",selected);
               this["t" + (i + 1)].setTask(data[i + (this.curPage - 1) * 5] as Task);
            }
            else
            {
               this["t" + (i + 1)].visible = false;
            }
            i++;
         }
         if(this.selectId != 0)
         {
            this["t" + this.selectId].dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function setAwardList() : void
      {
         var alist:Array = null;
         var alen:* = 0;
         var i:* = 0;
         var ary:Array = null;
         this.alist1.removeImage();
         this.alist2.removeImage();
         this.alist3.removeImage();
         this.alist4.removeImage();
         if(this.selectTask)
         {
            alist = this.selectTask.getAllAward();
            alen = alist.length;
            i = 0;
            while(i < alen)
            {
               if(alist[i].type == "exp")
               {
                  this["alist" + (i + 1)].addImage("rw_exp");
               }
               else if(alist[i].type == "bs")
               {
                  this["alist" + (i + 1)].addImage("rw_bs");
               }
               else if(alist[i].type == "lh")
               {
                  this["alist" + (i + 1)].addImage("rw_lh");
               }
               else if(alist[i].type == "zzs" || alist[i].type == "zb")
               {
                  this["alist" + (i + 1)].addImage(this.replaceString(String(alist[i].value),"-"));
               }
               else if(alist[i].type == "qhd")
               {
                  this["alist" + (i + 1)].addImage("qhd_5");
               }
               else if(alist[i].type == "dj")
               {
                  ary = String(alist[i].value).split("-") as Array;
                  this["alist" + (i + 1)].addImage(ary[0]);
               }
               else if(alist[i].type == "gmcs")
               {
                  this["alist" + (i + 1)].addImage("buy5icon");
               }
               else if(alist[i].type == "lhjl" || alist[i].type == "bxjl" || alist[i].type == "gsjl" || alist[i].type == "ymjl")
               {
                  this["alist" + (i + 1)].addImage("rw_" + alist[i].type);
               }
               else if(alist[i].type == "roomhorse")
               {
                  this["alist" + (i + 1)].addImage("rw_" + alist[i].type);
               }
               else
               {
                  this["alist" + (i + 1)].addImage(alist[i].value);
               }
               this["alist" + (i + 1)].txtname.text = alist[i].cname;
               i++;
            }
         }
      }
      
      private function setTaskListToFirstFrame() : void
      {
         var i:* = 0;
         i = 0;
         while(i < 5)
         {
            this["t" + (i + 1)].unselected();
            i++;
         }
      }
      
      private function selected(e:MouseEvent) : void
      {
         var stm:SpecialTaskMask = null;
         var _hascomplete:Boolean = false;
         _hascomplete = false;
         _hascomplete = false;
         _hascomplete = false;
         _hascomplete = false;
         _hascomplete = false;
         getaward.removeEventListener("click",awardClick);
         this.setTaskListToFirstFrame();
         e.currentTarget.selected();
         this.selectTask = e.currentTarget.getTask();
         this.selectId = int(String(e.currentTarget.name).substr(1,1));
         this.setTxt();
         if(this.whichTaskSelect == "activityClick")
         {
            if(this.selectTask.getrwId() == 16)
            {
               stm = new SpecialTaskMask();
               stm.x = 425;
               stm.y = 134;
               stm.name = "SpecialTaskMask";
               this.addChild(stm);
               getaward.visible = false;
               return;
            }
            getaward.visible = true;
            if(this.getChildByName("SpecialTaskMask") != null)
            {
               this.removeChild(this.getChildByName("SpecialTaskMask"));
            }
            if(this.selectTask.getrwId() == 17)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else
               {
                  _hascomplete = false;
                  if(gc.playNum == 1)
                  {
                     if(gc.player1.getCurLevel() >= 10)
                     {
                        _hascomplete = true;
                     }
                  }
                  else if(gc.playNum == 2)
                  {
                     if(gc.player1.getCurLevel() >= 10 && gc.player2.getCurLevel() >= 10)
                     {
                        _hascomplete = true;
                     }
                  }
                  if(_hascomplete)
                  {
                     this.getaward.gotoAndStop(2);
                     getaward.addEventListener("click",awardClick);
                  }
                  else
                  {
                     this.getaward.gotoAndStop(1);
                  }
               }
            }
            else if(this.selectTask.getrwId() == 18)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else
               {
                  _hascomplete = false;
                  if(gc.playNum == 1)
                  {
                     if(gc.player1.getCurLevel() >= 50 && gc.player1.getSomeOneEquipNumberByName("ttlp") > 0)
                     {
                        _hascomplete = true;
                     }
                  }
                  else if(gc.playNum == 2)
                  {
                     if(gc.player1.getCurLevel() >= 50 && gc.player2.getCurLevel() >= 50 && (gc.player1.getSomeOneEquipNumberByName("ttlp") > 0 || gc.player2.getSomeOneEquipNumberByName("ttlp") > 0))
                     {
                        _hascomplete = true;
                     }
                  }
                  if(_hascomplete)
                  {
                     this.getaward.gotoAndStop(2);
                     getaward.addEventListener("click",awardClick);
                  }
                  else
                  {
                     this.getaward.gotoAndStop(1);
                  }
               }
            }
            else if(this.selectTask.getrwId() == 19)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else
               {
                  _hascomplete = false;
                  if(gc.playNum == 1)
                  {
                     if(gc.player1.getCurLevel() >= 80)
                     {
                        _hascomplete = true;
                     }
                  }
                  else if(gc.playNum == 2)
                  {
                     if(gc.player1.getCurLevel() >= 80 && gc.player2.getCurLevel() >= 80)
                     {
                        _hascomplete = true;
                     }
                  }
                  if(_hascomplete)
                  {
                     this.getaward.gotoAndStop(2);
                     getaward.addEventListener("click",awardClick);
                  }
                  else
                  {
                     this.getaward.gotoAndStop(1);
                  }
               }
            }
            else if(this.selectTask.getrwId() == 20)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else
               {
                  _hascomplete = false;
                  if(gc.playNum == 1)
                  {
                     if(gc.player1.getSomeOneEquipNumberByName("ttsl") > 0)
                     {
                        _hascomplete = true;
                     }
                  }
                  else if(gc.playNum == 2)
                  {
                     if(gc.getSomeOneEquipNumberByName("ttsl") > 0 || gc.player2.getSomeOneEquipNumberByName("ttsl") > 0)
                     {
                        _hascomplete = true;
                     }
                  }
                  if(_hascomplete)
                  {
                     this.getaward.gotoAndStop(2);
                     getaward.addEventListener("click",awardClick);
                  }
                  else
                  {
                     this.getaward.gotoAndStop(1);
                  }
               }
            }
            else if(this.selectTask.getrwId() == 21)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else
               {
                  _hascomplete = false;
                  if(gc.achieveLandGodLevel() >= 4)
                  {
                     _hascomplete = true;
                  }
                  if(_hascomplete)
                  {
                     this.getaward.gotoAndStop(2);
                     getaward.addEventListener("click",awardClick);
                  }
                  else
                  {
                     this.getaward.gotoAndStop(1);
                  }
               }
            }
            else if(this.selectTask.getrwId() == 22)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else if(this.selectTask.judgeComplete())
               {
                  this.getaward.gotoAndStop(2);
                  getaward.addEventListener("click",awardClick);
               }
               else
               {
                  this.getaward.gotoAndStop(1);
               }
            }
            else if(this.selectTask.getrwId() == 23)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else
               {
                  _hascomplete = false;
                  if(gc.player1.getSomeWeaponInPackBackByName("lxfb") != null && gc.player1.getSomeWeaponInPackBackByName("sxfb") != null && gc.player1.getSomeWeaponInPackBackByName("yxfb") != null)
                  {
                     _hascomplete = true;
                  }
                  if(gc.player2.roleid > 0)
                  {
                     if(gc.player2.getSomeWeaponInPackBackByName("lxfb") != null && gc.player2.getSomeWeaponInPackBackByName("sxfb") != null && gc.player2.getSomeWeaponInPackBackByName("yxfb") != null)
                     {
                        _hascomplete = true;
                     }
                  }
                  if(_hascomplete)
                  {
                     this.getaward.gotoAndStop(2);
                     getaward.addEventListener("click",awardClick);
                  }
                  else
                  {
                     this.getaward.gotoAndStop(1);
                  }
               }
            }
            else if(this.selectTask.getrwId() == 24)
            {
               if(this.selectTask.getHasGetAward())
               {
                  this.getaward.gotoAndStop(1);
               }
               else if(this.selectTask.judgeComplete())
               {
                  this.getaward.gotoAndStop(2);
                  getaward.addEventListener("click",awardClick);
               }
               else
               {
                  this.getaward.gotoAndStop(1);
               }
            }
         }
         else if(this.selectTask.getHasGetAward())
         {
            this.getaward.gotoAndStop(1);
         }
         else if(this.selectTask.judgeComplete())
         {
            this.getaward.gotoAndStop(2);
            getaward.addEventListener("click",awardClick);
         }
         else
         {
            this.getaward.gotoAndStop(1);
         }
         this.setAwardList();
      }
      
      private function setPageTxt() : void
      {
         this.txtpage.text = this.curPage + "/" + this.allPage;
      }
      
      private function setTxt() : void
      {
         if(this.selectTask)
         {
            txtinstr.text = this.selectTask.getrwdict();
            txtcur.text = this.selectTask.getTaskPro();
         }
      }
      
      public function analyseAward() : void
      {
         var alen:* = 0;
         var sary:Array = null;
         var eo:MyEquipObj = null;
         eo = null;
         eo = null;
         var pif:PetInfo = null;
         var expValue:int = 0;
         var value:* = 0;
         value = 0;
         var disStr:String = null;
         var peo:PetEquipObj = null;
         var ary:Array = null;
         eo = null;
         var bool:Boolean = false;
         bool = false;
         var slen:* = 0;
         if(this.selectTask == null)
         {
            return;
         }
         if(this.selectTask.rwaward == null)
         {
            throw new Error("奖品为null！");
         }
         var showStr:String = "恭喜";
         if(this.selectTask.getrwId() != 15)
         {
            this.taskAwardAryById();
            alen = this.selectTask.rwaward.length;
            sary = [];
            while(alen-- > 0)
            {
               trace("this.selectTask.rwaward[alen].type -->>" + this.selectTask.rwaward[alen].type);
               switch(this.selectTask.rwaward[alen].type)
               {
                  case "zzs":
                     eo = gc.allEquip.findByName(this.replaceString(String(this.selectTask.rwaward[alen].value),"-"));
                     if(eo == null)
                     {
                        return;
                     }
                     showStr += "您成功领取:" + eo.ename;
                     sary.push(eo);
                     continue;
                  case "zb":
                     eo = gc.allEquip.findByName(this.replaceString(String(this.selectTask.rwaward[alen].value),"-"));
                     if(eo == null)
                     {
                        return;
                     }
                     showStr += "您成功领取:" + eo.ename;
                     sary.push(eo);
                     continue;
                  case "bs":
                     eo = gc.allEquip.findByName(this.selectTask.rwaward[alen].value);
                     showStr += "您成功领取:" + eo.ename;
                     trace("showStr -->>" + showStr);
                     sary.push(eo);
                     continue;
                  case "exp":
                     expValue = int(this.replaceString(this.selectTask.rwaward[alen].value,"-"));
                     if(gc.player1)
                     {
                        pif = gc.player1.findCurrentPet();
                        if(pif != null)
                        {
                           pif.setCurExper(pif.getCurExper() + expValue);
                        }
                        else
                        {
                           gc.player1.setCurExp(gc.player1.getCurExp() + expValue);
                           if(gc.player1.getCurLevel() == gc.getTotalTopLevel())
                           {
                              value = uint(5000 + 5000 * (gc.player1.getCurLevel() - 19));
                              if(gc.player1.getCurExp() > value)
                              {
                                 gc.player1.setCurExp(value);
                              }
                           }
                        }
                     }
                     if(gc.player2)
                     {
                        pif = gc.player1.findCurrentPet();
                        if(pif != null)
                        {
                           pif.setCurExper(pif.getCurExper() + expValue);
                        }
                        else
                        {
                           gc.player2.setCurExp(gc.player2.getCurExp() + expValue);
                           if(gc.player2.getCurLevel() == gc.getTotalTopLevel())
                           {
                              value = uint(5000 + 5000 * (gc.player2.getCurLevel() - 19));
                              if(gc.player2.getCurExp() > value)
                              {
                                 gc.player2.setCurExp(value);
                              }
                           }
                        }
                     }
                     disStr = expValue + "";
                     if(expValue > 10000)
                     {
                        disStr = expValue / 10000 + "w";
                     }
                     if(pif)
                     {
                        showStr += "您宠物成功领取:" + disStr + " 经验";
                     }
                     else
                     {
                        showStr += "您成功领取:" + disStr + " 经验";
                     }
                     continue;
                  case "lh":
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.setLhValue(gc.player1.getLhValue() + int(this.replaceString(this.selectTask.rwaward[alen].value,"-")));
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.setLhValue(gc.player2.getLhValue() + int(this.replaceString(this.selectTask.rwaward[alen].value,"-")));
                     }
                     showStr += "您成功领取:" + int(this.replaceString(this.selectTask.rwaward[alen].value,"-")) + " 灵魂";
                     continue;
                  case "pet_equip":
                     peo = gc.allEquip.findByName(this.replaceString(String(this.selectTask.rwaward[alen].value),"-"));
                     if(peo == null)
                     {
                        return;
                     }
                     showStr += "您成功领取:" + peo.getEname();
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.plist.push(peo);
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.plist.push(peo);
                     }
                     continue;
                  case "qhd":
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.dataObject.strenthtimes += 5;
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.dataObject.strenthtimes += 5;
                     }
                     showStr += "您成功领取5点强化点";
                     continue;
                  case "dj":
                     ary = String(this.selectTask.rwaward[alen].value).split("-") as Array;
                     eo = gc.allEquip.findByName(ary[0]);
                     showStr += "您成功领取:" + eo.ename;
                     if(gc.player1.roleid > 0)
                     {
                        gc.putQhsInBackPack(gc.player1,ary[0],ary[1]);
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.putQhsInBackPack(gc.player2,ary[0],ary[1]);
                     }
                     continue;
                  case "gmcs":
                     showStr += "您成功领取5次神秘商店购买机会";
                     gc.dataObject.mysteriousshoptimes += 5;
                     trace("after :gc.getMysteriousShopTimes()---->>" + gc.dataObject.mysteriousshoptimes);
                     continue;
                  case "bxjl":
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.plist.push(gc.allEquip.findByName("p_cybxjl"));
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.plist.push(gc.allEquip.findByName("p_cybxjl"));
                     }
                     showStr += "您成功领取冰雪精灵";
                     continue;
                  case "lhjl":
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.plist.push(gc.allEquip.findByName("p_cylhjl"));
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.plist.push(gc.allEquip.findByName("p_cylhjl"));
                     }
                     showStr += "您成功领取烈火精灵";
                     continue;
                  case "gsjl":
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.plist.push(gc.allEquip.findByName("p_cygsjl"));
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.plist.push(gc.allEquip.findByName("p_cygsjl"));
                     }
                     showStr += "您成功领取钢石精灵";
                     continue;
                  case "ymjl":
                     bool = this.judgePetEquipList();
                     if(bool)
                     {
                        return;
                     }
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.plist.push(gc.allEquip.findByName("p_cyymjl"));
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.plist.push(gc.allEquip.findByName("p_cyymjl"));
                     }
                     showStr += "您成功领取炎马精灵";
                     continue;
                  case "roomhorse":
                     bool = this.judegePetList();
                     if(bool)
                     {
                        return;
                     }
                     if(gc.player1.roleid > 0)
                     {
                        gc.player1.petsAry.push(this.getroomhorsePet());
                     }
                     if(gc.player2.roleid > 0)
                     {
                        gc.player2.petsAry.push(this.getroomhorsePet());
                     }
                     showStr += "您成功领取炎马";
                     break;
               }
            }
            slen = sary.length;
            while(slen-- > 0)
            {
               if(gc.player1.roleid > 0)
               {
                  if(MyEquipObj(sary[slen]).type == "zbwp" || MyEquipObj(sary[slen]).type == "wpqhs")
                  {
                     gc.putQhsInBackPack(gc.player1,MyEquipObj(sary[slen]).getFillName());
                  }
                  else
                  {
                     gc.player1.zblist.push(sary[slen]);
                  }
               }
               if(gc.player2.roleid > 0)
               {
                  if(MyEquipObj(sary[slen]).type == "zbwp" || MyEquipObj(sary[slen]).type == "wpqhs")
                  {
                     gc.putQhsInBackPack(gc.player2,MyEquipObj(sary[slen]).getFillName());
                  }
                  else
                  {
                     gc.player2.zblist.push(sary[slen]);
                  }
               }
            }
         }
         gc.ts.setTxt(showStr);
         gc.stage.addChild(gc.ts);
         this.selectTask.setHasGetAward(true);
         getaward.removeEventListener("click",awardClick);
         getaward.gotoAndStop(1);
         this.setTaskList(curAry);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function judgePetEquipList() : Boolean
      {
         var str:String = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.plist.length >= 15)
            {
               str += "宠物装备栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.plist.length >= 15)
               {
                  str += "宠物装备栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function judegePetList() : Boolean
      {
         var str:String = null;
         str = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function taskAwardAryById() : void
      {
         var newObj:Object = null;
         this.selectTask.rwaward.length = 0;
         var alen:uint = this.selectTask.getAllAward().length;
         var r:uint = Math.round(RandomControllor.getIns().getRandom() * (alen - 1));
         if(this.selectTask.getAllAward()[r])
         {
            newObj = {};
            newObj.type = this.selectTask.getAllAward()[r].type;
            if(this.selectTask.getAllAward()[r].type == "bs")
            {
               newObj.value = this.randomTaskAwardGem(this.selectTask.getAllAward()[r].value);
            }
            else
            {
               newObj.value = this.selectTask.getAllAward()[r].value;
            }
            newObj.cname = this.selectTask.getAllAward()[r].cname;
            this.selectTask.rwaward.push(newObj);
         }
      }
      
      private function randomTaskAwardGem(n:String) : String
      {
         var i:* = 0;
         var s:String = null;
         var qhs:String = "wpqhs";
         var sms:String = "sms";
         var mfs:String = "mfs";
         var gjs:String = "gjs";
         var fys:String = "fys";
         var temp:Array = [];
         i = 0;
         while(i < n.length)
         {
            s = n.substr(i,1);
            temp.push(qhs + s);
            temp.push(sms + s);
            temp.push(mfs + s);
            temp.push(gjs + s);
            temp.push(fys + s);
            i++;
         }
         var tlen:uint = temp.length;
         var r:uint = Math.round(RandomControllor.getIns().getRandom()) * (tlen - 1);
         return temp[r];
      }
      
      private function replaceString(s:String, del:String) : String
      {
         while(s.indexOf(del) != -1)
         {
            s = s.replace(del,"");
         }
         return s;
      }
      
      private function getroomhorsePet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("roomhorse1",1);
         pif.setperception(gc.dataObject.three + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.setwarpower(gc.dataObject.three + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.one));
         pif.settechnique(gc.dataObject.three + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.one));
         pif.sethpQuality((700 + Math.round(RandomControllor.getIns().getRandom() * 500)) * 1.3);
         pif.setmpQuality((550 + Math.round(RandomControllor.getIns().getRandom() * 440)) * 1.3);
         pif.setatkQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * 200)) * 1.3);
         pif.setHp(700);
         pif.setMp(800);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
   }
}
