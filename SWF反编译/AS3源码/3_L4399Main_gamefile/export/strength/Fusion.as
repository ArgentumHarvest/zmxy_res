package export.strength
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.pack.ShowObj;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   import my.MyEquipObj;
   import user.User;
   
   public class Fusion extends Sprite
   {
       
      
      private var gc:Config;
      
      private var player:User;
      
      public var rlbtn:SimpleButton;
      
      public var material1:Sprite;
      
      public var material2:Sprite;
      
      public var material3:Sprite;
      
      public var produce:Sprite;
      
      public var preview:Sprite;
      
      private var threeObj:Array;
      
      private var sendlist:Array;
      
      public var txt_name:TextField;
      
      public var txt_needlh:TextField;
      
      public var txt_success:TextField;
      
      private var _anti:Antiwear;
      
      public function Fusion(_player:User)
      {
         threeObj = [];
         sendlist = [];
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this.player = _player;
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.player.outlist = [];
         this.sendlist = [];
         gc.eventManger.addEventListener("SimpleClick",receiveObj);
         rlbtn.addEventListener("click",makeClick);
         material1.addEventListener("click",onClick);
         material2.addEventListener("click",onClick);
         material3.addEventListener("click",onClick);
         produce.addEventListener("click",produceClick);
      }
      
      private function removed(e:Event) : void
      {
         this.player.outlist = [];
         this.sendlist = [];
         gc.eventManger.removeEventListener("SimpleClick",receiveObj);
         rlbtn.removeEventListener("click",makeClick);
         material1.removeEventListener("click",onClick);
         material2.removeEventListener("click",onClick);
         material3.removeEventListener("click",onClick);
         produce.removeEventListener("click",produceClick);
         this.removedSelf();
      }
      
      public function setRole(_player:User) : void
      {
         this.player = _player;
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
               case "zbtx":
               case "zbwq":
               case "zbfj":
               case "zbsp":
                  if(gc.allEquip.isTheSameEquipmentByFillName(temp.getMyEquipObj()))
                  {
                     this.player.zblist.push(temp.getMyEquipObj());
                  }
                  else
                  {
                     gc.ts.setTxt("不是同一个物品，请勿修改");
                     gc.stage.addChild(gc.ts);
                  }
                  break;
               case "zbfb":
                  this.player.szlist.push(temp.getMyEquipObj());
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
                  }
                  break;
               case "wpqhs":
                  if(gc.findOneTimeGoodsByFillName(temp.getMyEquipObj().getFillName()))
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
                  else
                  {
                     gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
                  }
                  break;
               case "zbwp":
            }
            temp = null;
         }
         this.previewFun();
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
      }
      
      private function produceClick(e:MouseEvent) : void
      {
         this.removedProduceEquipment();
      }
      
      private function removedProduceEquipment() : void
      {
         var temp:* = null;
         if(this.produce.getChildByName("curzb") != null)
         {
            temp = produce.getChildByName("curzb") as ShowObj;
            produce.removeChild(temp);
            temp = null;
         }
      }
      
      private function receiveObj(e:CommonEvent) : void
      {
         var fillname:* = null;
         var sobj:ShowObj = e.data[0] as ShowObj;
         trace("sobj..getShopAttribtue-->" + sobj.getMyEquipObj().getShopAttribtue());
         switch(sobj.getMyEquipObj().type)
         {
            case "zbtx":
            case "zbwq":
            case "zbfj":
            case "zbsp":
               if(sobj.getMyEquipObj().type == "zbfb")
               {
                  fillname = sobj.getMyEquipObj().getFillName();
                  if(fillname != "hsqq" && fillname != "h_sqq" && fillname != "lsqq" && fillname != "csqq" && fillname != "zsqq" && fillname != "l_sqq" && fillname != "yyzlj" && fillname != "ywhl" && fillname != "sxyg" && fillname != "zhyx" && fillname != "bjs" && fillname != "yyb" && fillname != "dkhl" && fillname != "hehua" && fillname != "wpfbyyin" && fillname != "wpfbyyan" && fillname != "wpfbtc" && fillname != "lxfb" && fillname != "sxfb")
                  {
                     return;
                  }
               }
               if(material1.numChildren < 2)
               {
                  material1.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),1);
               }
               else if(material2.numChildren < 2)
               {
                  material2.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),1);
               }
               else if(material3.numChildren < 2)
               {
                  material3.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),1);
               }
               break;
            case "zbfb":
               if(material1.numChildren < 2)
               {
                  material1.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),3);
               }
               else if(material2.numChildren < 2)
               {
                  material2.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),3);
               }
               else if(material3.numChildren < 2)
               {
                  material3.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),3);
               }
               break;
            case "zbsz":
            case "wpqhs":
               if(material1.numChildren < 2)
               {
                  material1.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               else if(material2.numChildren < 2)
               {
                  material2.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               else if(material3.numChildren < 2)
               {
                  material3.addChild(sobj);
                  this.removeEquipFormBack(sobj.getMyEquipObj(),2);
               }
               break;
            case "zbwp":
         }
         this.previewFun();
         this.removedProduceEquipment();
      }
      
      private function previewFun() : void
      {
         var tubiao:* = undefined;
         this.txt_name.text = "";
         if(this.preview.getChildByName("view") != null)
         {
            this.preview.removeChild(this.preview.getChildByName("view"));
         }
         this.getThreeObj();
         var pa:Array = gc.allEquip.mixProduce(this.threeObj);
         this._anti.produceEquipName = pa[0];
         if(this._anti.produceEquipName.indexOf("wpqhs") != -1 || this._anti.produceEquipName.indexOf("sms") != -1 || this._anti.produceEquipName.indexOf("mfs") != -1 || this._anti.produceEquipName.indexOf("gjs") != -1 || this._anti.produceEquipName.indexOf("fys") != -1)
         {
            this.txt_needlh.text = "100";
            this.txt_success.text = "100%";
         }
         else
         {
            this.txt_needlh.text = "100";
            this.txt_success.text = "100%";
         }
         if(this._anti.produceEquipName != "")
         {
            tubiao = AUtils.getImageObj(this._anti.produceEquipName);
            tubiao.name = "view";
            this.preview.addChild(tubiao);
            this.txt_name.text = pa[1];
         }
      }
      
      private function removeEquipFormBack(equip:MyEquipObj, pack:int) : void
      {
         var sit:int = 0;
         if(pack == 1)
         {
            sit = this.player.zblist.indexOf(equip);
            if(sit != -1)
            {
               this.player.zblist.splice(sit,1);
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
            sit = this.player.szlist.indexOf(equip);
            if(sit != -1)
            {
               this.player.szlist.splice(sit,1);
            }
         }
         else if(pack == 4)
         {
            if(equip.getENum() > 1)
            {
               equip.setNum(-1);
            }
            else
            {
               sit = this.player.jnslist.indexOf(equip);
               if(sit != -1)
               {
                  this.player.jnslist.splice(sit,1);
               }
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
      }
      
      private function getProduce() : void
      {
         var ary:* = null;
         var sobj:ShowObj = this.produce.getChildByName("curzb") as ShowObj;
         if(sobj != null)
         {
            if(sobj.getMyEquipObj().type == "zbfb" || sobj.getMyEquipObj().type == "zbwq" || sobj.getMyEquipObj().type == "zbfj" || sobj.getMyEquipObj().type == "zbsp" || sobj.getMyEquipObj().type == "zbtx")
            {
               this.player.zblist.push(sobj.getMyEquipObj());
            }
            else if(sobj.getMyEquipObj().type == "wpqhs" || sobj.getMyEquipObj().type == "zbwp")
            {
               if(gc.findOneTimeGoodsByFillName(sobj.getMyEquipObj().getFillName()))
               {
                  ary = [];
                  ary[0] = FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),1);
                  ary[1] = 1;
                  ary[2] = 1;
                  ary[3] = sobj.getMyEquipObj().getENum();
                  this.addArray(ary);
               }
               gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
            }
            else if(sobj.getMyEquipObj().type == "zbsz")
            {
               this.player.szlist.push(sobj.getMyEquipObj());
            }
            sobj = null;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
      }
      
      private function getThreeObj() : void
      {
         var sobj:* = null;
         var i:* = 0;
         this.threeObj = [];
         this.player.outlist = [];
         for(i = uint(0); i < 3; )
         {
            if(this["material" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["material" + (i + 1)].getChildByName("curzb") as ShowObj;
               threeObj.push(sobj.getMyEquipObj());
               this.player.outlist.push({
                  "dequip":sobj.getMyEquipObj(),
                  "count":1
               });
               sobj = null;
            }
            i++;
         }
      }
      
      private function removeThreeObj() : void
      {
         var sobj:* = null;
         var i:* = 0;
         var fillName:* = null;
         var obj:* = null;
         trace("Fusion --outlist.length =" + this.player.outlist.length);
         this.threeObj = [];
         this.player.outlist = [];
         this.txt_success.text = "";
         var stoneCount:String = "";
         var date:Date = new Date();
         var day:int = date.getDate();
         var hour:int = date.getHours();
         var minutes:int = date.getMinutes();
         var timer:String = day + "-" + hour + "-" + minutes;
         for(i = uint(0); i < 3; )
         {
            if(this["material" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["material" + (i + 1)].getChildByName("curzb") as ShowObj;
               fillName = sobj.getMyEquipObj().getFillName();
               if(gc.findOneTimeGoodsByFillName(sobj.getMyEquipObj().getFillName()))
               {
                  obj = [];
                  if(sobj.getMyEquipObj().getShopAttribtue() >= 1)
                  {
                     sobj.getMyEquipObj().setShopAttribute(sobj.getMyEquipObj().getShopAttribtue() - 1);
                     obj[0] = FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),0);
                     obj[1] = 0;
                     obj[2] = 1;
                     obj[3] = sobj.getMyEquipObj().getENum();
                  }
                  else
                  {
                     obj[0] = FinancialInfo.getItemIdByName(sobj.getMyEquipObj().getFillName(),1);
                     obj[1] = 0;
                     obj[2] = 1;
                     obj[3] = sobj.getMyEquipObj().getENum();
                  }
                  this.addArray(obj);
               }
               if(fillName.indexOf("wpqhs") != -1)
               {
                  stoneCount += fillName.substr(5,1);
                  if(i < 2)
                  {
                     stoneCount += ",";
                  }
               }
               sobj = this["material" + (i + 1)].removeChild(sobj);
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
            gc.qhsInfo.push(timer + "|" + stoneCount + "|2");
         }
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
      
      private function getAndRemovedEquip() : void
      {
         this.removeThreeObj();
         this.getProduce();
         if(gc.isHideDebug)
         {
            if(this.sendlist.length > 0)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,this.sendlist,gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
               this.sendlist = [];
            }
         }
      }
      
      private function makeClick(e:MouseEvent) : void
      {
         if(gc.isHideDebug)
         {
            doFusion();
         }
         else
         {
            this.doFusion();
         }
      }
      
      private function doFusion() : void
      {
         var fvalue:* = 0;
         var produceEquip:* = null;
         var mlen:* = 0;
         var obj:* = null;
         var myEquip:* = null;
         var i:* = 0;
         var prosobj:* = null;
         trace("---produceEquipName---" + this._anti.produceEquipName);
         this.rlbtn.enabled = false;
         if(this._anti.produceEquipName != "")
         {
            fvalue = uint(100);
            if(!gc.isHideDebug)
            {
               fvalue = uint(0);
            }
            if(player.getLhValue() < fvalue)
            {
               gc.ts.setTxt("灵魂值不够");
               gc.stage.addChild(gc.ts);
               this.rlbtn.enabled = true;
               return;
            }
            player.setLhValue(player.getLhValue() - fvalue);
            StrengthEquipment(this.parent).setTxtlh();
            if(this._anti.produceEquipName.indexOf("wpqhs") != -1 || this._anti.produceEquipName.indexOf("mfs") != -1 || this._anti.produceEquipName.indexOf("gjs") != -1 || this._anti.produceEquipName.indexOf("fys") != -1 || this._anti.produceEquipName == "sms1" || this._anti.produceEquipName == "sms2" || this._anti.produceEquipName == "sms3" || this._anti.produceEquipName == "rls" || this._anti.produceEquipName == "yhs" || this._anti.produceEquipName == "tss")
            {
               this.afterReadStore();
            }
            else
            {
               StrengthEquipment(this.parent).setTxtlh();
               if(this._anti.produceEquipName == "undefined1" || this._anti.produceEquipName == "csqq" || this._anti.produceEquipName == "l_sqq" || this._anti.produceEquipName == "zsqq" || this._anti.produceEquipName == "fsqq" || this._anti.produceEquipName == "_yxjsxstx" || this._anti.produceEquipName == "_jljsxstx" || this._anti.produceEquipName == "_ssjsxstx")
               {
                  produceEquip = gc.allEquip.findByName(this._anti.produceEquipName);
               }
               else if(this._anti.produceEquipName == "yxfb" || this._anti.produceEquipName == "sxfb")
               {
                  produceEquip = gc.allEquip.findByName(this._anti.produceEquipName);
                  mlen = uint(this.threeObj.length);
                  for(obj = produceEquip.getGrowthByName(produceEquip.getFillName()); mlen-- > 0; )
                  {
                     myEquip = this.threeObj[mlen];
                     if(myEquip.type == "zbfb")
                     {
                        for(i = uint(1); i < myEquip.getELevel(); )
                        {
                           produceEquip.growth(obj);
                           i++;
                        }
                        break;
                     }
                  }
               }
               else if(this._anti.produceEquipName == "cs_sp_hy")
               {
                  produceEquip = gc.allEquip.getSunSutraValueEquip(this._anti.produceEquipName,this.threeObj);
               }
               else if(gc.allEquip.isFashionEquipByFillName(this._anti.produceEquipName))
               {
                  produceEquip = gc.allEquip.findByName(this._anti.produceEquipName);
                  produceEquip.setFashionTime(gc.dataObjectInstance.curDate);
               }
               else if(this._anti.produceEquipName == "wpfbyyin" || this._anti.produceEquipName == "wpfbyyan" || this._anti.produceEquipName == "wpfbtc" || this._anti.produceEquipName == "tjbg")
               {
                  produceEquip = gc.allEquip.getEupdataSunSutraValueEquip(this._anti.produceEquipName,this.threeObj);
               }
               else
               {
                  produceEquip = gc.allEquip.getSutraValue(this._anti.produceEquipName,this.threeObj);
               }
               prosobj = new ShowObj(produceEquip);
               this.produce.addChild(prosobj);
               gc.ts.setTxt("合成成功");
               gc.eventManger.dispatchEvent(new CommonEvent("RefreshLHValue"));
               this._anti.produceEquipName = "";
               gc.stage.addChild(gc.ts);
               this.getAndRemovedEquip();
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
         }
         this.rlbtn.enabled = true;
         if(this.preview.getChildByName("view") != null)
         {
            this.preview.removeChild(this.preview.getChildByName("view"));
         }
      }
      
      private function afterReadStore() : void
      {
         var produceEquip1:MyEquipObj = gc.allEquip.findByName(this._anti.produceEquipName);
         var prosobj1:ShowObj = new ShowObj(produceEquip1);
         this.produce.addChild(prosobj1);
         gc.ts.setTxt("合成成功");
         this._anti.produceEquipName = "";
         gc.stage.addChild(gc.ts);
         this.getAndRemovedEquip();
      }
      
      private function removedSelf() : void
      {
         var sobj:* = null;
         var i:* = 0;
         this.removedProduceEquipment();
         for(i = uint(0); i < 3; )
         {
            if(this["material" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["material" + (i + 1)].getChildByName("curzb") as ShowObj;
               this["material" + (i + 1)].removeChild(sobj);
               if(sobj.getMyEquipObj().type == "zbfb" || sobj.getMyEquipObj().type == "zbwq" || sobj.getMyEquipObj().type == "zbfj" || sobj.getMyEquipObj().type == "zbsp" || sobj.getMyEquipObj().type == "zbtx")
               {
                  if(gc.allEquip.isTheSameEquipmentByFillName(sobj.getMyEquipObj()))
                  {
                     this.player.zblist.push(sobj.getMyEquipObj());
                  }
                  else
                  {
                     gc.ts.setTxt("不是同一个物品，请勿修改");
                     gc.stage.addChild(gc.ts);
                  }
               }
               else if(sobj.getMyEquipObj().type == "wpqhs" || sobj.getMyEquipObj().type == "zbwp")
               {
                  if(sobj.getMyEquipObj().getShopAttribtue() == 1 && sobj.getMyEquipObj().getENum() == 1)
                  {
                     gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName(),1,true,false);
                  }
                  else
                  {
                     gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
                  }
               }
               else if(sobj.getMyEquipObj().type == "zbsz")
               {
                  this.player.szlist.push(sobj.getMyEquipObj());
               }
               sobj = null;
            }
            i++;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("GETANDREFRESHBACKPACKAGE"));
      }
      
      private function helpClick(e:MouseEvent) : void
      {
         var fusionHelp:* = null;
         if(this.getChildByName("fusionHelp") == null)
         {
            fusionHelp = AUtils.getNewObj("export.strength.FusionHelp") as FusionHelp;
            fusionHelp.name = "fusionHelp";
            fusionHelp.x = 102;
            fusionHelp.y = 40;
            this.addChild(fusionHelp);
         }
      }
   }
}
