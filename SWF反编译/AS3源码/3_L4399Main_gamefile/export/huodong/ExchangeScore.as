package export.huodong
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.bigzp.DollExchange;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import user.User;
   
   public class ExchangeScore extends Sprite
   {
       
      
      private var gc:Config;
      
      private var urlRequest:URLRequest;
      
      private var urlLoader:URLLoader;
      
      private var _anti:Antiwear;
      
      private var sellbsList:Array;
      
      private var sellcwList:Array;
      
      private var sellszList:Array;
      
      private var selldjList:Array;
      
      private var selectTag:uint = 1;
      
      private var pageNum:uint = 1;
      
      private var curPage:uint = 1;
      
      public var st0:ESShopThing;
      
      public var st1:ESShopThing;
      
      public var st2:ESShopThing;
      
      public var st3:ESShopThing;
      
      public var st4:ESShopThing;
      
      public var st5:ESShopThing;
      
      public var st6:ESShopThing;
      
      public var st7:ESShopThing;
      
      public var st8:ESShopThing;
      
      public var btn_back:SimpleButton;
      
      public var btn_buyall:SimpleButton;
      
      public var btn_buybs:SimpleButton;
      
      public var btn_buysz:SimpleButton;
      
      public var btn_buycw:SimpleButton;
      
      public var btn_buydj:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var lastBtn2:String = "";
      
      private var btnState2;
      
      public var btn_upPage:SimpleButton;
      
      public var btn_nextPage:SimpleButton;
      
      public var txt_page:TextField;
      
      public var txt_money:TextField;
      
      public var hdbtn:SimpleButton;
      
      public var p1btn:SimpleButton;
      
      public var p2btn:SimpleButton;
      
      private var dollInfoMc:MovieClip;
      
      private var player:User;
      
      public function ExchangeScore()
      {
         _anti = new Antiwear(new binaryEncrypt());
         sellbsList = [];
         sellcwList = [];
         sellszList = [];
         selldjList = [];
         super();
         gc = Config.getInstance();
         this._anti.one_thousand = 1000;
         this._anti.one_hundred = 100;
         this._anti.three_hundred_fifty = 350;
         this._anti.one_thousand_two_hun = 1200;
         this._anti.six_hundred = 600;
         this._anti.two_thousand_two = 2200;
         this._anti.three_thousand = 3000;
         this._anti.three_thousand_five = 3500;
         this._anti.ten_thousand_one = 11000;
         this._anti.yiwanliangqianlingyi = 12001;
         this._anti.five_thousand = 5000;
         this._anti.two_thousand = 2000;
         this._anti.four_thousand = 4000;
         this._anti.fifty = 50;
         this._anti.night_hundred = 900;
         this._anti.one_thousand_five = 1500;
         this._anti.five_hundred = 500;
         this._anti.eight_hundred = 800;
         this._anti.one_thousand_e_e_e = 1888;
         this._anti.score_wpqhs1_1 = "score_wpqhs1_1";
         this._anti.score_wpqhs1_4 = "score_wpqhs1_4";
         this._anti.score_gjs2_4 = "score_gjs2_4";
         this._anti.score_mfs3_3 = "score_mfs3_3";
         this._anti.score_wpqhs3_2 = "score_wpqhs3_2";
         this._anti.score_gjs3_3 = "score_gjs3_3";
         this._anti.score_wpqhs3_4 = "score_wpqhs3_4";
         this._anti.score_wpllz_4 = "score_wpllz_4";
         this._anti.score_wpflz_4 = "score_wpflz_4";
         this._anti.score_wpqhs4_8 = "score_wpqhs4_8";
         this._anti.score_cw_huwan = "score_cw_huwan";
         this._anti.score_cw_guibu = "score_cw_guibu";
         this._anti.score_cw_quedan = "score_cw_quedan";
         this._anti.score_cw_huowan = "score_cw_huowan";
         this._anti.score_cw_xueqiu = "score_cw_xueqiu";
         this._anti.score_ptzlwsz_1 = "score_ptzlwsz_1";
         this._anti.score_exp_2500 = "score_exp_2500";
         this._anti.score_mpyj_1 = "score_mpyj_1";
         this._anti.score_llyzzs_1 = "score_llyzzs_1";
         this._anti.score_rls_1 = "score_rls_1";
         this._anti.score_wpsmd1_3 = "score_wpsmd1_3";
         this._anti.score_wpsmd2_3 = "score_wpsmd2_3";
         this._anti.score_wpsmd3_3 = "score_wpsmd3_3";
         this._anti.score_wptm_500 = "score_wptm_500";
         this._anti.score_wpxt_500 = "score_wpxt_500";
         this._anti.score_wpsc_500 = "score_wpsc_500";
         this._anti.score_wplvdyl_50 = "score_wplvdyl_50";
         this._anti.score_yjp_1 = "score_yjp_1";
         this._anti.score_qljfb_1 = "score_qljfb_1";
         this._anti.score_nmwdnh_1 = "score_nmwdnh_1";
         this._anti.score_zlwdah_1 = "score_zlwdah_1";
         this._anti.score_ptsmsrsz_1 = "score_ptsmsrsz_1";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         sellbsList = [{"cname":"熔炼石"},{"cname":"1级强化石"},{"cname":"1级强化石"},{"cname":"2级攻击石"},{"cname":"3级魔法石"},{"cname":"3级攻击石"},{"cname":"雷灵珠"},{"cname":"风灵珠"},{"cname":"4级强化石"}];
         this._anti.sellbsScoreList = [this._anti.one_thousand,this._anti.one_hundred,this._anti.three_hundred_fifty,this._anti.one_thousand,this._anti.one_thousand_two_hun,this._anti.two_thousand_two,this._anti.three_thousand,this._anti.three_thousand_five,this._anti.ten_thousand_one];
         this._anti.sellbsImgList = [this._anti.score_rls_1,this._anti.score_wpqhs1_1,this._anti.score_wpqhs1_4,this._anti.score_gjs2_4,this._anti.score_mfs3_3,this._anti.score_gjs3_3,this._anti.score_wpllz_4,this._anti.score_wpflz_4,this._anti.score_wpqhs4_8];
         sellcwList = [{"cname":"虎丸"},{"cname":"龟布"},{"cname":"雀蛋"},{"cname":"火丸"},{"cname":"雪球"}];
         this._anti.sellcwScoreList = [5000,5000,5000,5000,5000];
         this._anti.sellcwImgList = [this._anti.score_cw_huwan,this._anti.score_cw_guibu,this._anti.score_cw_quedan,this._anti.score_cw_huowan,this._anti.score_cw_xueqiu];
         sellszList = [{"cname":"转轮王装"},{"cname":"玉净瓶"},{"cname":"青龙剑"},{"cname":"牛魔王的怒吼"},{"cname":"转轮王的哀嚎"},{"cname":"神秘商人装"}];
         this._anti.sellszScoreList = [this._anti.two_thousand,this._anti.eight_hundred,this._anti.one_thousand_e_e_e,this._anti.one_thousand_two_hun,this._anti.one_thousand_two_hun,this._anti.one_thousand_five];
         this._anti.sellszImgList = [this._anti.score_ptzlwsz_1,this._anti.score_yjp_1,this._anti.score_qljfb_1,this._anti.score_nmwdnh_1,this._anti.score_zlwdah_1,this._anti.score_ptsmsrsz_1];
         selldjList = [{"cname":"小经验药水"},{"cname":"孟婆药剂"},{"cname":"玲珑玉制作书"},{"cname":"1品生命丹"},{"cname":"2品生命丹"},{"cname":"3品生命丹"},{"cname":"檀木"},{"cname":"玄铁"},{"cname":"丝绸"},{"cname":"龙女的眼泪"}];
         this._anti.selldjScoreList = [this._anti.fifty,this._anti.one_thousand,this._anti.four_thousand,this._anti.night_hundred,this._anti.one_thousand_five,this._anti.two_thousand,this._anti.five_hundred,this._anti.five_hundred,this._anti.five_hundred,this._anti.one_thousand_five];
         this._anti.selldjImgList = [this._anti.score_exp_2500,this._anti.score_mpyj_1,this._anti.score_llyzzs_1,this._anti.score_wpsmd1_3,this._anti.score_wpsmd2_3,this._anti.score_wpsmd3_3,this._anti.score_wptm_500,this._anti.score_wpxt_500,this._anti.score_wpsc_500,this._anti.score_wplvdyl_50];
      }
      
      private function added(e:Event) : void
      {
         var urlRequest:* = null;
         btn_back.addEventListener("click",backClick);
         btn_buycw.addEventListener("click",buycwClick);
         btn_buyall.addEventListener("click",buyallClick);
         btn_buysz.addEventListener("click",buyszClick);
         btn_buybs.addEventListener("click",buybsClick);
         btn_buydj.addEventListener("click",buydjClick);
         if(gc.playNum == 1)
         {
            p1btn.addEventListener("click",play1Click);
            p2btn.visible = false;
         }
         else
         {
            p2btn.visible = true;
            p1btn.addEventListener("click",play1Click);
            p2btn.addEventListener("click",play2Click);
         }
         p1btn.dispatchEvent(new MouseEvent("click"));
         btn_upPage.addEventListener("click",upPageClick);
         btn_nextPage.addEventListener("click",nextPageClick);
         gc.eventManger.addEventListener("ExchangeShopSuccess",exchangeSuccess);
         gc.eventManger.addEventListener("showDoll",__showDoll);
         hdbtn.addEventListener("click",hdClick);
         if(!gc.hasGetTabelScore)
         {
            gc.addActionMask("renewalse");
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "text";
            urlLoader.addEventListener("complete",completeHandler);
            urlLoader.addEventListener("ioError",errorHandler);
            urlLoader.addEventListener("securityError",errorHandler);
            urlRequest = new URLRequest("https://huodong2.4399.com/zaomengxiyou3/zhuanpan/duihuang.php?" + RandomControllor.getIns().getRandom());
            urlRequest.method = "POST";
            urlLoader.load(urlRequest);
            gc.hasGetTabelScore = true;
         }
         else
         {
            this.setTxt();
            btn_buyall.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function removed(e:Event) : void
      {
         btn_back.removeEventListener("click",backClick);
         btn_buycw.removeEventListener("click",buycwClick);
         btn_buyall.removeEventListener("click",buyallClick);
         btn_buysz.removeEventListener("click",buyszClick);
         btn_buybs.removeEventListener("click",buybsClick);
         btn_upPage.removeEventListener("click",upPageClick);
         btn_nextPage.removeEventListener("click",nextPageClick);
         hdbtn.removeEventListener("click",hdClick);
         p1btn.removeEventListener("click",play1Click);
         p2btn.removeEventListener("click",play2Click);
         gc.eventManger.removeEventListener("ExchangeShopSuccess",exchangeSuccess);
         gc.eventManger.removeEventListener("showDoll",__showDoll);
         btnState = null;
         this._anti = null;
      }
      
      private function setPlayer() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 9; )
         {
            this["st" + i].setPlayer(this.player);
            i++;
         }
      }
      
      private function play1Click(e:MouseEvent) : void
      {
         this.player = gc.player1;
         this.setPlayer();
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "p1btn";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function play2Click(e:MouseEvent) : void
      {
         this.player = gc.player2;
         this.setPlayer();
         if(btnState2)
         {
            if(lastBtn2 != "")
            {
               this[lastBtn2].upState = btnState2;
            }
         }
         lastBtn2 = "p2btn";
         btnState2 = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function exchangeSuccess(e:CommonEvent) : void
      {
         this.setTxt();
      }
      
      private function completeHandler(e:Event) : void
      {
         trace("completeHandler");
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandler);
         urlLoader.removeEventListener("securityError",errorHandler);
         gc.dataObject.turntableScore = urlLoader.data;
         this.setTxt();
         btn_buyall.dispatchEvent(new MouseEvent("click"));
      }
      
      private function errorHandler(e:*) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandler);
         urlLoader.removeEventListener("securityError",errorHandler);
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
      
      private function hdClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/space-376686047-do-thread-id-30814198-tagid-80615.html");
      }
      
      private function newjfClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/space-376686047-do-thread-id-30814198-tagid-80615.html");
      }
      
      private function setTxt() : void
      {
         this.txt_page.text = this.curPage + "/" + this.pageNum;
         this.txt_money.text = gc.dataObject.turntableScore + " ";
      }
      
      private function __showDoll(evt:Event) : void
      {
         if(!this.dollInfoMc)
         {
            this.dollInfoMc = new DollExchange();
         }
         if(!this.contains(this.dollInfoMc))
         {
            this.addChild(this.dollInfoMc);
         }
      }
      
      private function backClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
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
      
      private function setShopThingEquipment() : void
      {
         var i:* = 0;
         var sellList:Array = [];
         var sellScoreList:Array = [];
         var sellImgList:Array = [];
         switch(int(this.selectTag) - 1)
         {
            case 0:
               if(sellbsList.length > 0)
               {
                  sellList = sellList.concat(sellbsList);
                  sellScoreList = sellScoreList.concat(this._anti.sellbsScoreList);
                  sellImgList = sellImgList.concat(this._anti.sellbsImgList);
               }
               if(selldjList.length > 0)
               {
                  sellList = sellList.concat(selldjList);
                  sellScoreList = sellScoreList.concat(this._anti.selldjScoreList);
                  sellImgList = sellImgList.concat(this._anti.selldjImgList);
               }
               if(sellcwList.length > 0)
               {
                  sellList = sellList.concat(sellcwList);
                  sellScoreList = sellScoreList.concat(this._anti.sellcwScoreList);
                  sellImgList = sellImgList.concat(this._anti.sellcwImgList);
               }
               if(sellszList.length > 0)
               {
                  sellList = sellList.concat(sellszList);
                  sellScoreList = sellScoreList.concat(this._anti.sellszScoreList);
                  sellImgList = sellImgList.concat(this._anti.sellszImgList);
               }
               break;
            case 1:
               sellList = sellbsList;
               sellScoreList = this._anti.sellbsScoreList;
               sellImgList = this._anti.sellbsImgList;
               break;
            case 2:
               sellList = sellcwList;
               sellScoreList = this._anti.sellcwScoreList;
               sellImgList = this._anti.sellcwImgList;
               break;
            case 3:
               sellList = sellszList;
               sellScoreList = this._anti.sellszScoreList;
               sellImgList = this._anti.sellszImgList;
               break;
            case 4:
               sellList = selldjList;
               sellScoreList = this._anti.selldjScoreList;
               sellImgList = this._anti.selldjImgList;
         }
         for(i = uint(0); i < 9; )
         {
            this["st" + i].visible = false;
            this["st" + i].clearEquipment();
            if(sellList[i + (curPage - 1) * 9])
            {
               this["st" + i].visible = true;
               this["st" + i].setEquipment(sellList[i + (curPage - 1) * 9]);
               this["st" + i].setScore(sellScoreList[i + (curPage - 1) * 9]);
               this["st" + i].setImg(sellImgList[i + (curPage - 1) * 9]);
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
   }
}
