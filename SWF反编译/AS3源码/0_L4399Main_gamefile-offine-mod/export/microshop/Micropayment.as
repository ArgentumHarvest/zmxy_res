package export.microshop
{
   import config.Config;
   import event.CommonEvent;
   import export.RechargeTips;
   import export.§microshop:Micropayment§.buySuccess;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.FinancialInfo;
   import my.MyEquipObj;
   import user.User;
   
   public class Micropayment extends Sprite
   {
       
      
      private var gc:Config;
      
      private var player:User;
      
      private var sellbsList:Array;
      
      private var sellcwList:Array;
      
      private var sellszList:Array;
      
      private var selldjList:Array;
      
      public var selectTag:uint = 1;
      
      private var pageNum:uint = 1;
      
      private var curPage:uint = 1;
      
      public var btn_back:SimpleButton;
      
      public var btn_cz:SimpleButton;
      
      public var btn_play1:SimpleButton;
      
      public var btn_play2:SimpleButton;
      
      public var btn_buyall:SimpleButton;
      
      public var btn_buybs:SimpleButton;
      
      public var btn_buysz:SimpleButton;
      
      public var btn_buycw:SimpleButton;
      
      public var btn_buydj:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public var btn_upPage:SimpleButton;
      
      public var btn_nextPage:SimpleButton;
      
      public var txt_page:TextField;
      
      public var txt_money:TextField;
      
      public var st0:ShopThing;
      
      public var st1:ShopThing;
      
      public var st2:ShopThing;
      
      public var st3:ShopThing;
      
      public var st4:ShopThing;
      
      public var st5:ShopThing;
      
      public var st6:ShopThing;
      
      public var st7:ShopThing;
      
      public var st8:ShopThing;
      
      private var payMoneyVar:PayMoneyVar;
      
      private var fashionEquip:MyEquipObj;
      
      private var windEquip:MyEquipObj;
      
      private var sendList:Array;
      
      var playerbtnState;
      
      public function Micropayment()
      {
         sellbsList = [];
         sellcwList = [];
         sellszList = [];
         selldjList = [];
         sendList = [];
         super();
         gc = Config.getInstance();
         payMoneyVar = PayMoneyVar.getInstance();
         player = gc.player1;
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      public function getUser() : User
      {
         return player;
      }
      
      private function added(e:Event) : void
      {
         trace("Micropayment---added");
         gc.isingameshop = true;
         this.setTxt();
         this.sendList = [];
         sellbsList.push(gc.allEquip.findByName("xns1"));
         sellbsList.push(gc.allEquip.findByName("kly3"));
         sellbsList.push(gc.allEquip.findByName("wpqhs1"));
         sellbsList.push(gc.allEquip.findByName("wpqhs2"));
         sellbsList.push(gc.allEquip.findByName("wpqhs3"));
         sellbsList.push(gc.allEquip.findByName("wpqhs4"));
         sellbsList.push(gc.allEquip.findByName("sms2"));
         sellbsList.push(gc.allEquip.findByName("sms3"));
         sellbsList.push(gc.allEquip.findByName("mfs2"));
         sellbsList.push(gc.allEquip.findByName("mfs3"));
         sellbsList.push(gc.allEquip.findByName("gjs2"));
         sellbsList.push(gc.allEquip.findByName("gjs3"));
         sellbsList.push(gc.allEquip.findByName("fys2"));
         sellbsList.push(gc.allEquip.findByName("fys3"));
         sellbsList.push(gc.allEquip.findByName("wpxyf"));
         sellbsList.push(gc.allEquip.findByName("wpbdf"));
         sellbsList.push(gc.allEquip.findByName("wptlz"));
         sellbsList.push(gc.allEquip.findByName("wpllz"));
         sellbsList.push(gc.allEquip.findByName("wphlz"));
         sellbsList.push(gc.allEquip.findByName("wpflz"));
         sellbsList.push(gc.allEquip.findByName("wpslz"));
         selldjList.push(gc.allEquip.findByName("cdjyys"));
         selldjList.push(gc.allEquip.findByName("dlhys"));
         selldjList.push(gc.allEquip.findByName("lxzhs"));
         selldjList.push(gc.allEquip.findByName("sxzhs"));
         selldjList.push(gc.allEquip.findByName("hmzjns3"));
         selldjList.push(gc.allEquip.findByName("hyjjjns3"));
         selldjList.push(gc.allEquip.findByName("smbjns3"));
         selldjList.push(gc.allEquip.findByName("jhsjjns3"));
         selldjList.push(gc.allEquip.findByName("tmcjns3"));
         selldjList.push(gc.allEquip.findByName("syzqjns3"));
         selldjList.push(gc.allEquip.findByName("mmwjns3"));
         selldjList.push(gc.allEquip.findByName("mdsjns3"));
         selldjList.push(gc.allEquip.findByName("wpst_5"));
         selldjList.push(gc.allEquip.findByName("wpst_4"));
         selldjList.push(gc.allEquip.findByName("wpst_3"));
         selldjList.push(gc.allEquip.findByName("wpsh_1"));
         selldjList.push(gc.allEquip.findByName("wpsh_2"));
         selldjList.push(gc.allEquip.findByName("xnhdl"));
         selldjList.push(gc.allEquip.findByName("sz"));
         selldjList.push(gc.allEquip.findByName("zz"));
         selldjList.push(gc.allEquip.findByName("jbc"));
         selldjList.push(gc.allEquip.findByName("szj"));
         selldjList.push(gc.allEquip.findByName("ml"));
         selldjList.push(gc.allEquip.findByName("gz"));
         selldjList.push(gc.allEquip.findByName("bmd"));
         selldjList.push(gc.allEquip.findByName("yp"));
         selldjList.push(gc.allEquip.findByName("lhys"));
         selldjList.push(gc.allEquip.findByName("jyd3"));
         selldjList.push(gc.allEquip.findByName("djyys"));
         selldjList.push(gc.allEquip.findByName("css_2"));
         selldjList.push(gc.allEquip.findByName("mpyj"));
         selldjList.push(gc.allEquip.findByName("css12"));
         selldjList.push(gc.allEquip.findByName("css18"));
         selldjList.push(gc.allEquip.findByName("sbjyd"));
         selldjList.push(gc.allEquip.findByName("jyys"));
         sellcwList.push(gc.allEquip.findByName("nianjhdd"));
         sellcwList.push(gc.allEquip.findByName("wpcsd"));
         sellcwList.push(gc.allEquip.findByName("wphhd"));
         sellcwList.push(gc.allEquip.findByName("cwzzxld"));
         sellcwList.push(gc.allEquip.findByName("cwjnxld"));
         sellszList.push(gc.allEquip.findByName("ptzqsz"));
         sellszList.push(gc.allEquip.findByName("ptttzssz"));
         sellszList.push(gc.allEquip.findByName("ptnmwsz"));
         sellszList.push(gc.allEquip.findByName("ptzlwsz"));
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("GetMoneySuccess",getMoneySuccess);
         btn_back.addEventListener("click",backClick);
         btn_cz.addEventListener("click",czClick);
         btn_play1.addEventListener("click",play1Click);
         btn_play2.addEventListener("click",play2Click);
         btn_play1.dispatchEvent(new MouseEvent("click"));
         btn_buycw.addEventListener("click",buycwClick);
         btn_buyall.addEventListener("click",buyallClick);
         btn_buysz.addEventListener("click",buyszClick);
         btn_buybs.addEventListener("click",buybsClick);
         btn_buydj.addEventListener("click",buydjClick);
         btn_upPage.addEventListener("click",upPageClick);
         btn_nextPage.addEventListener("click",nextPageClick);
         if(gc.playNum == 1)
         {
            btn_play2.visible = false;
         }
         else
         {
            btn_play2.visible = true;
         }
         payMoneyVar.money = 2000;
         btn_buyall.dispatchEvent(new MouseEvent("click"));
      }
      
      private function removed(e:Event) : void
      {
         gc.isingameshop = false;
         this.sendList = [];
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("GetMoneySuccess",getMoneySuccess);
         btn_back.removeEventListener("click",backClick);
         btn_cz.removeEventListener("click",czClick);
         btn_play1.removeEventListener("click",play1Click);
         btn_play2.removeEventListener("click",play2Click);
         btn_buycw.removeEventListener("click",buycwClick);
         btn_buyall.removeEventListener("click",buyallClick);
         btn_buysz.removeEventListener("click",buyszClick);
         btn_buybs.removeEventListener("click",buybsClick);
         btn_upPage.removeEventListener("click",upPageClick);
         btn_nextPage.removeEventListener("click",nextPageClick);
         btnState = null;
         this.player = null;
      }
      
      private function setShopThingEquipment() : void
      {
         var i:* = 0;
         var sellList:Array = [];
         switch(int(this.selectTag) - 1)
         {
            case 0:
               sellList.unshift(gc.allEquip.findByName("_ssggjtg2015"));
               if(selldjList.length > 0)
               {
                  sellList = sellList.concat(selldjList);
               }
               if(sellszList.length > 0)
               {
                  sellList = sellList.concat(sellszList);
               }
               if(sellcwList.length > 0)
               {
                  sellList = sellList.concat(sellcwList);
               }
               if(sellbsList.length > 0)
               {
                  sellList = sellList.concat(sellbsList);
               }
               break;
            case 1:
               sellList = sellbsList;
               break;
            case 2:
               sellList = sellcwList;
               break;
            case 3:
               sellList = sellszList;
               break;
            case 4:
               sellList = selldjList;
         }
         for(i = uint(0); i < 9; )
         {
            this["st" + i].clearEquipment();
            this["st" + i].visible = true;
            if(sellList[i + (curPage - 1) * 9])
            {
               this["st" + i].setEquipment(sellList[i + (curPage - 1) * 9]);
            }
            else
            {
               this["st" + i].visible = false;
            }
            i++;
         }
         var slen:uint = sellList.length;
         this.pageNum = Math.ceil(slen / 9);
         if(this.pageNum == 0)
         {
            this.pageNum = 1;
         }
         this.setTxt();
      }
      
      private function setTxt() : void
      {
         this.txt_page.text = this.curPage + "/" + this.pageNum;
         this.txt_money.text = gc.gameVip.dataObject.lastMoney + "";
      }
      
      private function backClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("SelectOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function czClick(e:MouseEvent) : void
      {
         var rechargeTips:RechargeTips = new RechargeTips();
         this.parent.addChild(rechargeTips);
         if(gc.isAirGame)
         {
            gc.isczclick = true;
            gc.openPay();
            return;
         }
         if(GMain.serviceHold)
         {
            gc.isczclick = true;
            GMain.serviceHold.payMoney_As3(payMoneyVar);
         }
      }
      
      private function play1Click(e:MouseEvent) : void
      {
         player = gc.player1;
         this.setTxt();
         gc.eventManger.dispatchEvent(new CommonEvent("ChangePlayer"));
         if(btn_play1.upState != btn_play1.overState)
         {
            if(playerbtnState)
            {
               btn_play2.upState = playerbtnState;
            }
            playerbtnState = e.target.upState;
            e.target.upState = e.target.overState;
         }
      }
      
      private function play2Click(e:MouseEvent) : void
      {
         player = gc.player2;
         this.setTxt();
         gc.eventManger.dispatchEvent(new CommonEvent("ChangePlayer"));
         if(btn_play2.upState != btn_play2.overState)
         {
            if(playerbtnState)
            {
               btn_play1.upState = playerbtnState;
            }
            playerbtnState = e.target.upState;
            e.target.upState = e.target.overState;
         }
      }
      
      private function buyallClick(e:MouseEvent) : void
      {
         this.selectTag = 1;
         this.curPage = 1;
         setShopThingEquipment();
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn_buyall";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function buybsClick(e:MouseEvent) : void
      {
         this.selectTag = 2;
         this.curPage = 1;
         setShopThingEquipment();
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn_buybs";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function buydjClick(e:MouseEvent) : void
      {
         this.selectTag = 5;
         this.curPage = 1;
         setShopThingEquipment();
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn_buydj";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function buycwClick(e:MouseEvent) : void
      {
         this.selectTag = 3;
         this.curPage = 1;
         setShopThingEquipment();
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn_buycw";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function buyszClick(e:MouseEvent) : void
      {
         this.selectTag = 4;
         this.curPage = 1;
         setShopThingEquipment();
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "btn_buysz";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function upPageClick(e:MouseEvent) : void
      {
         if(curPage > 1)
         {
            curPage--;
            setShopThingEquipment();
            this.setTxt();
         }
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         if(curPage < this.pageNum)
         {
            curPage++;
            setShopThingEquipment();
            this.setTxt();
         }
      }
      
      public function getFashionEquipId() : uint
      {
         if(fashionEquip)
         {
            return fashionEquip.showid;
         }
         return 1;
      }
      
      public function getWindEquipId() : uint
      {
         if(windEquip)
         {
            return windEquip.showid;
         }
         return 1;
      }
      
      public function buySuccess(e:CommonEvent) : void
      {
         var i:* = 0;
         var obj:* = null;
         var j:* = 0;
         var nsz:* = null;
         var send_obj:* = null;
         var send2_obj:* = null;
         j = 0;
         send_obj = null;
         send2_obj = null;
         var x:* = 0;
         var newsz:* = null;
         var send_obj1:* = null;
         send2_obj = null;
         gc.gameVip.dataObject.lastMoney = e.data[0];
         this.setTxt();
         var bool:Boolean = false;
         for(i = uint(0); i < 9; )
         {
            obj = this["st" + i].getNumAndEquip();
            if(obj.thingnum != 0)
            {
               if(this.selectTag == 1)
               {
                  if(MyEquipObj(obj.equip).type == "zbsz" || MyEquipObj(obj.equip).type == "zbcb")
                  {
                     for(j = uint(0); j < obj.thingnum; )
                     {
                        nsz = gc.allEquip.findByName(MyEquipObj(obj.equip).getFillName());
                        nsz.setFashionTime(gc.dataObjectInstance.curDate);
                        this.player.szlist.push(nsz);
                        if(gc.isHideDebug)
                        {
                           send_obj = [];
                           send_obj.push(FinancialInfo.getItemIdByName(nsz.getFillName(),0));
                           send_obj.push(1);
                           send_obj.push(1);
                           this.addArray(send_obj);
                           send2_obj = [];
                           send2_obj.push(FinancialInfo.getItemIdByName(nsz.getFillName(),0));
                           send2_obj.push(0);
                           send2_obj.push(1);
                           this.addArray(send2_obj);
                        }
                        j++;
                     }
                  }
                  else if(MyEquipObj(obj.equip).type == "zbwp" || MyEquipObj(obj.equip).type == "wpqhs")
                  {
                     bool = true;
                     gc.putQhsInBackPack(this.player,MyEquipObj(obj.equip).getFillName(),obj.thingnum,true,true);
                  }
                  else
                  {
                     for(j = uint(0); j < obj.thingnum; )
                     {
                        this.player.zblist.push(obj.equip);
                        if(MyEquipObj(obj.equip).getFillName() == "_ssggjtg" || MyEquipObj(obj.equip).getFillName() == "_ssggjtg2015")
                        {
                           send_obj = [];
                           send_obj.push(FinancialInfo.getItemIdByName(MyEquipObj(obj.equip).getFillName(),0));
                           send_obj.push(1);
                           send_obj.push(1);
                           this.addArray(send_obj);
                           send2_obj = [];
                           send2_obj.push(FinancialInfo.getItemIdByName(MyEquipObj(obj.equip).getFillName(),0));
                           send2_obj.push(0);
                           send2_obj.push(1);
                           this.addArray(send2_obj);
                        }
                        j++;
                     }
                  }
               }
               else if(this.selectTag == 2 || this.selectTag == 5 || this.selectTag == 3)
               {
                  bool = true;
                  gc.putQhsInBackPack(this.player,obj.equip.getFillName(),obj.thingnum,true,true);
               }
               else if(this.selectTag == 4)
               {
                  for(x = uint(0); x < obj.thingnum; )
                  {
                     newsz = gc.allEquip.findByName(MyEquipObj(obj.equip).getFillName());
                     newsz.setFashionTime(gc.dataObjectInstance.curDate);
                     if(gc.isHideDebug)
                     {
                        send_obj1 = [];
                        send_obj1.push(FinancialInfo.getItemIdByName(newsz.getFillName(),0));
                        send_obj1.push(1);
                        send_obj1.push(1);
                        this.addArray(send_obj1);
                        send2_obj = [];
                        send2_obj.push(FinancialInfo.getItemIdByName(newsz.getFillName(),0));
                        send2_obj.push(0);
                        send2_obj.push(1);
                        this.addArray(send2_obj);
                     }
                     this.player.szlist.push(newsz);
                     x++;
                  }
               }
               if(sendList.length > 0)
               {
                  if(!bool)
                  {
                     FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,sendList,gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
                     this.sendList = [];
                  }
               }
               this["st" + i].buySuccess();
            }
            i++;
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function addArray(_ary:Array) : void
      {
         for each(var data in this.sendList)
         {
            if(data[0] == _ary[0] && data[1] == _ary[1])
            {
               var _loc3_:int = 2;
               var _loc4_:* = data[_loc3_] + _ary[2];
               data[_loc3_] = _loc4_;
               return;
            }
         }
         this.sendList.push(_ary);
      }
      
      public function getMoneySuccess(e:CommonEvent) : void
      {
         var i:* = 0;
         gc.gameVip.dataObject.lastMoney = e.data[0];
         this.setTxt();
         for(i = uint(0); i < 9; )
         {
            this["st" + i].getMoneySuccess();
            i++;
         }
      }
      
      public function getAllMoney() : int
      {
         return 99999;
      }
   }
}
