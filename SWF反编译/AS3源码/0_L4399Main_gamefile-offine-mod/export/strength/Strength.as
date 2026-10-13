package export.strength
{
   import config.Config;
   import event.CommonEvent;
   import export.pack.ShowObj;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   import my.MyEquipObj;
   import user.User;
   
   public class Strength extends Sprite
   {
       
      
      private var gc:Config;
      
      private var curWepon:ShowObj;
      
      private var player:User;
      
      public var qhbtn:SimpleButton;
      
      public var qhmc1:Sprite;
      
      public var qhmc2:Sprite;
      
      public var qhmc3:Sprite;
      
      public var zbmc:Sprite;
      
      public var luckmc:Sprite;
      
      public var baodimc:Sprite;
      
      public var txt_needlh:TextField;
      
      public var txt_success:TextField;
      
      private var cobj:Object;
      
      private var tag:Boolean = true;
      
      private var sendlist:Array;
      
      public function Strength(_player:User)
      {
         cobj = {"allpro":0};
         sendlist = [];
         super();
         gc = Config.getInstance();
         this.player = _player;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(tag)
         {
            tag = false;
            this.player.outlist = [];
            this.sendlist = [];
            this.txt_needlh.text = "100";
            gc.eventManger.addEventListener("SimpleClick",receiveObj);
            qhmc1.addEventListener("click",onClick);
            qhmc2.addEventListener("click",onClick);
            qhmc3.addEventListener("click",onClick);
            zbmc.addEventListener("click",onClick);
            luckmc.addEventListener("click",onClick);
            baodimc.addEventListener("click",onClick);
            qhbtn.addEventListener("click",qhClick);
         }
      }
      
      private function removed(e:Event) : void
      {
         this.player.outlist = [];
         this.sendlist = [];
         gc.eventManger.removeEventListener("SimpleClick",receiveObj);
         qhmc1.removeEventListener("click",onClick);
         qhmc2.removeEventListener("click",onClick);
         qhmc3.removeEventListener("click",onClick);
         zbmc.removeEventListener("click",onClick);
         luckmc.removeEventListener("click",onClick);
         baodimc.removeEventListener("click",onClick);
         qhbtn.removeEventListener("click",qhClick);
         this.removedSelf();
      }
      
      private function receiveObj(e:CommonEvent) : void
      {
         var temp:* = null;
         trace("receiveObj");
         var sobj:ShowObj = e.data[0] as ShowObj;
         if(sobj.getMyEquipObj().type == "zbtx")
         {
            gc.ts.setTxt("该装备不能强化");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(sobj.getMyEquipObj().getFillName() == "cs_sp_hy")
         {
            gc.ts.setTxt("该装备暂时不能强化");
            gc.stage.addChild(gc.ts);
            return;
         }
         trace("sobj.getMyEquipObj().type:" + sobj.getMyEquipObj().type);
         switch(sobj.getMyEquipObj().type)
         {
            case "zbwq":
            case "zbfj":
            case "zbsp":
            case "zbsz":
               if(zbmc.getChildByName("curzb") == null)
               {
                  zbmc.addChild(sobj);
                  this.curWepon = sobj;
                  if(sobj.getMyEquipObj().type == "zbsz")
                  {
                     this.removeEquipFormBack(sobj.getMyEquipObj(),3);
                  }
                  else
                  {
                     this.removeEquipFormBack(sobj.getMyEquipObj(),1);
                  }
               }
               else
               {
                  temp = zbmc.getChildByName("curzb") as ShowObj;
                  if(gc.allEquip.isTheSameEquipmentByFillName(temp.getMyEquipObj()))
                  {
                     zbmc.removeChild(temp);
                     if(temp.getMyEquipObj().type == "zbsz")
                     {
                        this.player.szlist.push(temp.getMyEquipObj());
                     }
                     else
                     {
                        this.player.zblist.push(temp.getMyEquipObj());
                     }
                     temp = null;
                     zbmc.addChild(sobj);
                     this.curWepon = null;
                     this.curWepon = sobj;
                     if(sobj.getMyEquipObj().type == "zbsz")
                     {
                        this.removeEquipFormBack(sobj.getMyEquipObj(),3);
                     }
                     else
                     {
                        this.removeEquipFormBack(sobj.getMyEquipObj(),1);
                     }
                  }
                  else
                  {
                     gc.ts.setTxt("不是同一个物品，请勿修改");
                     gc.stage.addChild(gc.ts);
                  }
               }
               this.changeLuck();
               break;
            case "":
               if(qhmc1.numChildren < 2)
               {
                  qhmc1.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
                  this.changeLuck();
               }
               else if(qhmc2.numChildren < 2)
               {
                  qhmc2.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
                  this.changeLuck();
               }
               else if(qhmc3.numChildren < 2)
               {
                  qhmc3.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
                  this.changeLuck();
               }
               break;
            case "wpqhs":
               if(sobj.getMyEquipObj().getFillName() == "wpxyf")
               {
                  if(luckmc.getChildByName("curzb") != null)
                  {
                     return;
                  }
                  luckmc.addChild(sobj);
                  this.changeLuck();
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               else if(sobj.getMyEquipObj().getFillName() == "wpbdf")
               {
                  if(baodimc.getChildByName("curzb") != null)
                  {
                     return;
                  }
                  baodimc.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               break;
            case "zbwp":
         }
         this.getOutEquip();
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
      }
      
      private function getOutEquip() : void
      {
         var sobj:* = null;
         var i:* = 0;
         this.player.outlist = [];
         if(this.zbmc.getChildByName("curzb"))
         {
            sobj = this.zbmc.getChildByName("curzb") as ShowObj;
            this.player.outlist.push({
               "dequip":sobj.getMyEquipObj(),
               "count":1
            });
            sobj = null;
         }
         for(i = uint(0); i < 3; )
         {
            if(this["qhmc" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["qhmc" + (i + 1)].getChildByName("curzb") as ShowObj;
               this.player.outlist.push({
                  "dequip":sobj.getMyEquipObj(),
                  "count":1
               });
               sobj = null;
            }
            i++;
         }
         if(this.luckmc.getChildByName("curzb"))
         {
            sobj = this.luckmc.getChildByName("curzb") as ShowObj;
            this.player.outlist.push({
               "dequip":sobj.getMyEquipObj(),
               "count":1
            });
            sobj = null;
         }
         if(this.baodimc.getChildByName("curzb"))
         {
            sobj = this.baodimc.getChildByName("curzb") as ShowObj;
            this.player.outlist.push({
               "dequip":sobj.getMyEquipObj(),
               "count":1
            });
            sobj = null;
         }
      }
      
      private function judgeallpro() : void
      {
         if(cobj.allpro > 1)
         {
            cobj = AUtils.clone(cobj);
            cobj.allpro = 1;
         }
      }
      
      private function changeLuck() : void
      {
         var sobj:* = null;
         var i:int = 0;
         var spro:Number = NaN;
         var add:Number = NaN;
         trace("--changeLuck--");
         cobj = AUtils.clone(cobj);
         cobj.allpro = 0;
         if(this.curWepon)
         {
            for(i = 1; i <= 3; )
            {
               if(this["qhmc" + i].getChildByName("curzb") != null)
               {
                  sobj = this["qhmc" + i].getChildByName("curzb");
                  spro = gc.allEquip.getStrengthNumber(sobj.getMyEquipObj(),this.curWepon.getMyEquipObj());
                  cobj.allpro += spro;
                  this.judgeallpro();
                  this.txt_success.text = Math.floor(cobj.allpro * 100) + "%";
               }
               i++;
            }
            if(luckmc.getChildByName("curzb") != null)
            {
               add = cobj.allpro * 0.25;
               cobj = AUtils.clone(cobj);
               cobj.allpro += add;
               this.judgeallpro();
               this.txt_success.text = Math.floor(cobj.allpro * 100) + "%";
            }
         }
         else
         {
            this.txt_success.text = Math.floor(cobj.allpro * 100) + "%";
         }
      }
      
      private function removeEquipFormBack(equip:MyEquipObj, pack:int) : void
      {
         var sit:int = 0;
         if(pack == 1)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.zblist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.zblist.splice(sit,1);
               }
            }
         }
         else if(pack == 2)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.djlist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.djlist.splice(sit,1);
               }
            }
         }
         else if(pack == 3)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.szlist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.szlist.splice(sit,1);
               }
            }
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         var temp:* = null;
         if(e.currentTarget.getChildByName("curzb") != null)
         {
            temp = e.currentTarget.getChildByName("curzb") as ShowObj;
            e.currentTarget.removeChild(temp);
            switch(temp.getMyEquipObj().type)
            {
               case "zbwq":
               case "zbfj":
               case "zbsp":
                  if(gc.allEquip.isTheSameEquipmentByFillName(temp.getMyEquipObj()))
                  {
                     this.player.zblist.push(temp.getMyEquipObj());
                     this.changeLuck();
                     this.curWepon = null;
                  }
                  else
                  {
                     gc.ts.setTxt("不是同一个物品，请勿修改");
                     gc.stage.addChild(gc.ts);
                  }
                  break;
               case "":
                  if(temp.getMyEquipObj().ename.indexOf("装") != -1)
                  {
                     this.player.szlist.push(temp.getMyEquipObj());
                     this.changeLuck();
                     this.curWepon = null;
                  }
                  break;
               case "zbsz":
                  if(temp.getMyEquipObj().ename.indexOf("强化石") != -1)
                  {
                     if(temp.getMyEquipObj().getShopAttribtue() == 1 && temp.getMyEquipObj().getENum() == 1)
                     {
                        gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName(),1,true,false);
                     }
                     else
                     {
                        gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                     }
                     if(curWepon != null)
                     {
                        this.changeLuck();
                     }
                  }
                  break;
               case "wpqhs":
                  if(temp.getMyEquipObj().ename.indexOf("幸运") != -1 || temp.getMyEquipObj().ename.indexOf("神恩") != -1)
                  {
                     if(temp.getMyEquipObj().getFillName() == "wpxyf")
                     {
                        if(temp.getMyEquipObj().getShopAttribtue() == 1 && temp.getMyEquipObj().getENum() == 1)
                        {
                           gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName(),1,true,false);
                        }
                        else
                        {
                           gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                        }
                        this.changeLuck();
                     }
                     else if(temp.getMyEquipObj().getFillName() == "wpbdf")
                     {
                        if(temp.getMyEquipObj().getShopAttribtue() == 1 && temp.getMyEquipObj().getENum() == 1)
                        {
                           gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName(),1,true,false);
                        }
                        else
                        {
                           gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                        }
                     }
                  }
                  break;
               case "zbwp":
            }
            this.getOutEquip();
            gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
            temp = null;
         }
      }
      
      private function findIfQHS() : Boolean
      {
         var i:* = 0;
         for(i = uint(0); i < 3; )
         {
            if(this["qhmc" + (i + 1)].getChildByName("curzb") != null)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function qhClick(e:MouseEvent) : void
      {
         trace("qhClick");
         if(gc.isHideDebug)
         {
            doStrength();
         }
         else
         {
            this.doStrength();
         }
      }
      
      private function doStrength() : void
      {
         if(!this.findIfQHS())
         {
            return;
         }
         if(this.curWepon)
         {
            if(this.player.getLhValue() < 100)
            {
               gc.ts.setTxt("需要100灵魂");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(this.curWepon.getMyEquipObj().getStrengthValue() >= 7)
            {
               gc.ts.setTxt("已经强化到上限");
               gc.stage.addChild(gc.ts);
               return;
            }
            this.player.setLhValue(this.player.getLhValue() - 100);
            StrengthEquipment(this.parent).setTxtlh();
            this.afterReadStore();
            this.clearAllThingExceptWeapen();
            this.curWepon = null;
            if(gc.isHideDebug)
            {
               if(this.sendlist.length > 0)
               {
                  FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,this.sendlist,gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
                  this.sendlist = [];
               }
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function afterReadStore() : void
      {
         trace("cobj.allpro:" + cobj.allpro);
         if(RandomControllor.getIns().getRandom() < cobj.allpro)
         {
            trace("强化成功");
            gc.ts.setTxt("强化成功");
            this.curWepon.getMyEquipObj().upStrengthValue(1);
         }
         else
         {
            trace("强化失败");
            gc.ts.setTxt("强化失败");
            if(this.curWepon.getMyEquipObj().getStrengthValue() >= 3)
            {
               if(this.baodimc.getChildByName("curzb") == null && gc.gameVip.getVipLevel() < 2)
               {
                  trace("降级");
                  this.curWepon.getMyEquipObj().upStrengthValue(-1);
               }
            }
         }
         trace("等级:" + this.curWepon.getMyEquipObj().getStrengthValue());
         gc.stage.addChild(gc.ts);
      }
      
      private function clearAllThingExceptWeapen(weapenremove:Boolean = true) : void
      {
         var sobj:* = null;
         var i:* = 0;
         var obj:* = null;
         var fillName:* = null;
         var ary:* = null;
         ary = null;
         this.player.outlist = [];
         this.curWepon = null;
         cobj.allpro = 0;
         if(weapenremove)
         {
            if(this.zbmc.getChildByName("curzb"))
            {
               sobj = this.zbmc.getChildByName("curzb") as ShowObj;
               this.zbmc.removeChild(sobj);
               if(gc.allEquip.isTheSameEquipmentByFillName(sobj.getMyEquipObj()))
               {
                  if(sobj.getMyEquipObj().type == "zbcb" || sobj.getMyEquipObj().type == "zbsz")
                  {
                     this.player.szlist.push(sobj.getMyEquipObj());
                  }
                  else
                  {
                     this.player.zblist.push(sobj.getMyEquipObj());
                  }
                  sobj = null;
               }
               else
               {
                  gc.ts.setTxt("不是同一个物品，请勿修改");
                  gc.stage.addChild(gc.ts);
               }
            }
         }
         else if(this.zbmc.getChildByName("curzb"))
         {
            sobj = this.zbmc.getChildByName("curzb") as ShowObj;
            this.zbmc.removeChild(sobj);
            sobj = null;
         }
         var stoneCount:String = "";
         var date:Date = new Date();
         var day:int = date.getDate();
         var hour:int = date.getHours();
         var minutes:int = date.getMinutes();
         var timer:String = day + "-" + hour + "-" + minutes;
         for(i = uint(0); i < 3; )
         {
            if(this["qhmc" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["qhmc" + (i + 1)].getChildByName("curzb") as ShowObj;
               if(gc.findOneTimeGoodsByFillName(sobj.getMyEquipObj().getFillName()))
               {
                  obj = [];
                  if(sobj.getMyEquipObj().getShopAttribtue() >= 1)
                  {
                     sobj.getMyEquipObj().setShopAttribute(sobj.getMyEquipObj().getShopAttribtue() - 1);
                     obj.push(FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),0));
                     obj.push(0);
                     obj.push(1);
                     obj.push(sobj.getMyEquipObj().getENum());
                  }
                  else
                  {
                     obj.push(FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),1));
                     obj.push(0);
                     obj.push(1);
                     obj.push(sobj.getMyEquipObj().getENum());
                  }
                  this.addArray(obj);
               }
               fillName = sobj.getMyEquipObj().getFillName();
               if(fillName.indexOf("wpqhs") != -1)
               {
                  stoneCount += fillName.substr(5,1);
                  if(i < 2)
                  {
                     stoneCount += ",";
                  }
               }
               this["qhmc" + (i + 1)].removeChild(sobj);
               sobj = null;
            }
            i++;
         }
         if(stoneCount != "")
         {
            if(gc.qhsInfo.length >= 10)
            {
               gc.qhsInfo.shift();
            }
            gc.qhsInfo.push(timer + "|" + stoneCount + "|1");
         }
         if(this.luckmc.getChildByName("curzb"))
         {
            sobj = this.luckmc.getChildByName("curzb") as ShowObj;
            this.luckmc.removeChild(sobj);
            if(gc.findOneTimeGoodsByFillName(sobj.getMyEquipObj().getFillName()))
            {
               ary = [];
               ary.push(FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),0));
               ary.push(0);
               ary.push(1);
               ary.push(sobj.getMyEquipObj().getENum());
               this.addArray(ary);
            }
            sobj = null;
         }
         if(this.baodimc.getChildByName("curzb"))
         {
            sobj = this.baodimc.getChildByName("curzb") as ShowObj;
            this.baodimc.removeChild(sobj);
            if(gc.findOneTimeGoodsByFillName(sobj.getMyEquipObj().getFillName()))
            {
               ary = [];
               ary.push(FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),0));
               ary.push(0);
               ary.push(1);
               ary.push(sobj.getMyEquipObj().getENum());
               this.addArray(ary);
            }
            sobj = null;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
      }
      
      private function removedSelf() : void
      {
         var sobj:* = null;
         var i:* = 0;
         if(this.zbmc.getChildByName("curzb"))
         {
            sobj = this.zbmc.getChildByName("curzb") as ShowObj;
            if(gc.allEquip.isTheSameEquipmentByFillName(sobj.getMyEquipObj()))
            {
               this.zbmc.removeChild(sobj);
               if(sobj.getMyEquipObj().type == "zbcb" || sobj.getMyEquipObj().type == "zbsz")
               {
                  this.player.szlist.push(sobj.getMyEquipObj());
               }
               else
               {
                  this.player.zblist.push(sobj.getMyEquipObj());
               }
               sobj = null;
            }
            else
            {
               gc.ts.setTxt("不是同一个物品，请勿修改");
               gc.stage.addChild(gc.ts);
            }
         }
         for(i = uint(0); i < 3; )
         {
            if(this["qhmc" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["qhmc" + (i + 1)].getChildByName("curzb") as ShowObj;
               this["qhmc" + (i + 1)].removeChild(sobj);
               if(sobj.getMyEquipObj().getShopAttribtue() == 1 && sobj.getMyEquipObj().getENum() == 1)
               {
                  gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName(),1,true,false);
               }
               else
               {
                  gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
               }
               sobj = null;
            }
            i++;
         }
         if(this.luckmc.getChildByName("curzb"))
         {
            sobj = this.luckmc.getChildByName("curzb") as ShowObj;
            this.luckmc.removeChild(sobj);
            gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
            sobj = null;
         }
         if(this.baodimc.getChildByName("curzb"))
         {
            sobj = this.baodimc.getChildByName("curzb") as ShowObj;
            this.baodimc.removeChild(sobj);
            gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
            sobj = null;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
      }
      
      private function addArray(_ary:Array) : void
      {
         for each(var data in this.sendlist)
         {
            if(data[0] == _ary[0] && data[1] == _ary[1])
            {
               var _loc3_:int = 2;
               var _loc4_:* = data[_loc3_] + _ary[2];
               data[_loc3_] = _loc4_;
               return;
            }
         }
         this.sendlist.push(_ary);
      }
   }
}
