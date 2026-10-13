package export.garden
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import petInfo.PetInfo;
   import user.User;
   
   public class PetForgetAndBecomeChild extends Sprite
   {
       
      
      public var listtxt:TextField;
      
      public var leveltxt:TextField;
      
      public var txtname:TextField;
      
      public var dqtxt:TextField;
      
      public var qldtxt:TextField;
      
      public var btn_close:SimpleButton;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      public var play1btn:SimpleButton;
      
      public var play2btn:SimpleButton;
      
      public var delskillbtn:SimpleButton;
      
      public var rebtn:SimpleButton;
      
      public var qualitymc:MovieClip;
      
      public var pethead:MovieClip;
      
      private var gc:Config;
      
      private var player:User;
      
      private var pif:PetInfo;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var lastBtn1:String = "";
      
      private var btnState1;
      
      private var lastBtn2:String = "";
      
      private var btnState2;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 2;
      
      private var pageNum:uint = 5;
      
      private var fs:ForgetSkill;
      
      private var bc:BecomeChild;
      
      public function PetForgetAndBecomeChild()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         delskillbtn.addEventListener("click",delClick);
         rebtn.addEventListener("click",reClick);
         play1btn.addEventListener("click",player1Click);
         play2btn.addEventListener("click",player2Click);
         prePage.addEventListener("click",prePageClick);
         nextPage.addEventListener("click",nextPageClick);
         btn_close.addEventListener("click",xClick);
         gc.eventManger.addEventListener("BECOMECHILDSUCCESS",bcSuccess);
         gc.eventManger.addEventListener("GetMoneySuccess",getMoneySuccess);
         gc.eventManger.addEventListener("RefreshTxt",refreshTxt);
         if(gc.playNum == 1)
         {
            this.play2btn.visible = false;
            this.play2btn.removeEventListener("click",player2Click);
         }
         this.play1btn.dispatchEvent(new MouseEvent("click"));
         delskillbtn.dispatchEvent(new MouseEvent("click"));
         this.setShow();
      }
      
      private function removed(e:Event) : void
      {
         delskillbtn.removeEventListener("click",delClick);
         rebtn.removeEventListener("click",reClick);
         play1btn.removeEventListener("click",player1Click);
         play2btn.removeEventListener("click",player2Click);
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         btn_close.removeEventListener("click",xClick);
         gc.eventManger.removeEventListener("BECOMECHILDSUCCESS",bcSuccess);
         gc.eventManger.removeEventListener("GetMoneySuccess",getMoneySuccess);
         gc.eventManger.removeEventListener("RefreshTxt",refreshTxt);
         btnState = null;
         btnState2 = null;
      }
      
      private function refreshTxt(e:CommonEvent) : void
      {
         this.setShow();
      }
      
      private function getMoneySuccess(e:CommonEvent) : void
      {
         this.setShow();
      }
      
      private function bcSuccess(e:CommonEvent) : void
      {
         this.setPetList();
         this.setShow();
      }
      
      private function delClick(e:Event) : void
      {
         if(fs && this.contains(fs))
         {
            this.removeChild(fs);
            fs = null;
         }
         if(bc && this.contains(bc))
         {
            this.removeChild(bc);
            bc = null;
         }
         fs = new ForgetSkill(this.pif);
         fs.x = 324.45;
         fs.y = 331.9;
         this.addChild(fs);
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "delskillbtn";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function reClick(e:Event) : void
      {
         if(fs && this.contains(fs))
         {
            this.removeChild(fs);
            fs = null;
         }
         if(bc && this.contains(bc))
         {
            this.removeChild(bc);
            bc = null;
         }
         bc = new BecomeChild(this.pif);
         bc.x = 324.45;
         bc.y = 331.9;
         this.addChild(bc);
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "rebtn";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function xClick(e:Event) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         this.pif = null;
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
      
      private function setPetList() : void
      {
         var i:* = 0;
         var petList:* = null;
         this.removedPetList();
         this.setTitleTxt();
         for(i = uint(0); i < 5; )
         {
            petList = AUtils.getNewObj("petlist") as Sprite;
            if(this.player.petsAry[i + (curPage - 1) * 5] != undefined)
            {
               petList["petname"].text = this.player.petsAry[i + (curPage - 1) * 5].getPetChinaName();
               petList.name = "petlist" + i;
               petList.x = 479;
               petList.y = 138 + i * petList.height + 5;
               this.addChild(petList);
               petList.addEventListener("click",plClick);
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
      
      private function removedPetList() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 5; )
         {
            if(this.getChildByName("petlist" + i))
            {
               this.getChildByName("petlist" + i).removeEventListener("click",plClick);
               this.removeChild(this.getChildByName("petlist" + i));
            }
            i++;
         }
      }
      
      private function plClick(e:MouseEvent) : void
      {
         trace("plClick");
         var txtformat:TextFormat = new TextFormat();
         txtformat.color = "0x381d09";
         var pid:uint = int(String(e.currentTarget.name).substr(7,1));
         var selectPet:PetInfo = this.findPetInCurrentPetListById(pid + (curPage - 1) * 5);
         if(selectPet == null)
         {
            throw new Error("获取选择的宠物为null");
         }
         for(var plen:uint = this.player.petsAry.length; plen-- > 0; )
         {
            if(this.getChildByName("petlist" + plen))
            {
               this.getChildByName("petlist" + plen)["petname"].setTextFormat(txtformat);
            }
         }
         txtformat.color = "0xfdfcba";
         e.currentTarget.petname.setTextFormat(txtformat);
         trace("selectPet:" + selectPet);
         this.setPetInfomation(selectPet);
      }
      
      public function setPetInfomation(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setShow();
         if(this.fs)
         {
            this.fs.changePetInfo(this.pif);
         }
         if(this.bc)
         {
            this.bc.changePetInfo(this.pif);
         }
      }
      
      private function findPetInCurrentPetListById(id:uint) : PetInfo
      {
         if(this.player.petsAry[id])
         {
            return this.player.petsAry[id];
         }
         return null;
      }
      
      private function player1Click(e:MouseEvent) : void
      {
         if(gc.player1)
         {
            this.pif = null;
            this.player = gc.player1;
            this.setPetList();
            if(btnState1)
            {
               if(lastBtn1 != "")
               {
                  this[lastBtn1].upState = btnState1;
               }
            }
            lastBtn1 = "play1btn";
            btnState1 = e.target.upState;
            e.target.upState = e.target.downState;
         }
      }
      
      private function player2Click(e:MouseEvent) : void
      {
         if(gc.player2)
         {
            this.pif = null;
            this.player = gc.player2;
            this.setPetList();
            if(btnState1)
            {
               if(lastBtn1 != "")
               {
                  this[lastBtn1].upState = btnState1;
               }
            }
            lastBtn1 = "play2btn";
            btnState1 = e.target.upState;
            e.target.upState = e.target.downState;
         }
      }
      
      private function setShow() : void
      {
         if(pif)
         {
            pethead.gotoAndStop(pif.getPetChinaName());
            qualitymc.gotoAndStop(pif.getquality());
            leveltxt.text = pif.getLevel() + "";
            this.txtname.text = pif.getPetChinaName() + "";
            dqtxt.text = gc.gameVip.dataObject.lastMoney + "";
            qldtxt.text = this.pif.getpotential() + "";
         }
         else
         {
            pethead.gotoAndStop(1);
            qualitymc.gotoAndStop(3);
            leveltxt.text = "";
            this.txtname.text = "";
            dqtxt.text = "";
            qldtxt.text = "";
         }
      }
   }
}
