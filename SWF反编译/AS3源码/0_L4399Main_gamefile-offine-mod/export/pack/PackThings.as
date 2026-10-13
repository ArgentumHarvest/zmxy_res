package export.pack
{
   import base.BaseHero;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.hexagonstar.util.debug.Debug;
   import config.Config;
   import event.CommonEvent;
   import export.level.StageListener101;
   import export.level.StageListener81;
   import export.renewalse.RenewalseThisSZ;
   import export.strength.StrengthEquipment;
   import export.warehouse.WareHouse;
   import export.warehouse.WareHouseElement;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import my.FinancialInfo;
   import my.MainGame;
   import my.MyEquipObj;
   import my.SingleSavedBuff;
   import user.User;
   
   public class PackThings extends Sprite
   {
       
      
      private var gc:Config;
      
      private var sobj:ShowObj;
      
      private var who:uint;
      
      private var threebtn:Sprite;
      
      private var which:uint = 1;
      
      public var txtname:TextField;
      
      private var renewalse:RenewalseThisSZ;
      
      public function PackThings()
      {
         super();
         gc = Config.getInstance();
         txtname.selectable = false;
         txtname.filters = [new GlowFilter(0,1,2,2,255,2,false,false)];
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("rollOut",outHandle);
         this.addEventListener("click",onClick);
         gc.eventManger.addEventListener("CHANGETXT",setTxt);
      }
      
      private function removed(e:*) : void
      {
         this.removeEventListener("rollOut",outHandle);
         this.removeEventListener("click",onClick);
         gc.eventManger.removeEventListener("CHANGETXT",setTxt);
         renewalse = null;
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         GMain.getInstance().getMainSence().addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var p:User = User(gc["player" + this.who]);
         p.isstudyskill[0].skillName = "";
         p.isstudyskill[1].skillName = "";
         p.skillbykey = [];
         this.removeDaoJuSobj();
         gc.eventManger.dispatchEvent(new CommonEvent("InGameBuySkillOver"));
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
      }
      
      private function setTxt(e:Event) : void
      {
         if(this.sobj != null)
         {
            if(this.sobj.getMyEquipObj().getENum() > 1)
            {
               txtname.text = this.sobj.getMyEquipObj().getENum() + "";
            }
            else
            {
               txtname.text = "";
            }
         }
         else
         {
            txtname.text = "";
         }
      }
      
      public function getMyEquipType() : String
      {
         if(this.sobj)
         {
            return this.sobj.getMyEquipObj().type;
         }
         return "";
      }
      
      public function setTxtVisible(enable:Boolean) : void
      {
         this.txtname.visible = enable;
      }
      
      private function outHandle(e:*) : void
      {
         this.removeThreebtn();
      }
      
      private function onClick(e:*) : void
      {
         if(this.sobj != null)
         {
            this.sobj.pulbiremoved();
         }
      }
      
      public function setObj(obj:*, num:uint, _which:uint = 1) : void
      {
         if(obj != null)
         {
            this.which = _which;
            sobj = new ShowObj(obj);
            this.addChild(sobj);
            this.who = num;
            this.setTxt(null);
            sobj.addEventListener("click",clickHandler);
            if(this.getChildIndex(sobj) > this.getChildIndex(txtname))
            {
               this.swapChildren(sobj,txtname);
            }
         }
      }
      
      public function removeSobj() : void
      {
         sobj.removeEventListener("click",clickHandler);
         this.removeChild(sobj);
         var equip:MyEquipObj = sobj.getMyEquipObj();
         this.removeSomeEquip(equip);
         sobj = null;
      }
      
      private function removeSomeEquip(equip:MyEquipObj) : void
      {
         var sit:int = 0;
         if(this.which == 1)
         {
            sit = this.gc["player" + this.who].zblist.indexOf(equip);
            this.gc["player" + who].zblist.splice(sit,1);
         }
         else if(this.which == 2)
         {
            sit = this.gc["player" + this.who].djlist.indexOf(equip);
            this.gc["player" + who].djlist.splice(sit,1);
         }
         else if(this.which == 3)
         {
            sit = this.gc["player" + this.who].szlist.indexOf(equip);
            this.gc["player" + who].szlist.splice(sit,1);
         }
         else if(this.which == 4)
         {
            sit = this.gc["player" + this.who].jnslist.indexOf(equip);
            this.gc["player" + who].jnslist.splice(sit,1);
         }
      }
      
      private function clickHandler(e:MouseEvent) : void
      {
         var equip:* = null;
         var sendFrom:* = null;
         var _fname:* = null;
         var wplayer:* = null;
         if(this.sobj.getMyEquipObj().getFillName() == "yysn")
         {
            return;
         }
         if(this.sobj && contains(this.sobj))
         {
            if(this.parent.parent.parent is BackPack)
            {
               if(this.which == 1 || this.which == 3)
               {
                  this.removeThreebtn();
                  threebtn = AUtils.getNewObj("threebtn");
                  threebtn.x = 25;
                  threebtn.y = 25;
                  this.addChild(threebtn);
                  threebtn["bzb"].addEventListener("click",zbClick);
                  threebtn["bgy"].addEventListener("click",gyClick);
                  threebtn["bmd"].addEventListener("click",mdClick);
                  if(gc.playNum == 1)
                  {
                     threebtn["bgy"].gotoAndStop(2);
                     threebtn["bgy"].removeEventListener("click",gyClick);
                  }
                  if(this.sobj.getMyEquipObj().type == "zbsz")
                  {
                     if(this.sobj.getMyEquipObj().hasPassTime())
                     {
                        threebtn["bzb"].gotoAndStop(3);
                     }
                  }
                  equip = this.sobj.getMyEquipObj();
                  if(equip.user != "")
                  {
                     if(gc["hero" + who].userType != equip.user)
                     {
                        threebtn["bzb"].gotoAndStop(2);
                        threebtn["bzb"].removeEventListener("click",zbClick);
                     }
                  }
                  if(this.who == 3)
                  {
                     threebtn["bmd"].gotoAndStop(2);
                     threebtn["bmd"].removeEventListener("click",mdClick);
                  }
               }
               else if(this.which == 2 || this.which == 4)
               {
                  this.removeThreebtn();
                  if(this.who == 3)
                  {
                     gc.ts.setTxt("该存档无法使用道具和经书！");
                     gc.stage.addChild(gc.ts);
                     return;
                  }
                  threebtn = AUtils.getNewObj("simplebtn");
                  threebtn.name = this.sobj.getMyEquipObj().getFillName();
                  threebtn.x = 25;
                  threebtn.y = 25;
                  this.addChild(threebtn);
                  threebtn["buse"].addEventListener("click",useClick);
                  threebtn["bthrow"].addEventListener("click",throwClick);
                  threebtn["bgy"].addEventListener("click",gyClick);
                  if(gc.playNum == 1)
                  {
                     threebtn["bgy"].gotoAndStop(2);
                     threebtn["bgy"].removeEventListener("click",gyClick);
                  }
                  if(!(this.sobj.getMyEquipObj().getFillName() == "mpyj" || this.sobj.getMyEquipObj().getFillName() == "wpcsd" || this.sobj.getMyEquipObj().getFillName() == "wphhd" || this.sobj.getMyEquipObj().getFillName() == "css6" || this.sobj.getMyEquipObj().getFillName() == "css12" || this.sobj.getMyEquipObj().getFillName() == "css18" || this.sobj.getMyEquipObj().getFillName() == "wplvdyl" || this.sobj.getMyEquipObj().getFillName().indexOf("wpsmd") != -1 || this.sobj.getMyEquipObj().getFillName() == "sbjyd" || this.sobj.getMyEquipObj().getFillName() == "jyys" || this.sobj.getMyEquipObj().getFillName() == "css_2" || this.sobj.getMyEquipObj().getFillName() == "css_3" || this.sobj.getMyEquipObj().getFillName() == "cwjnxld" || this.sobj.getMyEquipObj().getFillName() == "cwzzxld" || this.sobj.getMyEquipObj().getFillName().indexOf("jns") != -1 || this.sobj.getMyEquipObj().getFillName() == "wphtd" || this.sobj.getMyEquipObj().getFillName() == "jyd3" || this.sobj.getMyEquipObj().getFillName() == "djyys" || this.sobj.getMyEquipObj().getFillName() == "xjyys" || this.sobj.getMyEquipObj().getFillName() == "lhys" || this.sobj.getMyEquipObj().getFillName() == "ghyb" || this.sobj.getMyEquipObj().getFillName() == "nianqld" || this.sobj.getMyEquipObj().getFillName() == "nianjhd" || this.sobj.getMyEquipObj().getFillName() == "bmd" || this.sobj.getMyEquipObj().getFillName() == "yp" || this.sobj.getMyEquipObj().getFillName() == "hjxz" || this.sobj.getMyEquipObj().getFillName() == "zsxz" || this.sobj.getMyEquipObj().getFillName() == "ml" || this.sobj.getMyEquipObj().getFillName() == "gz" || this.sobj.getMyEquipObj().getFillName() == "sz" || this.sobj.getMyEquipObj().getFillName() == "zz" || this.sobj.getMyEquipObj().getFillName() == "jbc" || this.sobj.getMyEquipObj().getFillName() == "szj" || this.sobj.getMyEquipObj().getFillName() == "nianjhdd" || this.sobj.getMyEquipObj().getFillName() == "cdjyys" || this.sobj.getMyEquipObj().getFillName() == "dlhys"))
                  {
                     threebtn["buse"].gotoAndStop(2);
                     threebtn["buse"].removeEventListener("click",useClick);
                  }
               }
            }
            else if(this.parent.parent.parent is StrengthEquipment)
            {
               if(this.sobj.getMyEquipObj().getFillName().indexOf("jns") != -1)
               {
                  return;
               }
               gc.eventManger.dispatchEvent(new CommonEvent("SimpleClick",[this.sobj]));
            }
            else if(this.parent.parent.parent is WareHouse)
            {
               if(this.sobj.getMyEquipObj().getFillName().indexOf("jns") != -1)
               {
                  return;
               }
               if(this.sobj.getMyEquipObj().getFillName() == "clj" || this.sobj.getMyEquipObj().getFillName() == "psdclj")
               {
                  gc.ts.setTxt("该装备不能放入仓库！");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               if(this.sobj.getMyEquipObj().type == "zbtx")
               {
                  gc.ts.setTxt("该装备不能在仓库操作！");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               sendFrom = "";
               if(this.parent.parent is BackPackElement)
               {
                  sendFrom = "BackPackElement";
                  if(this.sobj.getMyEquipObj().type == "zbwq" || this.sobj.getMyEquipObj().type == "zbfj" || this.sobj.getMyEquipObj().type == "zbfb" || this.sobj.getMyEquipObj().type == "zbsp")
                  {
                     if(gc.zblist.length >= 25)
                     {
                        gc.ts.setTxt("仓库装备栏已满");
                        gc.stage.addChild(gc.ts);
                        return;
                     }
                  }
                  else if(this.sobj.getMyEquipObj().type == "zbsz")
                  {
                     if(gc.szlist.length >= 25)
                     {
                        gc.ts.setTxt("仓库时装栏已满");
                        gc.stage.addChild(gc.ts);
                        return;
                     }
                  }
                  else
                  {
                     _fname = this.sobj.getMyEquipObj().getFillName();
                     if(gc.getSomeOneEquipNumberByName(_fname) <= 0 && gc.djlist.length >= 25)
                     {
                        wplayer = "玩家一";
                        if(User(gc["player" + this.who]).controlPlayer == 0)
                        {
                           wplayer = "玩家一";
                        }
                        else
                        {
                           wplayer = "玩家二";
                        }
                        gc.ts.setTxt(wplayer + "背包道具已满!");
                        gc.stage.addChild(gc.ts);
                        return;
                     }
                  }
               }
               else if(this.parent.parent is WareHouseElement)
               {
                  sendFrom = "WareHouseElement";
                  if(this.sobj.getMyEquipObj().type == "zbwq" || this.sobj.getMyEquipObj().type == "zbfj" || this.sobj.getMyEquipObj().type == "zbfb" || this.sobj.getMyEquipObj().type == "zbsp")
                  {
                     if(gc.judgeBackPack(gc["player" + this.who],"zblist"))
                     {
                        return;
                     }
                  }
                  else if(this.sobj.getMyEquipObj().type == "zbsz")
                  {
                     if(gc.judgeBackPack(gc["player" + this.who],"szlist"))
                     {
                        return;
                     }
                  }
                  else if(gc.judgeDJBackPack(gc["player" + this.who],this.sobj.getMyEquipObj().getFillName()))
                  {
                     return;
                  }
               }
               WareHouse(this.parent.parent.parent).operatingPack(sendFrom,this.sobj.getMyEquipObj());
               if(sendFrom == "BackPackElement")
               {
                  this.removeSobj();
                  this.setTxt(null);
               }
            }
         }
      }
      
      private function throwClick(e:MouseEvent) : void
      {
         this.removeThreebtn();
         this.removeSobj();
         this.setTxt(null);
      }
      
      private function zbClick(e:MouseEvent) : *
      {
         if(e.currentTarget.currentFrame == 3)
         {
            if(this.parent.parent.parent is BackPack)
            {
               if(this.who == 3)
               {
                  gc.ts.setTxt("该角色无法续费！");
                  gc.stage.addChild(gc.ts);
               }
               else
               {
                  BackPack(this.parent.parent.parent).addRenewalseMask(this.sobj.getMyEquipObj(),this.sobj.getMyEquipObj().ename);
               }
            }
         }
         else
         {
            if(this.sobj.getMyEquipObj().getFillName() == "wpfbyyin" || this.sobj.getMyEquipObj().getFillName() == "wpfbyyan" || this.sobj.getMyEquipObj().getFillName() == "wpfbtc")
            {
               gc.ts.setTxt("该装备不能穿戴");
               gc.stage.addChild(gc.ts);
               return;
            }
            this.usezb();
         }
         this.removeThreebtn();
      }
      
      private function gyClick(e:MouseEvent) : *
      {
         trace("this.sobj.getMyEquipObj().type -->>" + this.sobj.getMyEquipObj().type);
         if(this.sobj.getMyEquipObj().getFillName() == "clj" || this.sobj.getMyEquipObj().getFillName() == "psdclj")
         {
            gc.ts.setTxt("该装备不能赠送");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            if(this.who == 1)
            {
               if(this.sobj.getMyEquipObj().type == "zbsz" || this.sobj.getMyEquipObj().type == "zbcb")
               {
                  gc.player2.szlist.push(this.sobj.getMyEquipObj());
               }
               else if(this.sobj.getMyEquipObj().type == "zbwp" || this.sobj.getMyEquipObj().type == "wpqhs")
               {
                  gc.putQhsInBackPack(gc.player2,this.sobj.getMyEquipObj().getFillName(),this.sobj.getMyEquipObj().getENum());
               }
               else
               {
                  gc.player2.zblist.push(this.sobj.getMyEquipObj());
               }
            }
            else if(this.who == 2)
            {
               if(this.sobj.getMyEquipObj().type == "zbsz" || this.sobj.getMyEquipObj().type == "zbcb")
               {
                  gc.player1.szlist.push(this.sobj.getMyEquipObj());
               }
               else if(this.sobj.getMyEquipObj().type == "zbwp" || this.sobj.getMyEquipObj().type == "wpqhs")
               {
                  gc.putQhsInBackPack(gc.player1,this.sobj.getMyEquipObj().getFillName(),this.sobj.getMyEquipObj().getENum());
               }
               else
               {
                  gc.player1.zblist.push(this.sobj.getMyEquipObj());
               }
            }
            this.removeSobj();
         }
         this.removeThreebtn();
         this.setTxt(null);
      }
      
      private function mdClick(e:MouseEvent) : *
      {
         if(this.parent.parent.parent is BackPack)
         {
            User(this.gc["player" + who]).setLhValue(User(this.gc["player" + who]).getLhValue() + this.sobj.getMyEquipObj().getValue());
            User(this.gc["player" + who]).setMyScore(User(this.gc["player" + who]).getMyScore() + this.sobj.getMyEquipObj().getValue());
            BackPack(this.parent.parent.parent).setInfoTxt();
         }
         this.removeThreebtn();
         this.removeSobj();
      }
      
      private function useClick(e:MouseEvent) : void
      {
         var sn:* = null;
         var sl:* = null;
         var skObj:* = null;
         var wid:int = 0;
         var ssb:* = null;
         ssb = null;
         var bh:* = null;
         var anti:* = null;
         bh = null;
         anti = null;
         bh = null;
         anti = null;
         bh = null;
         anti = null;
         var dayAry1:* = null;
         var year1:* = 0;
         var month1:* = 0;
         var day1:* = 0;
         var date1:* = null;
         var hpssb:* = null;
         var nmwsz:* = null;
         var s:Sprite = e.currentTarget.parent as Sprite;
         var used:Boolean = true;
         var _issave:Boolean = false;
         var _refresh:Boolean = false;
         var p:User = User(gc["player" + this.who]);
         if(s.name == "mpyj")
         {
            used = false;
            this.addRenewalseMask("确定遗忘所有技能包括高级技能吗?");
         }
         else if(s.name == "wphhd")
         {
            if(p.findCurrentPet(true))
            {
               p.findCurrentPet(true).reSetPetState();
               BaseHero(gc["hero" + this.who]).changePet();
            }
         }
         else if(s.name == "wpcsd")
         {
            p.findCurrentPet(true).setlifetime(p.findCurrentPet(true).getlifetime() + 20);
            if(p.findCurrentPet(true).getlifetime() > 100)
            {
               p.findCurrentPet(true).setlifetime(100);
            }
         }
         else if(s.name.indexOf("jns") != -1)
         {
            sn = s.name.substr(0,s.name.length - 4);
            sl = s.name.substr(s.name.length - 1,1);
            trace("sn -->>" + sn);
            trace("sl -->>" + sl);
            skObj = p.returnSkillIsInTheSkillAry(sn);
            trace("skObj -->>" + skObj);
            if(skObj != null)
            {
               if(sl == "2")
               {
                  trace("skObj.slev  -->>" + skObj.slev);
                  if(skObj.slev < 2)
                  {
                     this.beforeJNSSuccess(s.name);
                     skObj.slev = 2;
                     p.setSkillLevelInTheAllSkillAry(sn,2);
                     gc.ts.setTxt("技能提升");
                     this.useJNSSuccess(s.name);
                     gc.eventManger.dispatchEvent(new CommonEvent("RefreshBackpackTxt"));
                  }
                  else
                  {
                     gc.ts.setTxt("您已经使用过该技能书");
                     used = false;
                  }
                  gc.stage.addChild(gc.ts);
               }
               else if(sl == "3")
               {
                  if(skObj.slev >= 2)
                  {
                     if(skObj.slev < 3)
                     {
                        this.beforeJNSSuccess(s.name);
                        skObj.slev = 3;
                        p.setSkillLevelInTheAllSkillAry(sn,3);
                        gc.ts.setTxt("技能提升");
                        this.useJNSSuccess(s.name);
                        gc.eventManger.dispatchEvent(new CommonEvent("RefreshBackpackTxt"));
                     }
                     else
                     {
                        gc.ts.setTxt("您已经使用过该技能书");
                        used = false;
                     }
                  }
                  else
                  {
                     gc.ts.setTxt("该技能需要先提升到2级");
                     used = false;
                  }
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("您还没学习该技能");
               gc.stage.addChild(gc.ts);
               used = false;
            }
         }
         else if(s.name == "css6")
         {
            if(gc.curStageAndCurLevel.curStage != 8)
            {
               gc.ts.setTxt("必须在玲珑宝塔中使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.pWorld.getBaseLevelListener() is StageListener81)
            {
               StageListener81(gc.pWorld.getBaseLevelListener()).gotoLevel(6);
            }
         }
         else if(s.name == "css12")
         {
            if(gc.curStageAndCurLevel.curStage != 8)
            {
               gc.ts.setTxt("必须在玲珑宝塔中使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.pWorld.getBaseLevelListener() is StageListener81)
            {
               StageListener81(gc.pWorld.getBaseLevelListener()).gotoLevel(12);
            }
         }
         else if(s.name == "css18")
         {
            if(gc.curStageAndCurLevel.curStage != 8)
            {
               gc.ts.setTxt("必须在玲珑宝塔中使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.pWorld.getBaseLevelListener() is StageListener81)
            {
               StageListener81(gc.pWorld.getBaseLevelListener()).gotoLevel(18);
            }
         }
         else if(s.name == "wplvdyl")
         {
            if(gc.curStageAndCurLevel.curLevel >= 7 && gc.curStageAndCurLevel.curStage == 10)
            {
               gc.ts.setTxt("该关卡无法使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.curStageAndCurLevel.curStage != 10)
            {
               gc.ts.setTxt("必须在水下迷宫中使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.pWorld.getBaseLevelListener() is StageListener101)
            {
               StageListener101(gc.pWorld.getBaseLevelListener()).gotoLevel(7);
            }
         }
         else if(s.name.indexOf("wpsmd") != -1)
         {
            wid = int(s.name.substr(5,1));
            if(User(this.gc["player" + who]).immortalitylist[wid - 1].usenum < wid + 1)
            {
               User(this.gc["player" + who]).immortalitylist[wid - 1].usenum = User(this.gc["player" + who]).immortalitylist[wid - 1].usenum + 1;
               gc.eventManger.dispatchEvent(new CommonEvent("RefreshPill"));
            }
            else
            {
               used = false;
               gc.ts.setTxt("该种丹药服用已经到上限");
               gc.stage.addChild(gc.ts);
            }
         }
         else if(s.name == "sbjyd")
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_EXP_ADD);
            if(ssb)
            {
               gc.ts.setTxt("已经存在经验加成效果");
               gc.stage.addChild(gc.ts);
               return;
            }
            gc.savedBuff.addBuff(SingleSavedBuff.BUFF_EXP_ADD,2,3600 * gc.frameClips);
            gc.ts.setTxt("双倍经验生效");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "jyd3")
         {
            ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_EXP_ADD);
            if(ssb)
            {
               gc.ts.setTxt("已经存在经验加成效果");
               gc.stage.addChild(gc.ts);
               return;
            }
            gc.savedBuff.addBuff(SingleSavedBuff.BUFF_EXP_ADD,3,3600 * gc.frameClips);
            gc.ts.setTxt("三倍经验生效");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "xjyys")
         {
            bh = gc["hero" + who] as BaseHero;
            anti = new Antiwear(new binaryEncrypt());
            anti.yiwan = 2500;
            bh.roleProperies.dispatchEvent(new CommonEvent("AddExper",[anti.yiwan]));
            gc.ts.setTxt("增加经验2500点");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "lhys")
         {
            this.gc["player" + who].setLhValue(this.gc["player" + who].getLhValue() + 3800);
            BackPack(this.parent.parent.parent).setInfoTxt();
            gc.ts.setTxt("增加3800灵魂");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "dlhys")
         {
            this.gc["player" + who].setLhValue(this.gc["player" + who].getLhValue() + 75000);
            BackPack(this.parent.parent.parent).setInfoTxt();
            gc.ts.setTxt("增加75000灵魂");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "jyys")
         {
            bh = gc["hero" + who] as BaseHero;
            anti = new Antiwear(new binaryEncrypt());
            anti.yiwan = 10000;
            bh.roleProperies.dispatchEvent(new CommonEvent("AddExper",[anti.yiwan]));
            gc.ts.setTxt("增加经验10000点");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "djyys")
         {
            bh = gc["hero" + who] as BaseHero;
            anti = new Antiwear(new binaryEncrypt());
            anti.yiwan = 100000;
            bh.roleProperies.dispatchEvent(new CommonEvent("AddExper",[anti.yiwan]));
            gc.ts.setTxt("增加经验100000点");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "cdjyys")
         {
            bh = gc["hero" + who] as BaseHero;
            anti = new Antiwear(new binaryEncrypt());
            anti.wushiwan = 500000;
            bh.roleProperies.dispatchEvent(new CommonEvent("AddExper",[anti.wushiwan]));
            gc.ts.setTxt("增加经验500000点");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "css_2")
         {
            if(gc.curStageAndCurLevel.curStage != 12)
            {
               gc.ts.setTxt("必须在兜率宫中使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            gc.curStageAndCurLevel.curLevel = 3;
         }
         else if(s.name == "css_3")
         {
            if(gc.curStageAndCurLevel.curStage != 12)
            {
               gc.ts.setTxt("必须在兜率宫中使用！");
               gc.stage.addChild(gc.ts);
               return;
            }
            gc.curStageAndCurLevel.curLevel = 4;
         }
         else if(s.name == "cwzzxld")
         {
            if(User(this.gc["player" + who]).findCurrentPet(true) == null)
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            User(this.gc["player" + who]).findCurrentPet(true).refreshTherrAttributeByImmortality();
            _issave = true;
         }
         else if(s.name == "cwjnxld")
         {
            if(User(this.gc["player" + who]).findCurrentPet(true) == null)
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            User(this.gc["player" + who]).findCurrentPet(true).refreshPetAllSkillByLevel();
            _issave = true;
         }
         else if(s.name == "wphtd")
         {
            if(User(this.gc["player" + who]).findCurrentPet(true) == null)
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            User(this.gc["player" + who]).findCurrentPet(true).makePetBecomeChild();
            if(gc.hero1)
            {
               if(gc.hero1.getPlayer() == this.gc["player" + who])
               {
                  gc.hero1.changePet();
               }
            }
            if(gc.hero2)
            {
               if(gc.hero2.getPlayer() == this.gc["player" + who])
               {
                  gc.hero2.changePet();
               }
            }
            gc.eventManger.dispatchEvent(new CommonEvent("CHANGECURRENTPET"));
            _issave = true;
         }
         else if(s.name == "nianqld")
         {
            if(User(this.gc["player" + who]).findCurrentPet(true) == null)
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getPetPreName() != "nian")
            {
               gc.ts.setTxt("该丹药只有年兽可以服用");
               gc.stage.addChild(gc.ts);
               return;
            }
            User(this.gc["player" + who]).findCurrentPet(true).setpotential(User(this.gc["player" + who]).findCurrentPet(true).getpotential() + 100);
            _issave = true;
            gc.ts.setTxt("服用成功!");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "nianjhd")
         {
            if(User(this.gc["player" + who]).findCurrentPet(true) == null)
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getPetPreName() != "nian")
            {
               gc.ts.setTxt("该丹药只有年兽可以服用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getCurPetState() == 4)
            {
               gc.ts.setTxt("该宠物已经是第二形态");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getCurPetState() >= 5)
            {
               gc.ts.setTxt("该宠物的第三形态不能服用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getLevel() < 32)
            {
               gc.ts.setTxt("该丹药服用需要宠物达到32级以上");
               gc.stage.addChild(gc.ts);
               return;
            }
            User(this.gc["player" + who]).findCurrentPet(true).theFourShape(true);
            _issave = true;
            gc.ts.setTxt("服用成功!");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "nianjhdd")
         {
            if(User(this.gc["player" + who]).findCurrentPet(true) == null)
            {
               gc.ts.setTxt("你还没有出战的宠物");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getPetPreName() != "nian")
            {
               gc.ts.setTxt("该丹药只有年兽可以服用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getCurPetState() >= 5)
            {
               gc.ts.setTxt("该宠物已经是第三形态");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getCurPetState() != 4)
            {
               gc.ts.setTxt("该丹药服用需要宠物达到第二形态");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(User(this.gc["player" + who]).findCurrentPet(true).getLevel() < 50)
            {
               gc.ts.setTxt("该丹药服用需要宠物达到50级以上");
               gc.stage.addChild(gc.ts);
               return;
            }
            User(this.gc["player" + who]).findCurrentPet(true).theFiveShape();
            _issave = true;
            gc.ts.setTxt("服用成功!");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "ghyb")
         {
            dayAry1 = gc.dataObjectInstance.curDate.split("-");
            year1 = uint(int(dayAry1[0]));
            month1 = uint(int(dayAry1[1]) - 1);
            day1 = uint(int(dayAry1[2]));
            date1 = new Date(year1,month1,day1);
            hpssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_ATK_ADD);
            if(hpssb)
            {
               gc.ts.setTxt("已经存在攻击加成效果");
               gc.stage.addChild(gc.ts);
               return;
            }
            gc.savedBuff.addBuff(SingleSavedBuff.BUFF_ATK_ADD,300,3600 * gc.frameClips);
            gc.ts.setTxt("攻击加成生效");
            gc.stage.addChild(gc.ts);
         }
         else if(s.name == "hjxz")
         {
            gc.putQhsInBackPack(this.gc["player" + who],"wpqhs1",3);
            gc.ts.setTxt("成功兑换三个1级强化石");
            gc.stage.addChild(gc.ts);
            _issave = true;
            _refresh = true;
         }
         else if(s.name == "zsxz")
         {
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            this.gc["player" + who].szlist.push(nmwsz);
            gc.ts.setTxt("成功兑换一件牛魔王时装");
            gc.stage.addChild(gc.ts);
            _issave = true;
         }
         else if(s.name == "bmd")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(163,500,300);
         }
         else if(s.name == "yp")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(165,500,300);
         }
         else if(s.name == "gz")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(164,500,300);
         }
         else if(s.name == "ml")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(168,500,300);
         }
         else if(s.name == "sz")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(166,500,300);
         }
         else if(s.name == "zz")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(169,500,300);
         }
         else if(s.name == "jbc")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(174,500,300);
         }
         else if(s.name == "szj")
         {
            if(gc.curStageAndCurLevel.curStage != 50)
            {
               gc.ts.setTxt("该道具只能在八仙副本中使用");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(gc.gameInfo.bossBloodArray.length != 1)
            {
               gc.ts.setTxt("您已经不能再召唤BOSS了");
               gc.stage.addChild(gc.ts);
               return;
            }
            MainGame.getInstance().createMonster(175,500,300);
         }
         this.removeThreebtn();
         if(used)
         {
            this.removeDaoJuSobj();
         }
         if(_refresh)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK"));
         }
         if(_issave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         if(s.name == "css_2" || s.name == "css_3")
         {
            gc.eventManger.dispatchEvent(new Event("USETRANSFERSTONE"));
         }
      }
      
      private function useJNSSuccess(name:String) : void
      {
         if(name.indexOf("sxjns") != -1)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("addjnsBuff"));
         }
      }
      
      private function beforeJNSSuccess(name:String) : void
      {
         if(name.indexOf("sxjns") != -1)
         {
            gc.eventManger.dispatchEvent(new CommonEvent("removejnsBuff"));
         }
      }
      
      public function removeDaoJuSobj() : void
      {
         var equip:* = null;
         var sit:int = 0;
         sit = 0;
         if(sobj.getMyEquipObj().getENum() > 1)
         {
            if(gc.isHideDebug)
            {
               this.doSendAction(sobj.getMyEquipObj().getENum() - 1);
            }
            sobj.getMyEquipObj().setNum(-1);
         }
         else
         {
            sobj.removeEventListener("click",clickHandler);
            this.removeChild(sobj);
            equip = sobj.getMyEquipObj();
            if(this.which == 2)
            {
               if(gc.isHideDebug)
               {
                  this.doSendAction(0);
               }
               sit = this.gc["player" + this.who].djlist.indexOf(equip);
               this.gc["player" + who].djlist.splice(sit,1);
            }
            else
            {
               sit = this.gc["player" + this.who].jnslist.indexOf(equip);
               this.gc["player" + who].jnslist.splice(sit,1);
            }
            equip = null;
            sobj = null;
         }
         this.setTxt(null);
      }
      
      private function doSendAction(_lastNum:int) : void
      {
         var obj:* = null;
         var fid:uint = FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName());
         var sellobj:Object = FinancialInfo.getSellObjectById(fid,sobj.getMyEquipObj().getFillName());
         if(sellobj && sellobj.prop_type == 1)
         {
            obj = [];
            if(sobj.getMyEquipObj().getShopAttribtue() >= 1)
            {
               sobj.getMyEquipObj().setShopAttribute(sobj.getMyEquipObj().getShopAttribtue() - 1);
               obj.push(FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),0));
               obj.push(0);
               obj.push(1);
               obj.push(_lastNum);
            }
            else
            {
               obj.push(FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),1));
               obj.push(0);
               obj.push(1);
               obj.push(_lastNum);
            }
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[obj],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
      }
      
      public function removeThreebtn() : void
      {
         if(threebtn && contains(threebtn))
         {
            if(threebtn["bzb"])
            {
               threebtn["bzb"].removeEventListener("click",zbClick);
            }
            if(threebtn["bgy"])
            {
               threebtn["bgy"].removeEventListener("click",gyClick);
            }
            if(threebtn["bmd"])
            {
               threebtn["bmd"].removeEventListener("click",mdClick);
            }
            if(threebtn["buse"])
            {
               threebtn["buse"].removeEventListener("click",useClick);
            }
            if(threebtn["bthrow"])
            {
               threebtn["bthrow"].removeEventListener("click",throwClick);
            }
            this.removeChild(threebtn);
            threebtn = null;
         }
      }
      
      public function removeSobjAndNotPutInBack() : void
      {
         if(sobj)
         {
            sobj.removeEventListener("click",clickHandler);
            this.removeChild(sobj);
            sobj = null;
         }
      }
      
      public function getSobj() : ShowObj
      {
         return this.sobj;
      }
      
      private function usezb() : void
      {
         var cEquip:* = null;
         var temp:* = null;
         if(this.parent.parent.parent is BackPack)
         {
            cEquip = sobj.getMyEquipObj();
            temp = gc.allEquip.findByName(cEquip.getFillName());
            if(temp.type != cEquip.type)
            {
               gc.ts.setTxt("装备类型不符合");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(cEquip.type == "zbfb")
            {
               if(BaseHero(gc["hero" + this.who]) && BaseHero(gc["hero" + this.who]).getCurMagicWeapon() && BaseHero(gc["hero" + this.who]).getCurMagicWeapon().isUsing())
               {
                  gc.ts.setTxt("当前法宝正在使用");
                  gc.stage.addChild(gc.ts);
               }
               else
               {
                  this.removeSobj();
                  BackPack(this.parent.parent.parent).equip(cEquip.type,cEquip);
               }
            }
            else
            {
               this.removeSobj();
               BackPack(this.parent.parent.parent).equip(cEquip.type,cEquip);
            }
         }
         else
         {
            Debug.trace("not in BackPack");
         }
      }
   }
}
