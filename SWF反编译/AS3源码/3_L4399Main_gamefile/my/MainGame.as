package my
{
   import base.BaseBullet;
   import base.BaseGameSence;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import export.FloorBg;
   import export.immortality.SingleImmortality;
   import export.monster.Monster1;
   import export.monster.Monster10;
   import export.monster.Monster101;
   import export.monster.Monster102;
   import export.monster.Monster103;
   import export.monster.Monster104;
   import export.monster.Monster105;
   import export.monster.Monster106;
   import export.monster.Monster107;
   import export.monster.Monster108;
   import export.monster.Monster109;
   import export.monster.Monster11;
   import export.monster.Monster110;
   import export.monster.Monster111;
   import export.monster.Monster112;
   import export.monster.Monster113;
   import export.monster.Monster114;
   import export.monster.Monster115;
   import export.monster.Monster116;
   import export.monster.Monster117;
   import export.monster.Monster118;
   import export.monster.Monster119;
   import export.monster.Monster12;
   import export.monster.Monster120;
   import export.monster.Monster125;
   import export.monster.Monster126;
   import export.monster.Monster127;
   import export.monster.Monster128;
   import export.monster.Monster129;
   import export.monster.Monster13;
   import export.monster.Monster130;
   import export.monster.Monster131;
   import export.monster.Monster132;
   import export.monster.Monster133;
   import export.monster.Monster134;
   import export.monster.Monster135;
   import export.monster.Monster136;
   import export.monster.Monster137;
   import export.monster.Monster138;
   import export.monster.Monster139;
   import export.monster.Monster14;
   import export.monster.Monster140;
   import export.monster.Monster141;
   import export.monster.Monster142;
   import export.monster.Monster143;
   import export.monster.Monster144;
   import export.monster.Monster145;
   import export.monster.Monster146;
   import export.monster.Monster147;
   import export.monster.Monster148;
   import export.monster.Monster149;
   import export.monster.Monster15;
   import export.monster.Monster150;
   import export.monster.Monster151;
   import export.monster.Monster152;
   import export.monster.Monster153;
   import export.monster.Monster154;
   import export.monster.Monster155;
   import export.monster.Monster1551;
   import export.monster.Monster156;
   import export.monster.Monster157;
   import export.monster.Monster158;
   import export.monster.Monster159;
   import export.monster.Monster16;
   import export.monster.Monster160;
   import export.monster.Monster161;
   import export.monster.Monster162;
   import export.monster.Monster163;
   import export.monster.Monster164;
   import export.monster.Monster165;
   import export.monster.Monster166;
   import export.monster.Monster167;
   import export.monster.Monster168;
   import export.monster.Monster169;
   import export.monster.Monster17;
   import export.monster.Monster170;
   import export.monster.Monster171;
   import export.monster.Monster172;
   import export.monster.Monster173;
   import export.monster.Monster174;
   import export.monster.Monster175;
   import export.monster.Monster177;
   import export.monster.Monster178;
   import export.monster.Monster179;
   import export.monster.Monster18;
   import export.monster.Monster180;
   import export.monster.Monster181;
   import export.monster.Monster182;
   import export.monster.Monster183;
   import export.monster.Monster184;
   import export.monster.Monster185;
   import export.monster.Monster186;
   import export.monster.Monster187;
   import export.monster.Monster188;
   import export.monster.Monster189;
   import export.monster.Monster19;
   import export.monster.Monster190;
   import export.monster.Monster191;
   import export.monster.Monster192;
   import export.monster.Monster193;
   import export.monster.Monster194;
   import export.monster.Monster195;
   import export.monster.Monster196;
   import export.monster.Monster197;
   import export.monster.Monster198;
   import export.monster.Monster199;
   import export.monster.Monster2;
   import export.monster.Monster20;
   import export.monster.Monster200;
   import export.monster.Monster2000;
   import export.monster.Monster2001;
   import export.monster.Monster2002;
   import export.monster.Monster2003;
   import export.monster.Monster2004;
   import export.monster.Monster201;
   import export.monster.Monster202;
   import export.monster.Monster203;
   import export.monster.Monster204;
   import export.monster.Monster205;
   import export.monster.Monster206;
   import export.monster.Monster207;
   import export.monster.Monster208;
   import export.monster.Monster209;
   import export.monster.Monster21;
   import export.monster.Monster210;
   import export.monster.Monster211;
   import export.monster.Monster212;
   import export.monster.Monster213;
   import export.monster.Monster214;
   import export.monster.Monster215;
   import export.monster.Monster216;
   import export.monster.Monster217;
   import export.monster.Monster218;
   import export.monster.Monster219;
   import export.monster.Monster22;
   import export.monster.Monster220;
   import export.monster.Monster221;
   import export.monster.Monster222;
   import export.monster.Monster223;
   import export.monster.Monster224;
   import export.monster.Monster225;
   import export.monster.Monster226;
   import export.monster.Monster227;
   import export.monster.Monster228;
   import export.monster.Monster229;
   import export.monster.Monster23;
   import export.monster.Monster230;
   import export.monster.Monster231;
   import export.monster.Monster232;
   import export.monster.Monster24;
   import export.monster.Monster25;
   import export.monster.Monster26;
   import export.monster.Monster27;
   import export.monster.Monster28;
   import export.monster.Monster29;
   import export.monster.Monster3;
   import export.monster.Monster30;
   import export.monster.Monster31;
   import export.monster.Monster32;
   import export.monster.Monster33;
   import export.monster.Monster34;
   import export.monster.Monster35;
   import export.monster.Monster36;
   import export.monster.Monster37;
   import export.monster.Monster38;
   import export.monster.Monster39;
   import export.monster.Monster4;
   import export.monster.Monster40;
   import export.monster.Monster41;
   import export.monster.Monster42;
   import export.monster.Monster43;
   import export.monster.Monster44;
   import export.monster.Monster45;
   import export.monster.Monster46;
   import export.monster.Monster47;
   import export.monster.Monster48;
   import export.monster.Monster49;
   import export.monster.Monster5;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import export.monster.Monster52;
   import export.monster.Monster53;
   import export.monster.Monster54;
   import export.monster.Monster55;
   import export.monster.Monster56;
   import export.monster.Monster57;
   import export.monster.Monster58;
   import export.monster.Monster59;
   import export.monster.Monster6;
   import export.monster.Monster60;
   import export.monster.Monster61;
   import export.monster.Monster62;
   import export.monster.Monster63;
   import export.monster.Monster64;
   import export.monster.Monster65;
   import export.monster.Monster66;
   import export.monster.Monster67;
   import export.monster.Monster68;
   import export.monster.Monster69;
   import export.monster.Monster7;
   import export.monster.Monster70;
   import export.monster.Monster71;
   import export.monster.Monster72;
   import export.monster.Monster73;
   import export.monster.Monster74;
   import export.monster.Monster75;
   import export.monster.Monster8;
   import export.monster.Monster80;
   import export.monster.Monster81;
   import export.monster.Monster82;
   import export.monster.Monster9;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.MusicManager;
   import user.User;
   
   public class MainGame
   {
      
      private static var _this:MainGame;
       
      
      private var gc:Config;
      
      private var mm:MusicManager;
      
      private var root:Sprite;
      
      private var m1:Monster1;
      
      private var m2:Monster2;
      
      private var m3:Monster3;
      
      private var m4:Monster4;
      
      private var m5:Monster5;
      
      private var m6:Monster6;
      
      private var m7:Monster7;
      
      private var m8:Monster8;
      
      private var m9:Monster9;
      
      private var m10:Monster10;
      
      private var m11:Monster11;
      
      private var m12:Monster12;
      
      private var m13:Monster13;
      
      private var m14:Monster14;
      
      private var m15:Monster15;
      
      private var m16:Monster16;
      
      private var m17:Monster17;
      
      private var m171:Monster171;
      
      private var m18:Monster18;
      
      private var m181:Monster181;
      
      private var m19:Monster19;
      
      private var m20:Monster20;
      
      private var m21:Monster21;
      
      private var m22:Monster22;
      
      private var m23:Monster23;
      
      private var m24:Monster24;
      
      private var m25:Monster25;
      
      private var m26:Monster26;
      
      private var m27:Monster27;
      
      private var m28:Monster28;
      
      private var m29:Monster29;
      
      private var m30:Monster30;
      
      private var m31:Monster31;
      
      private var m32:Monster32;
      
      private var m33:Monster33;
      
      private var m34:Monster34;
      
      private var m35:Monster35;
      
      private var m36:Monster36;
      
      private var m37:Monster37;
      
      private var m38:Monster38;
      
      private var m70:Monster70;
      
      private var m71:Monster71;
      
      private var m72:Monster72;
      
      private var m73:Monster73;
      
      private var m74:Monster74;
      
      private var m75:Monster75;
      
      private var m39:Monster39;
      
      private var m40:Monster40;
      
      private var m41:Monster41;
      
      private var m42:Monster42;
      
      private var m43:Monster43;
      
      private var m44:Monster44;
      
      private var m45:Monster45;
      
      private var m46:Monster46;
      
      private var m47:Monster47;
      
      private var m48:Monster48;
      
      private var m49:Monster49;
      
      private var m50:Monster50;
      
      private var m51:Monster51;
      
      private var m52:Monster52;
      
      private var m53:Monster53;
      
      private var m54:Monster54;
      
      private var m55:Monster55;
      
      private var m56:Monster56;
      
      private var m57:Monster57;
      
      private var m58:Monster58;
      
      private var m59:Monster59;
      
      private var m60:Monster60;
      
      private var m61:Monster61;
      
      private var m62:Monster62;
      
      private var m63:Monster63;
      
      private var m64:Monster64;
      
      private var m65:Monster65;
      
      private var m66:Monster66;
      
      private var m67:Monster67;
      
      private var m68:Monster68;
      
      private var m69:Monster69;
      
      private var m80:Monster80;
      
      private var m81:Monster81;
      
      private var m82:Monster82;
      
      private var m101:Monster101;
      
      private var m102:Monster102;
      
      private var m103:Monster103;
      
      private var m104:Monster104;
      
      private var m105:Monster105;
      
      private var m106:Monster106;
      
      private var m107:Monster107;
      
      private var m108:Monster108;
      
      private var m109:Monster109;
      
      private var m110:Monster110;
      
      private var m111:Monster111;
      
      private var m112:Monster112;
      
      private var m113:Monster113;
      
      private var m114:Monster114;
      
      private var m115:Monster115;
      
      private var m116:Monster116;
      
      private var m117:Monster117;
      
      private var m118:Monster118;
      
      private var m119:Monster119;
      
      private var m120:Monster120;
      
      private var m125:Monster125;
      
      private var m126:Monster126;
      
      private var m127:Monster127;
      
      private var m128:Monster128;
      
      private var m129:Monster129;
      
      private var m130:Monster130;
      
      private var m131:Monster131;
      
      private var m132:Monster132;
      
      private var m133:Monster133;
      
      private var m134:Monster134;
      
      private var m135:Monster135;
      
      private var m136:Monster136;
      
      private var m137:Monster137;
      
      private var m138:Monster138;
      
      private var m139:Monster139;
      
      private var m140:Monster140;
      
      private var m141:Monster141;
      
      private var m142:Monster142;
      
      private var m143:Monster143;
      
      private var m144:Monster144;
      
      private var m145:Monster145;
      
      private var m146:Monster146;
      
      private var m147:Monster147;
      
      private var m148:Monster148;
      
      private var m149:Monster149;
      
      private var m150:Monster150;
      
      private var m151:Monster151;
      
      private var m152:Monster152;
      
      private var m153:Monster153;
      
      private var m154:Monster154;
      
      private var m155:Monster155;
      
      private var m1551:Monster1551;
      
      private var m156:Monster156;
      
      private var m157:Monster157;
      
      private var m158:Monster158;
      
      private var m159:Monster159;
      
      private var m160:Monster160;
      
      private var m161:Monster161;
      
      private var m162:Monster162;
      
      private var m163:Monster163;
      
      private var m164:Monster164;
      
      private var m165:Monster165;
      
      private var m166:Monster166;
      
      private var m167:Monster167;
      
      private var m168:Monster168;
      
      private var m169:Monster169;
      
      private var m170:Monster170;
      
      private var m172:Monster172;
      
      private var m173:Monster173;
      
      private var m174:Monster174;
      
      private var m175:Monster175;
      
      private var m177:Monster177;
      
      private var m178:Monster178;
      
      private var m179:Monster179;
      
      private var m180:Monster180;
      
      private var m182:Monster182;
      
      private var m183:Monster183;
      
      private var m184:Monster184;
      
      private var m185:Monster185;
      
      private var m186:Monster186;
      
      private var m187:Monster187;
      
      private var m188:Monster188;
      
      private var m189:Monster189;
      
      private var m190:Monster190;
      
      private var m191:Monster191;
      
      private var m192:Monster192;
      
      private var m193:Monster193;
      
      private var m194:Monster194;
      
      private var m195:Monster195;
      
      private var m196:Monster196;
      
      private var m197:Monster197;
      
      private var m198:Monster198;
      
      private var m199:Monster199;
      
      private var m200:Monster200;
      
      private var m201:Monster201;
      
      private var m202:Monster202;
      
      private var m203:Monster203;
      
      private var m204:Monster204;
      
      private var m205:Monster205;
      
      private var m206:Monster206;
      
      private var m207:Monster207;
      
      private var m208:Monster208;
      
      private var m209:Monster209;
      
      private var m210:Monster210;
      
      private var m211:Monster211;
      
      private var m212:Monster212;
      
      private var m213:Monster213;
      
      private var m214:Monster214;
      
      private var m215:Monster215;
      
      private var m216:Monster216;
      
      private var m217:Monster217;
      
      private var m218:Monster218;
      
      private var m219:Monster219;
      
      private var m220:Monster220;
      
      private var m221:Monster221;
      
      private var m222:Monster222;
      
      private var m223:Monster223;
      
      private var m224:Monster224;
      
      private var m225:Monster225;
      
      private var m226:Monster226;
      
      private var m227:Monster227;
      
      private var m228:Monster228;
      
      private var m229:Monster229;
      
      private var m230:Monster230;
      
      private var m231:Monster231;
      
      private var m232:Monster232;
      
      private var m2000:Monster2000;
      
      private var m2001:Monster2001;
      
      private var m2002:Monster2002;
      
      private var m2003:Monster2003;
      
      private var m2004:Monster2004;
      
      private var aaaa:SingleImmortality;
      
      private var curFrame:int = 0;
      
      public function MainGame(root:Sprite)
      {
         super();
         gc = Config.getInstance();
         mm = MusicManager.getInstance();
         this.root = root;
         if(!_this)
         {
            _this = this;
         }
      }
      
      public static function getInstance() : MainGame
      {
         return _this;
      }
      
      public function GameStart() : void
      {
         var name:String = gc.curStageAndCurLevel.curStage + "";
         GMain.getInstance().loader.loadByName(name,newGame);
      }
      
      public function fbEnter(params:uint = 0) : void
      {
         this.destroyGame();
         if(gc.curStageAndCurLevel.curStage == 2 && gc.curStageAndCurLevel.curLevel == 3)
         {
            if(params == 0)
            {
               gc.curStageAndCurLevel.curStage = 6;
               gc.curStageAndCurLevel.curLevel = 1;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 1 && gc.curStageAndCurLevel.curLevel == 2)
         {
            if(params == 0)
            {
               gc.curStageAndCurLevel.curStage = 5;
               gc.curStageAndCurLevel.curLevel = 1;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 3 && gc.curStageAndCurLevel.curLevel == 1)
         {
            if(params == 0)
            {
               gc.curStageAndCurLevel.curStage = 7;
               gc.curStageAndCurLevel.curLevel = 1;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 9 && gc.curStageAndCurLevel.curLevel == 1)
         {
            if(params == 0)
            {
               gc.curStageAndCurLevel.curStage = 10;
               gc.curStageAndCurLevel.curLevel = 1;
            }
            else if(params == 1)
            {
               gc.curStageAndCurLevel.curStage = 14;
               gc.curStageAndCurLevel.curLevel = 1;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 20 && gc.curStageAndCurLevel.curLevel == 1)
         {
            gc.curStageAndCurLevel.curStage = 43;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(gc.curStageAndCurLevel.curStage == 21 && gc.curStageAndCurLevel.curLevel == 3)
         {
            gc.curStageAndCurLevel.curStage = 45;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(gc.curStageAndCurLevel.curStage == 23 && gc.curStageAndCurLevel.curLevel == 1)
         {
            gc.curStageAndCurLevel.curStage = 23;
            gc.curStageAndCurLevel.curLevel = 3;
         }
         else if(gc.curStageAndCurLevel.curStage == 25 && gc.curStageAndCurLevel.curLevel == 3)
         {
            if(params == 0)
            {
               gc.curStageAndCurLevel.curStage = 25;
               gc.curStageAndCurLevel.curLevel = 3;
            }
            else if(params == 1)
            {
               gc.curStageAndCurLevel.curStage = 25;
               gc.curStageAndCurLevel.curLevel = 4;
            }
         }
         gc.eventManger.dispatchEvent(new Event("ReStart"));
      }
      
      public function levelClear() : void
      {
         mm.play("begin");
         if(gc.isInHost())
         {
            gc.closeScoket();
            GMain.getInstance().switchSence("showStageMap");
         }
         else
         {
            if(gc.curStageAndCurLevel.curStage == 41 && gc.curStageAndCurLevel.curLevel == 1)
            {
               this.destroyGame();
               GMain.getInstance().switchSence("showStageMap");
               return;
            }
            if(gc.curStageAndCurLevel.curStage == gc.curBigStage)
            {
               if(gc.curBigStage <= 3)
               {
                  if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                  {
                     if(gc.curStageAndCurLevel.curLevel == 3)
                     {
                        gc.curBigStage++;
                        gc.curBigLevel = 1;
                     }
                     else if(gc.curStageAndCurLevel.curLevel < 3)
                     {
                        gc.curBigLevel++;
                     }
                  }
               }
               else if(gc.curBigStage == 4)
               {
                  gc.curBigLevel = 1;
               }
               else if(gc.curBigStage >= 20 && gc.curBigStage < 40)
               {
                  if(gc.curBigStage == 20)
                  {
                     if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                     {
                        gc.curBigStage++;
                        gc.curBigLevel = 1;
                     }
                  }
                  else if(gc.curBigStage == 21)
                  {
                     if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                     {
                        if(gc.curBigLevel < 3)
                        {
                           gc.curBigLevel++;
                        }
                        else
                        {
                           gc.curBigStage = 22;
                           gc.curBigLevel = 1;
                        }
                     }
                  }
                  else if(gc.curBigStage == 22)
                  {
                     if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                     {
                        if(gc.curBigLevel < 3)
                        {
                           gc.curBigLevel++;
                        }
                        else
                        {
                           gc.curBigStage = 23;
                           gc.curBigLevel = 1;
                        }
                     }
                  }
                  else if(gc.curBigStage == 23)
                  {
                     if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                     {
                        if(gc.curBigLevel < 3)
                        {
                           gc.curBigLevel++;
                        }
                     }
                  }
                  else if(gc.curBigStage == 24)
                  {
                     if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                     {
                        if(gc.curBigLevel < 3)
                        {
                           gc.curBigLevel++;
                        }
                        else
                        {
                           gc.curBigStage = 25;
                           gc.curBigLevel = 1;
                        }
                     }
                  }
                  else if(gc.curBigStage == 25)
                  {
                     if(gc.curStageAndCurLevel.curLevel == gc.curBigLevel)
                     {
                        if(gc.curBigLevel < 3)
                        {
                           gc.curBigLevel++;
                        }
                        else
                        {
                           gc.curBigStage = 26;
                           gc.curBigLevel = 1;
                        }
                     }
                  }
                  else if(gc.curBigStage == 26)
                  {
                  }
               }
            }
            mm.play("Game_Victory");
         }
         this.destroyGameAndSaveGame();
         if(gc.curStageAndCurLevel.curStage == 57 && gc.curStageAndCurLevel.curLevel == 1)
         {
            for each(var player in gc.getUsersArray())
            {
               if(player.getSomeOneEquipNumberByName("xnhdl") > 0)
               {
                  player.removeEquipFormBack("xnhdl",2,1);
                  gc.curStageAndCurLevel.curStage = 57;
                  gc.curStageAndCurLevel.curLevel = 2;
                  gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
                  break;
               }
            }
         }
         else
         {
            gc.playerGuide.checkNewGuide();
         }
      }
      
      public function destroyGameAndSaveGame() : void
      {
         this.destroyGame();
         this.doSaveGame();
      }
      
      public function doSaveGame() : void
      {
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      public function createMonster(kind:int, xx:Number, yy:Number, currentCount:int = -1, entityId:uint = 0) : BaseMonster
      {
         trace("创建怪物：" + kind);
         var mon1:BaseMonster = AUtils.getNewObj("export.monster.Monster" + kind);
         mon1.x = xx;
         mon1.y = yy;
         mon1.sid = getTimer();
         gc.pWorld.monsterArray.push(mon1);
         var minIdx:int = gc.getMinIdxInHeroAndPet();
         if(minIdx == 0)
         {
            gc.gameSence.addChild(mon1);
         }
         else
         {
            gc.gameSence.addChildAt(mon1,minIdx);
         }
         mon1.entityId = entityId;
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               gc.sendMonsterCreate(entityId,kind,xx,yy);
            }
         }
         return mon1;
      }
      
      public function createLikeMonster(kind:int, xx:Number, yy:Number, currentCount:int = -1) : BaseMonster
      {
         var idx1:int = 0;
         var idx2:int = 0;
         var mon1:BaseMonster = AUtils.getNewObj("export.monster.Monster" + kind);
         mon1.x = xx;
         mon1.y = yy;
         mon1.sid = getTimer();
         gc.pWorld.likeMonsterArray.push(mon1);
         if(gc.hero1 && gc.gameSence.contains(gc.hero1))
         {
            idx1 = gc.gameSence.getChildIndex(gc.hero1);
         }
         else
         {
            idx1 = 99999;
         }
         if(gc.hero2 && gc.gameSence.contains(gc.hero2))
         {
            idx2 = gc.gameSence.getChildIndex(gc.hero2);
         }
         else
         {
            idx2 = 99999;
         }
         var min:int = Math.min(idx1,idx2);
         if(min != 99999)
         {
            gc.gameSence.addChildAt(mon1,min);
         }
         else
         {
            gc.gameSence.addChild(mon1);
         }
         return mon1;
      }
      
      public function stopGame(time:int = 0, isStopKeyBoard:Boolean = true) : void
      {
         time = time;
         isStopKeyBoard = isStopKeyBoard;
         this.stopMcRender();
         if(isStopKeyBoard)
         {
            if(gc.keyboardControl)
            {
               gc.keyboardControl.stopKeyboardControl();
            }
         }
         if(time != 0)
         {
            setTimeout(function():*
            {
               continueGame();
            },time);
         }
         TweenMax.pauseAll(true,true);
         gc.isStopGame = true;
      }
      
      private function stopMcRender() : void
      {
         var i:int = 0;
         var b:* = null;
         var m:int = 0;
         var mba1:* = null;
         m = 0;
         var petBb:* = null;
         var j:int = 0;
         var bm:* = null;
         var n:int = 0;
         var mba2:* = null;
         var k:int = 0;
         var lbm:* = null;
         var l:int = 0;
         var mba3:* = null;
         for(i = 0; i < gc.getPlayerArray().length; )
         {
            b = gc.getPlayerArray()[i] as BaseHero;
            for(m = 0; m < b.magicBulletArray.length; )
            {
               mba1 = b.magicBulletArray[m] as BaseBullet;
               AUtils.stopAllChildren(mba1);
               m++;
            }
            if(b.getPet())
            {
               for(m = 0; m < b.getPet().magicBulletArray.length; )
               {
                  petBb = b.getPet().magicBulletArray[m] as BaseBullet;
                  AUtils.stopAllChildren(petBb);
                  m++;
               }
            }
            i++;
         }
         for(j = 0; j < gc.pWorld.monsterArray.length; )
         {
            bm = gc.pWorld.monsterArray[j] as BaseMonster;
            for(n = 0; n < bm.magicBulletArray.length; )
            {
               mba2 = bm.magicBulletArray[n] as BaseBullet;
               AUtils.stopAllChildren(mba2);
               n++;
            }
            j++;
         }
         for(k = 0; k < gc.pWorld.likeMonsterArray.length; )
         {
            lbm = gc.pWorld.likeMonsterArray[k] as BaseMonster;
            for(l = 0; l < lbm.magicBulletArray.length; )
            {
               mba3 = lbm.magicBulletArray[l] as BaseBullet;
               AUtils.stopAllChildren(mba3);
               l++;
            }
            k++;
         }
      }
      
      private function continueMcRender() : void
      {
         var i:int = 0;
         var b:* = null;
         var m:int = 0;
         var mba1:* = null;
         m = 0;
         var petBb:* = null;
         var j:int = 0;
         var bm:* = null;
         var n:int = 0;
         var mba2:* = null;
         var k:int = 0;
         var lbm:* = null;
         var l:int = 0;
         var mba3:* = null;
         for(i = 0; i < gc.getPlayerArray().length; )
         {
            b = gc.getPlayerArray()[i] as BaseHero;
            for(m = 0; m < b.magicBulletArray.length; )
            {
               mba1 = b.magicBulletArray[m] as BaseBullet;
               AUtils.startAllChildren(mba1);
               m++;
            }
            if(b.getPet())
            {
               for(m = 0; m < b.getPet().magicBulletArray.length; )
               {
                  petBb = b.getPet().magicBulletArray[m] as BaseBullet;
                  AUtils.startAllChildren(petBb);
                  m++;
               }
            }
            i++;
         }
         for(j = 0; j < gc.pWorld.monsterArray.length; )
         {
            bm = gc.pWorld.monsterArray[j] as BaseMonster;
            AUtils.startAllChildren(bm);
            for(n = 0; n < bm.magicBulletArray.length; )
            {
               mba2 = bm.magicBulletArray[n] as BaseBullet;
               AUtils.startAllChildren(mba2);
               n++;
            }
            j++;
         }
         for(k = 0; k < gc.pWorld.likeMonsterArray.length; )
         {
            lbm = gc.pWorld.likeMonsterArray[k] as BaseMonster;
            for(l = 0; l < lbm.magicBulletArray.length; )
            {
               mba3 = lbm.magicBulletArray[l] as BaseBullet;
               AUtils.startAllChildren(mba3);
               l++;
            }
            k++;
         }
      }
      
      private function nextMcRender() : void
      {
         var i:int = 0;
         var b:* = null;
         var m:int = 0;
         var mba1:* = null;
         m = 0;
         var petBb:* = null;
         var j:int = 0;
         var bm:* = null;
         var n:int = 0;
         var mba2:* = null;
         var k:int = 0;
         var lbm:* = null;
         var l:int = 0;
         var mba3:* = null;
         for(i = 0; i < gc.getPlayerArray().length; )
         {
            b = gc.getPlayerArray()[i] as BaseHero;
            for(m = 0; m < b.magicBulletArray.length; )
            {
               mba1 = b.magicBulletArray[m] as BaseBullet;
               AUtils.nextAllChildren(mba1);
               m++;
            }
            if(b.getPet())
            {
               for(m = 0; m < b.getPet().magicBulletArray.length; )
               {
                  petBb = b.getPet().magicBulletArray[m] as BaseBullet;
                  AUtils.nextAllChildren(petBb);
                  m++;
               }
            }
            i++;
         }
         for(j = 0; j < gc.pWorld.monsterArray.length; )
         {
            bm = gc.pWorld.monsterArray[j] as BaseMonster;
            AUtils.nextAllChildren(bm);
            for(n = 0; n < bm.magicBulletArray.length; )
            {
               mba2 = bm.magicBulletArray[n] as BaseBullet;
               AUtils.nextAllChildren(mba2);
               n++;
            }
            j++;
         }
         for(k = 0; k < gc.pWorld.likeMonsterArray.length; )
         {
            lbm = gc.pWorld.likeMonsterArray[k] as BaseMonster;
            for(l = 0; l < lbm.magicBulletArray.length; )
            {
               mba3 = lbm.magicBulletArray[l] as BaseBullet;
               AUtils.nextAllChildren(mba3);
               l++;
            }
            k++;
         }
      }
      
      public function continueGame(isStopKeyBoard:Boolean = true) : void
      {
         this.continueMcRender();
         if(isStopKeyBoard)
         {
            gc.keyboardControl.continueKeyboardControl();
         }
         TweenMax.resumeAll();
         gc.isStopGame = false;
      }
      
      public function destroyGame() : void
      {
         var idx:int = 0;
         if(this.root.hasEventListener("enterFrame"))
         {
            this.root.removeEventListener("enterFrame",__enterFrame);
         }
         gc.destroyGame();
         gc.gameSence.destroy();
         gc.gameInfo.destroy();
         gc.pWorld.destroy();
         gc.bg1.destroy();
         gc.keyboardControl.destroy();
         gc.vControllor.destroy();
         var players:Array = gc.getUsersArray();
         for each(var p in players)
         {
            p.reSetAllPetState();
         }
         var heros:Array = gc.getPlayerArray();
         for each(var bh in heros)
         {
            bh.destroy();
         }
         gc.hero1 = null;
         gc.hero2 = null;
         gc.hero3 = null;
         gc.pWorld.heroArray = [];
         _this = null;
         this.root = null;
         TweenMax.killAll(false);
      }
      
      public function destroyMode() : void
      {
         this.destroyGame();
         gc.initData();
      }
      
      public function newGame() : void
      {
         GMain.getInstance().curState = "gameStarted";
         gc.pauseTime = 0;
         gc.startTime = getTimer();
         this.createFloorBg();
         gc.gameSence = AUtils.getNewObj("export.gameSence.sl" + gc.curStageAndCurLevel.curStage + gc.curStageAndCurLevel.curLevel) as BaseGameSence;
         trace("gc.gameSence：" + gc.gameSence);
         this.root.addChild(gc.gameSence);
         gc.pWorld.pWorldInit();
         if(!this.root.hasEventListener("enterFrame"))
         {
            this.root.addEventListener("enterFrame",__enterFrame);
         }
         if(gc.curStageAndCurLevel.curStage > 7)
         {
            if(gc.curStageAndCurLevel.curStage == 12)
            {
               mm.play("stage12");
            }
            else if(gc.curStageAndCurLevel.curStage == 21)
            {
               mm.play("stage21");
            }
            else if(gc.curStageAndCurLevel.curStage == 22)
            {
               mm.play("stage22");
            }
            else
            {
               mm.play("stage5");
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 7)
         {
            mm.play("stage2");
         }
         else
         {
            mm.play("stage" + gc.curStageAndCurLevel.curStage);
         }
      }
      
      private function createFloorBg() : void
      {
         gc.bg1 = new FloorBg();
         var floorBitmapData:BitmapData = AUtils.getNewObj("floorBg" + gc.curStageAndCurLevel.curStage);
         var floorBitmap:Bitmap = new Bitmap(floorBitmapData);
         floorBitmap.name = "floorBitmap";
         gc.bg1.addChild(floorBitmap);
         this.root.addChild(gc.bg1);
      }
      
      private function __enterFrame(evt:Event) : void
      {
         if(gc.isFramePk)
         {
            return;
         }
         if(!gc.isStopGame)
         {
            this.renderGame();
         }
      }
      
      public function renderGame() : void
      {
         gc.pWorld.step();
         this.updateOther();
         this.setFource();
         KeyboardInput.getIns().step();
      }
      
      public function updateOther() : void
      {
         var olen:uint = gc.otherList.length;
         while(olen-- > 0)
         {
            gc.otherList[olen].step();
         }
      }
      
      private function setFource() : void
      {
         if(this.root)
         {
            if(!gc.isSingleGame())
            {
               if(this.root.stage.focus == null)
               {
                  this.root.stage.focus = this.root.stage;
               }
            }
            else if(!this.root.stage.focus)
            {
               this.root.stage.focus = this.root.stage;
            }
         }
      }
      
      public function checkGameOver() : void
      {
         var hlen:* = 0;
         if(gc.curStageAndCurLevel.curStage != 13)
         {
            hlen = uint(gc.getPlayerArray().length);
            if(hlen == 0)
            {
               this.destroyGame();
               gc.eventManger.dispatchEvent(new CommonEvent("GameOver"));
            }
         }
      }
   }
}
