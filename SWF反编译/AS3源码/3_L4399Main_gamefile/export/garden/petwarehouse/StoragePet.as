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
   
   public class StoragePet extends Sprite
   {
       
      
      public var listtxt:TextField;
      
      public var pnametxt:TextField;
      
      public var levtxt:TextField;
      
      public var atxt:TextField;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var jcbtn:SimpleButton;
      
      private var player:User;
      
      private var gc:Config;
      
      private var pif:PetInfo;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 2;
      
      private var pageNum:uint = 5;
      
      public function StoragePet()
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
         jcbtn.addEventListener("click",jcClick);
         gc.eventManger.addEventListener("REFRESHPETWAREHOUSEINTERFACE",refreshPetWare);
         if(gc.gameVip.getVipLevel() >= 3)
         {
            prePage.visible = true;
            nextPage.visible = true;
         }
         else
         {
            prePage.visible = false;
            nextPage.visible = false;
         }
      }
      
      private function removed(e:Event) : void
      {
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         jcbtn.removeEventListener("click",jcClick);
         gc.eventManger.removeEventListener("REFRESHPETWAREHOUSEINTERFACE",refreshPetWare);
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
         this.setCurPage(-1);
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
         this.setCurPage(1);
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
      
      public function setCurPage(cp:int) : void
      {
         var lastPage:uint = this.curPage;
         this.curPage += cp;
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
            if(this.player.petsAry[i + (curPage - 1) * 5] != undefined)
            {
               petList["petname"].text = this.player.petsAry[i + (curPage - 1) * 5].getPetChinaName();
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
         var lage:* = 0;
         var canCatchNum:int = 0;
         if(gc.gameVip.getVipLevel() < 3)
         {
            lage = uint(1 + int(this.player.getCurLevel() / 10));
            canCatchNum = lage < 5 ? lage : 5;
            this.listtxt.text = "宠物列表" + this.player.petsAry.length + "/" + canCatchNum;
         }
         else
         {
            this.listtxt.text = "宠物列表" + this.player.petsAry.length + "/10";
         }
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
         for(var plen:uint = this.player.petsAry.length; plen-- > 0; )
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
         if(this.player.petsAry[id])
         {
            return this.player.petsAry[id];
         }
         return null;
      }
      
      public function setPetInfomation(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setShow();
      }
      
      private function jcClick(e:MouseEvent) : void
      {
         var upnum:* = 0;
         var sit:* = 0;
         if(this.pif)
         {
            upnum = uint(5 * gc.dataObject.hasbuypetsecondwarehouse);
            if(gc.petlist.length < upnum)
            {
               sit = uint(this.player.petsAry.indexOf(this.pif));
               if(sit != -1)
               {
                  if(this.pif.isFight)
                  {
                     this.pif.isFight = 0;
                  }
                  this.player.petsAry.splice(sit,1);
                  gc.petlist.push(this.pif);
                  this.pif = null;
                  this.setShow();
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
               gc.ts.setTxt("宠物仓库已满");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      public function setPlayer(_player:User) : void
      {
         this.pif = null;
         this.setShow();
         this.player = _player;
         this.setPetList();
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
