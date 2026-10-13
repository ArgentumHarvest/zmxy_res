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
   
   public class Making extends Sprite
   {
       
      
      public var makingbook:Sprite;
      
      public var needmaterial1:Sprite;
      
      public var needmaterial2:Sprite;
      
      public var material1:Sprite;
      
      public var material2:Sprite;
      
      public var material3:Sprite;
      
      public var makeObj:Sprite;
      
      public var txthas1:TextField;
      
      public var txtneed1:TextField;
      
      public var txthas2:TextField;
      
      public var txtneed2:TextField;
      
      public var txt_needlh:TextField;
      
      public var txt_name:TextField;
      
      public var btn_help:SimpleButton;
      
      public var dzbtn:SimpleButton;
      
      private var gc:Config;
      
      private var player:User;
      
      private var curmbook:MyEquipObj;
      
      private var needAry:Array;
      
      private var tag:Boolean = true;
      
      private var sendlist:Array;
      
      public function Making(_player:User)
      {
         needAry = [];
         sendlist = [];
         super();
         this.player = _player;
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(this.tag)
         {
            this.tag = false;
            this.player.outlist = [];
            this.sendlist = [];
            gc.eventManger.addEventListener("SimpleClick",receiveObj);
            dzbtn.addEventListener("click",dzClick);
            makeObj.addEventListener("click",removeMakeObj);
            material1.addEventListener("click",onClick);
            material2.addEventListener("click",onClick);
            material3.addEventListener("click",onClick);
         }
      }
      
      private function removed(e:Event) : void
      {
         this.sendlist = [];
         gc.eventManger.removeEventListener("SimpleClick",receiveObj);
         dzbtn.removeEventListener("click",dzClick);
         makeObj.removeEventListener("click",removeMakeObj);
         material1.removeEventListener("click",onClick);
         material2.removeEventListener("click",onClick);
         material3.removeEventListener("click",onClick);
         this.clearAllThingExceptMakeObject(false);
      }
      
      private function receiveObj(e:CommonEvent) : void
      {
         var temp:* = null;
         var i:* = 0;
         var sobj:ShowObj = e.data[0] as ShowObj;
         if(sobj.getMyEquipObj().type == "zbtx")
         {
            gc.ts.setTxt("该装备不能用来打造");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(sobj.getMyEquipObj().findUsedByShowId() == "zzs")
         {
            this.curmbook = null;
            this.curmbook = sobj.getMyEquipObj();
            temp = makingbook.getChildByName("curzb") as ShowObj;
            if(temp == null)
            {
               makingbook.addChild(sobj);
            }
            else
            {
               makingbook.removeChild(temp);
               gc.putQhsInBackPack(this.player,temp.getMyEquipObj().getFillName());
               makingbook.addChild(sobj);
               temp = null;
            }
            this.removeEquipFormBack(sobj.getMyEquipObj(),2);
            needAry = gc.allEquip.findNeedMaterialByName(this.curmbook.getFillName());
            this.addNeedMaterial(needAry);
         }
         else if(sobj.getMyEquipObj().isSms() || sobj.getMyEquipObj().isMfs() || sobj.getMyEquipObj().isGjs() || sobj.getMyEquipObj().isFys() || sobj.getMyEquipObj().isTlz() || sobj.getMyEquipObj().isLlz() || sobj.getMyEquipObj().isHlz() || sobj.getMyEquipObj().isFlz() || sobj.getMyEquipObj().isSlz())
         {
            if(this.curmbook)
            {
               for(i = uint(1); i <= 3; )
               {
                  if(this["material" + i].getChildByName("curzb") == null)
                  {
                     this["material" + i].addChild(sobj);
                     this.removeEquipFormBack(sobj.getMyEquipObj(),2);
                     break;
                  }
                  i++;
               }
            }
            else
            {
               trace("current making book is null");
            }
         }
         this.removeMakeObj(null);
         this.getOutList();
         this.setTxt();
         gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
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
                  this.player.zblist.push(temp.getMyEquipObj());
                  break;
               case "zbfb":
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
                  if(temp.getMyEquipObj().findUsedByShowId() == "bs")
                  {
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
                  }
                  break;
               case "zbwp":
            }
            gc.eventManger.dispatchEvent(new CommonEvent("REFRESHBACKPACK",[false]));
            temp = null;
         }
      }
      
      private function addNeedMaterial(mAry:Array) : void
      {
         var newsobj:* = null;
         var i:* = 0;
         this.cleanNeedMaterial();
         var mlen:uint = mAry.length;
         for(i = uint(0); i < mlen; )
         {
            if(mAry[i] != null)
            {
               newsobj = new ShowObj(mAry[i].equip);
               this["needmaterial" + (i + 1)].addChild(newsobj);
               newsobj = null;
            }
            i++;
         }
      }
      
      private function cleanNeedMaterial() : void
      {
         var sobj:* = null;
         var j:* = 0;
         for(j = uint(0); j < 2; )
         {
            if(this["needmaterial" + (j + 1)].getChildByName("curzb"))
            {
               sobj = this["needmaterial" + (j + 1)].getChildByName("curzb") as ShowObj;
               this["needmaterial" + (j + 1)].removeChild(sobj);
               sobj = null;
            }
            j++;
         }
      }
      
      private function removeEquipFormBack(equip:MyEquipObj, pack:int, num:uint = 1) : void
      {
         var sit:int = 0;
         trace("equip.getENum()= " + equip.getENum());
         trace("num:" + num);
         var temp:MyEquipObj = this.player.getSomeEquipInPackBackByName(equip.getFillName());
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
            if(equip.getENum() > num)
            {
               equip.setNum(-num);
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
         trace("removeEquipFormBack -end");
      }
      
      private function setTxt() : void
      {
         var clen:* = 0;
         var i:* = 0;
         this.txthas1.text = " ";
         this.txtneed1.text = " ";
         this.txthas2.text = " ";
         this.txtneed2.text = " ";
         this.txt_needlh.text = " ";
         this.txt_name.text = " ";
         if(needAry == null)
         {
            return;
         }
         if(this.curmbook)
         {
            clen = uint(this.needAry.length);
            for(i = uint(0); i < clen; )
            {
               this["txthas" + (i + 1)].text = this.player.getSomeOneEquipNumberByName(this.needAry[i].equip.getFillName()) + " ";
               this["txtneed" + (i + 1)].text = this.needAry[i].count + " ";
               i++;
            }
            this.txt_needlh.text = this.needLHValueByQuality(this.curmbook.quality) + " ";
         }
         trace("this.makeObj:" + this.makeObj);
         var pequip:ShowObj = this.makeObj.getChildByName("curzb") as ShowObj;
         if(pequip)
         {
            trace("pequip.getMyEquipObj():" + pequip.getMyEquipObj());
            this.txt_name.text = pequip.getMyEquipObj().ename + "";
         }
      }
      
      private function needLHValueByQuality(quality:String) : uint
      {
         switch(quality)
         {
            case "粗 糙":
               return 50 + RandomControllor.getIns().getRandom();
            case "普 通":
               return 100 + RandomControllor.getIns().getRandom();
            case "优 秀":
               return 200 + RandomControllor.getIns().getRandom();
            case "精 良":
               return 400 + RandomControllor.getIns().getRandom();
            case "史 诗":
               return 800 + RandomControllor.getIns().getRandom();
            case "传 说":
               return 1600 + RandomControllor.getIns().getRandom();
            default:
               return 0;
         }
      }
      
      private function getOutList() : void
      {
         var sobj:* = null;
         var i:* = 0;
         this.player.outlist = [];
         if(this.curmbook)
         {
            this.player.outlist.push({
               "dequip":this.curmbook,
               "count":1
            });
         }
         for(i = uint(0); i < 3; )
         {
            if(this["material" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["material" + (i + 1)].getChildByName("curzb") as ShowObj;
               this.player.outlist.push({
                  "dequip":sobj.getMyEquipObj(),
                  "count":1
               });
               sobj = null;
            }
            i++;
         }
      }
      
      private function dzClick(e:MouseEvent) : void
      {
         var nlen:* = 0;
         var k:* = 0;
         var equipObj:* = null;
         var sobj:* = null;
         if(this.curmbook == null)
         {
            return;
         }
         if(this.player.getLhValue() >= int(this.txt_needlh.text))
         {
            if(int(this.txthas1.text) >= int(this.txtneed1.text) && int(this.txthas2.text) >= int(this.txtneed2.text))
            {
               this.player.setLhValue(this.player.getLhValue() - int(this.txt_needlh.text));
               StrengthEquipment(this.parent).setTxtlh();
               trace("needAry:" + needAry);
               nlen = uint(this.needAry.length);
               for(k = uint(0); k < nlen; )
               {
                  this.player.outlist.push({
                     "dequip":this.player.getSomeEquipInPackBackByName(this.needAry[k].equip.getFillName()),
                     "count":this.needAry[k].count
                  });
                  equipObj = this.player.getSomeEquipInPackBackByName(this.needAry[k].equip.getFillName());
                  this.removeEquipFormBack(equipObj,2,this.needAry[k].count);
                  k++;
               }
               trace("Making --outlist.length =" + this.player.outlist.length);
               this.needAry = null;
               sobj = new ShowObj(this.achieveWhichProduce(this.curmbook.getFillName()));
               this.player.zblist.push(sobj.getMyEquipObj());
               makeObj.addChild(sobj);
               this.clearAllThingExceptMakeObject(true);
               gc.eventManger.dispatchEvent(new CommonEvent("CHANGETXT"));
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
            else
            {
               gc.ts.setTxt("材料不足");
               gc.stage.addChild(gc.ts);
            }
         }
         else
         {
            gc.ts.setTxt("灵魂不足");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function removeMakeObj(e:MouseEvent) : void
      {
         var sobj:ShowObj = makeObj.getChildByName("curzb") as ShowObj;
         if(sobj)
         {
            makeObj.removeChild(sobj);
            sobj = null;
         }
      }
      
      private function achieveWhichProduce(bookname:String) : MyEquipObj
      {
         var addHp:int = 0;
         var addMp:int = 0;
         var addAtk:int = 0;
         var addDef:int = 0;
         var dzEquip:* = null;
         var sobj:* = null;
         var i:* = 0;
         var a:* = undefined;
         var mname:String = "";
         trace("bookname -->>" + bookname);
         if(bookname == "cs_wq_qs_zzs" || bookname == "cs_wq_rc_zzs" || bookname == "cs_wq_yt_zzs" || bookname == "cs_wq_ll_zzs" || bookname == "cs_fj_dz_zzs" || bookname == "cs_fj_zt_zzs" || bookname == "cs_fj_jt_zzs" || bookname == "cs_fj_js_zzs")
         {
            mname = bookname.substr(0,bookname.length - 4);
         }
         else
         {
            mname = bookname.substr(0,bookname.length - 3);
         }
         trace("mname -->>" + mname);
         dzEquip = gc.allEquip.findByName(mname);
         for(i = uint(0); i < 3; )
         {
            sobj = this["material" + (i + 1)].getChildByName("curzb") as ShowObj;
            if(sobj)
            {
               a = this.randomGemAttributeByGemName(sobj.getMyEquipObj().getFillName());
               if(sobj.getMyEquipObj().isSms())
               {
                  dzEquip.setehp(dzEquip.getehp() + a);
               }
               else if(sobj.getMyEquipObj().isMfs())
               {
                  dzEquip.setemp(dzEquip.getemp() + a);
               }
               else if(sobj.getMyEquipObj().isGjs())
               {
                  dzEquip.seteatt(dzEquip.geteatt() + a);
               }
               else if(sobj.getMyEquipObj().isFys())
               {
                  dzEquip.setedef(dzEquip.getedef() + a);
               }
               else if(sobj.getMyEquipObj().isTlz())
               {
                  dzEquip.setmagicdef((dzEquip.getmagicdef() * 100 + Math.round(a * 100)) / 100);
               }
               else if(sobj.getMyEquipObj().isLlz())
               {
                  dzEquip.setecrit((dzEquip.getecrit() * 100 + Math.round(a * 100)) / 100);
               }
               else if(sobj.getMyEquipObj().isHlz())
               {
                  dzEquip.seteahp(dzEquip.geteahp() + a);
               }
               else if(sobj.getMyEquipObj().isFlz())
               {
                  dzEquip.setemiss((dzEquip.getemiss() * 100 + Math.round(a * 100)) / 100);
               }
               else if(sobj.getMyEquipObj().isSlz())
               {
                  dzEquip.seteamp(dzEquip.geteamp() + a);
               }
            }
            i++;
         }
         return dzEquip;
      }
      
      private function randomGemAttributeByGemName(gname:String) : *
      {
         switch(gname)
         {
            case "sms1":
               return Math.round(1 + RandomControllor.getIns().getRandom() * 20);
            case "sms2":
            case "scsms2":
               return Math.round(40 + RandomControllor.getIns().getRandom() * 70);
            case "sms3":
            case "scsms3":
               return Math.round(85 + RandomControllor.getIns().getRandom() * 115);
            case "mfs1":
               return Math.round(1 + RandomControllor.getIns().getRandom() * 20);
            case "mfs2":
            case "scmfs2":
               return Math.round(40 + RandomControllor.getIns().getRandom() * 70);
            case "mfs3":
               break;
            case "scmfs3":
               break;
            case "gjs1":
               return Math.round(1 + RandomControllor.getIns().getRandom() * 10);
            case "gjs2":
            case "scgjs2":
               return Math.round(7 + RandomControllor.getIns().getRandom() * 13);
            case "gjs3":
            case "scgjs3":
               return Math.round(15 + RandomControllor.getIns().getRandom() * 25);
            case "fys1":
               return Math.round(1 + RandomControllor.getIns().getRandom() * 2);
            case "fys2":
            case "scfys2":
               return Math.round(2 + RandomControllor.getIns().getRandom() * 4);
            case "fys3":
            case "scfys3":
               return Math.round(5 + RandomControllor.getIns().getRandom() * 7);
            case "wptlz":
               return 0.01 + RandomControllor.getIns().getRandom() * 0.01;
            case "wpllz":
               return 0.01 + RandomControllor.getIns().getRandom() * 0.01;
            case "wphlz":
               return 1 + Math.round(RandomControllor.getIns().getRandom() * 2);
            case "wpflz":
               return 0.01 + RandomControllor.getIns().getRandom() * 0.01;
            case "wpslz":
               return 1 + Math.round(RandomControllor.getIns().getRandom());
            default:
               return 0;
         }
         return Math.round(85 + RandomControllor.getIns().getRandom() * 115);
      }
      
      private function clearAllThingExceptMakeObject(scu:Boolean) : void
      {
         var sobj:* = null;
         var i:* = 0;
         var obj:* = null;
         this.curmbook = null;
         if(makingbook.getChildByName("curzb"))
         {
            sobj = makingbook.getChildByName("curzb") as ShowObj;
            if(!scu)
            {
               gc.putQhsInBackPack(this.player,sobj.getMyEquipObj().getFillName());
            }
            makingbook.removeChild(sobj);
            sobj = null;
         }
         this.cleanNeedMaterial();
         for(i = uint(0); i < 3; )
         {
            if(this["material" + (i + 1)].getChildByName("curzb"))
            {
               sobj = this["material" + (i + 1)].getChildByName("curzb") as ShowObj;
               this["material" + (i + 1)].removeChild(sobj);
               if(!scu)
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
               else
               {
                  obj = [];
                  if(gc.findOneTimeGoodsByFillName(sobj.getMyEquipObj().getFillName()))
                  {
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
               }
               sobj = null;
            }
            i++;
         }
         if(gc.isHideDebug)
         {
            if(this.sendlist.length > 0)
            {
               FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,this.sendlist,gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
               this.sendlist = [];
            }
         }
         this.setTxt();
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
