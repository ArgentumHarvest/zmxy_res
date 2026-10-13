package export.garden.petwarehouse
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import petInfo.PetInfo;
   import user.User;
   
   public class RetrievePet extends Sprite
   {
       
      
      public var listtxt:TextField;
      
      public var pnametxt:TextField;
      
      public var levtxt:TextField;
      
      public var atxt:TextField;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var thirdPage:SimpleButton;
      
      public var qhbtn:SimpleButton;
      
      private var gc:Config;
      
      private var pif:PetInfo;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 3;
      
      private var pageNum:uint = 5;
      
      private var player:User;
      
      public function RetrievePet()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         prePage.addEventListener("click",prePageClick);
         nextPage.addEventListener("click",nextPageClick);
         thirdPage.addEventListener("click",thirdPageClick);
         qhbtn.addEventListener("click",qhClick);
         gc.eventManger.addEventListener("REFRESHPETWAREHOUSEINTERFACE",refreshPetWare);
         this.setPageBtn();
         this.setShow();
         this.setPetList();
      }
      
      private function removed(e:Event) : void
      {
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         thirdPage.removeEventListener("click",thirdPageClick);
         qhbtn.removeEventListener("click",qhClick);
         gc.eventManger.removeEventListener("REFRESHPETWAREHOUSEINTERFACE",refreshPetWare);
      }
      
      public function setPageBtn() : void
      {
         if(gc.dataObject.hasbuypetsecondwarehouse == 1)
         {
            prePage.visible = false;
            nextPage.visible = false;
            thirdPage.visible = false;
         }
         else if(gc.dataObject.hasbuypetsecondwarehouse == 2)
         {
            prePage.visible = true;
            nextPage.visible = true;
            thirdPage.visible = false;
         }
         else
         {
            prePage.visible = true;
            nextPage.visible = true;
            thirdPage.visible = true;
         }
      }
      
      private function setShow() : void
      {
         if(this.pif)
         {
            this.pnametxt.text = "名字:" + this.pif.getPetChinaName();
            this.atxt.text = "悟性:" + this.pif.getperception() + "根骨:" + this.pif.getwarpower() + "灵力:" + this.pif.gettechnique();
            this.levtxt.text = "等级:" + this.pif.getLevel();
         }
         else
         {
            this.pnametxt.text = "";
            this.atxt.text = "";
            this.levtxt.text = "";
         }
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         this.pif = null;
         this.setShow();
         this.setCurPage(1);
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "prePage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         this.pif = null;
         this.setShow();
         this.setCurPage(2);
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "nextPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function thirdPageClick(e:MouseEvent) : void
      {
         this.pif = null;
         this.setShow();
         this.setCurPage(3);
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "thirdPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      public function setCurPage(cp:int) : void
      {
         var lastPage:uint = this.curPage;
         this.curPage = cp;
         if(this.curPage > this.allPage)
         {
            this.curPage = this.allPage;
         }
         if(this.curPage < 1)
         {
            this.curPage = 1;
         }
         if(this.curPage != lastPage)
         {
            this.setPetList();
         }
      }
      
      public function setPetList() : void
      {
         var i:* = 0;
         var petList:* = null;
         this.removedPetList();
         this.setTitleTxt();
         for(i = uint(0); i < 5; )
         {
            petList = AUtils.getNewObj("garden_petlist") as Sprite;
            petList.buttonMode = true;
            if(gc.petlist[i + (curPage - 1) * 5] != undefined)
            {
               petList["petname"].text = gc.petlist[i + (curPage - 1) * 5].getPetChinaName();
               petList.name = "garden_petlist" + i;
               petList.x = 1.3;
               petList.y = 22.5 + i * petList.height + 5;
               this.addChild(petList);
               petList.addEventListener("click",plClick);
            }
            i++;
         }
      }
      
      private function removedPetList() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 5; )
         {
            if(this.getChildByName("garden_petlist" + i))
            {
               this.getChildByName("garden_petlist" + i).removeEventListener("click",plClick);
               this.removeChild(this.getChildByName("garden_petlist" + i));
            }
            i++;
         }
      }
      
      private function setTitleTxt() : void
      {
         this.listtxt.text = "宠物列表" + gc.petlist.length + "/" + 5 * gc.dataObject.hasbuypetsecondwarehouse;
      }
      
      private function plClick(e:MouseEvent) : void
      {
         trace("plClick");
         var txtformat:TextFormat = new TextFormat();
         txtformat.color = "0x381d09";
         var pid:uint = int(String(e.currentTarget.name).substr(14,1));
         var selectPet:PetInfo = this.findPetInCurrentPetListById(pid + (curPage - 1) * 5);
         if(selectPet == null)
         {
            throw new Error("获取选择的宠物为null");
         }
         for(var plen:uint = gc.petlist.length; plen-- > 0; )
         {
            if(this.getChildByName("garden_petlist" + plen))
            {
               this.getChildByName("garden_petlist" + plen)["petname"].setTextFormat(txtformat);
            }
         }
         txtformat.color = "0xfdfcba";
         e.currentTarget.petname.setTextFormat(txtformat);
         trace("selectPet:" + selectPet);
         this.setPetInfomation(selectPet);
      }
      
      private function findPetInCurrentPetListById(id:uint) : PetInfo
      {
         if(gc.petlist[id])
         {
            return gc.petlist[id];
         }
         return null;
      }
      
      public function setPetInfomation(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setShow();
      }
      
      private function qhClick(e:MouseEvent) : void
      {
         var upnum:* = 0;
         var sit:* = 0;
         if(this.pif)
         {
            upnum = uint(5);
            if(gc.gameVip.getVipLevel() >= 3)
            {
               upnum = uint(10);
            }
            else
            {
               upnum = uint(5);
            }
            if(this.player.petsAry.length < upnum)
            {
               sit = uint(gc.petlist.indexOf(this.pif));
               if(sit != -1)
               {
                  gc.petlist.splice(sit,1);
                  this.pif.isFight = 0;
                  this.player.petsAry.push(this.pif);
                  this.pif = null;
                  this.setShow();
                  gc.ts.setTxt("宠物已放入" + (this.player.controlPlayer + 1) + "P玩家宠物背包");
                  gc.stage.addChild(gc.ts);
                  gc.eventManger.dispatchEvent(new CommonEvent("REFRESHPETWAREHOUSEINTERFACE"));
               }
               else
               {
                  gc.ts.setTxt("宠物不存在");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("宠物背包已满");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      public function setPlayer(_player:User) : void
      {
         this.player = _player;
      }
      
      private function refreshPetWare(e:CommonEvent) : void
      {
         this.setShow();
         this.setPetList();
      }
      
      public function getPif() : PetInfo
      {
         return this.pif;
      }
   }
}
