package export.alliance
{
   import config.Config;
   import event.CommonEvent;
   import export.honor.AllianceSprite;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   import user.User;
   
   public class AllianceShop extends Sprite
   {
       
      
      private var selltxList:Array;
      
      private var selldjList:Array;
      
      private var player:User;
      
      private var gc:Config;
      
      private var selectTag:uint = 1;
      
      private var pageNum:uint = 1;
      
      private var curPage:uint = 1;
      
      public var btn_buytx:SimpleButton;
      
      public var btn_buydj:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public var btn_play1:SimpleButton;
      
      public var btn_play2:SimpleButton;
      
      public var btn_upPage:SimpleButton;
      
      public var btn_nextPage:SimpleButton;
      
      public var txt_page:TextField;
      
      public var txt_money:TextField;
      
      public var st0:AllianceShowThing;
      
      public var st1:AllianceShowThing;
      
      public var st2:AllianceShowThing;
      
      public var st3:AllianceShowThing;
      
      public var st4:AllianceShowThing;
      
      public var st5:AllianceShowThing;
      
      public var st6:AllianceShowThing;
      
      public var st7:AllianceShowThing;
      
      public var st8:AllianceShowThing;
      
      public var xbtn:SimpleButton;
      
      var playerbtnState;
      
      public function AllianceShop()
      {
         selltxList = [];
         selldjList = [];
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         btn_upPage.addEventListener("click",upPageClick);
         btn_nextPage.addEventListener("click",nextPageClick);
         xbtn.addEventListener("click",xClick);
         btn_buytx.addEventListener("click",buytxClick);
         btn_buydj.addEventListener("click",buydjClick);
         btn_play1.addEventListener("click",play1Click);
         btn_play2.visible = false;
         if(gc.player2.roleid > 0)
         {
            btn_play2.visible = true;
            btn_play2.addEventListener("click",play2Click);
         }
         btn_play1.dispatchEvent(new MouseEvent("click"));
         selltxList.push(gc.allEquip.findByName("_zmxyanniversary"));
         selltxList.push(gc.allEquip.findByName("_4399zswj"));
         var tm:MyEquipObj = gc.allEquip.findByName("wptm");
         tm.setnum(100);
         var xt:MyEquipObj = gc.allEquip.findByName("wpxt");
         xt.setnum(100);
         var sc:MyEquipObj = gc.allEquip.findByName("wpsc");
         sc.setnum(100);
         selldjList.push(tm);
         selldjList.push(xt);
         selldjList.push(sc);
         selldjList.push(gc.allEquip.findByName("wpbsz"));
         selldjList.push(gc.allEquip.findByName("wplwl"));
         if(gc.honorData.allianceLevel >= 3)
         {
            selldjList.push(gc.allEquip.findByName("bmd"));
         }
         if(gc.honorData.allianceLevel >= 4)
         {
            selldjList.push(gc.allEquip.findByName("yp"));
            selldjList.push(gc.allEquip.findByName("gz"));
         }
         if(gc.honorData.allianceLevel >= 4)
         {
            selldjList.push(gc.allEquip.findByName("ml"));
         }
         if(gc.honorData.allianceLevel >= 5)
         {
            selldjList.push(gc.allEquip.findByName("sz"));
            selldjList.push(gc.allEquip.findByName("jbc"));
         }
         if(gc.honorData.allianceLevel >= 6)
         {
            selldjList.push(gc.allEquip.findByName("zz"));
            selldjList.push(gc.allEquip.findByName("szj"));
         }
         btn_buytx.dispatchEvent(new MouseEvent("click"));
         AllianceSprite.getInstance().addEventListener("buy_item_success",buySuccess);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         btn_upPage.removeEventListener("click",upPageClick);
         btn_nextPage.removeEventListener("click",nextPageClick);
         xbtn.removeEventListener("click",xClick);
         btn_buytx.removeEventListener("click",buytxClick);
         btn_buydj.removeEventListener("click",buydjClick);
         btn_play1.removeEventListener("click",play1Click);
         btn_play2.removeEventListener("click",play2Click);
         AllianceSprite.getInstance().removeEventListener("buy_item_success",buySuccess);
      }
      
      private function buySuccess(e:CommonEvent) : void
      {
         var i:* = 0;
         var obj:* = null;
         var j:* = 0;
         this.setTxt();
         for(i = uint(0); i < 9; )
         {
            obj = this["st" + i].getNumAndEquip();
            if(obj.thingnum != 0)
            {
               if(this.selectTag == 2)
               {
                  if(MyEquipObj(obj.equip).type == "zbtx")
                  {
                     for(j = uint(0); j < obj.thingnum; )
                     {
                        this.player.zblist.push(obj.equip);
                        j++;
                     }
                  }
               }
               else if(this.selectTag == 3)
               {
                  gc.putQhsInBackPack(this.player,(obj.equip as MyEquipObj).getFillName(),obj.thingnum);
               }
               this["st" + i].buySuccess();
            }
            i++;
         }
         gc.ts.setTxt("购买成功");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function play1Click(e:MouseEvent) : void
      {
         player = gc.player1;
         this.setTxt();
         gc.eventManger.dispatchEvent(new CommonEvent("AllianceChangePlayer"));
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
         gc.eventManger.dispatchEvent(new CommonEvent("AllianceChangePlayer"));
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
      
      private function buytxClick(e:MouseEvent) : void
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
         lastBtn = "btn_buytx";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function buydjClick(e:Event) : void
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
         lastBtn = "btn_buydj";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function setShopThingEquipment() : void
      {
         var i:* = 0;
         var sellList:Array = [];
         switch(int(this.selectTag) - 1)
         {
            case 0:
               if(selltxList.length > 0)
               {
                  sellList = sellList.concat(selltxList);
               }
               break;
            case 1:
               sellList = selltxList;
               break;
            case 2:
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
      
      private function upPageClick(e:MouseEvent) : void
      {
         if(curPage > 1)
         {
            curPage--;
            this.setShopThingEquipment();
            this.setTxt();
         }
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         if(curPage < this.pageNum)
         {
            curPage++;
            this.setShopThingEquipment();
            this.setTxt();
         }
      }
      
      private function setTxt() : void
      {
         this.txt_page.text = this.curPage + "/" + this.pageNum;
         this.txt_money.text = gc.honorData.score + "";
      }
      
      public function getUser() : User
      {
         return player;
      }
      
      public function getAllMoney() : int
      {
         return gc.honorData.score;
      }
      
      public function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
