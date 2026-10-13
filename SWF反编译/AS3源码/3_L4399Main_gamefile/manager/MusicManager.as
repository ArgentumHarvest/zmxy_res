package manager
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import loader.AssetsManager;
   import loader.MusicAssetsLoaderManager;
   
   public class MusicManager
   {
      
      static var _instance:MusicManager;
      
      private static var loopChannel:SoundChannel;
      
      private static var playing:String = "";
       
      
      private var musicLoader:MusicAssetsLoaderManager;
      
      private var musicswfName:String = "Music_v700.swf";
      
      protected var dict:Dictionary;
      
      private var lastBgPlaying:String = "";
      
      public var soundStay:Boolean = true;
      
      public function MusicManager()
      {
         super();
         musicLoader = MusicAssetsLoaderManager.getInstance();
         dict = new Dictionary();
         musicLoader.loadMusicArray([musicswfName,"music_bg0.swf","music_bg1.swf","music_bg2.swf","music_bg3.swf","music_bg5.swf","music_bg6.swf","music_bg7.swf","music_bg12.swf","music_bg21.swf","music_bg22.swf"]);
      }
      
      public static function getInstance() : MusicManager
      {
         if(!_instance)
         {
            _instance = new MusicManager();
         }
         return _instance;
      }
      
      protected function cacheHandlerDictionary(soundName:String) : void
      {
         var sound:* = null;
         if(dict[soundName] != undefined && dict[soundName] != null)
         {
            dict[soundName].play();
         }
         else
         {
            sound = AUtils.getNewObj(soundName);
            sound.play();
            dict[soundName] = sound;
         }
      }
      
      protected function cacheHandlerDictionaryLoop(soundName:String, playingName:String) : void
      {
         var sound:* = null;
         trace("cacheHandlerDictionaryLoop->soundName:" + soundName + ",playingName:" + playingName);
         if(dict[soundName] != undefined && dict[soundName] != null)
         {
            this.playingLoop(dict[soundName],playingName);
         }
         else
         {
            sound = AUtils.getNewObj(soundName);
            this.playingLoop(sound,playingName);
            dict[soundName] = sound;
         }
      }
      
      protected function playingLoop(_sound:Sound, _playingName:String) : void
      {
         if(playing != _playingName)
         {
            playing = _playingName;
            if(loopChannel)
            {
               loopChannel.stop();
            }
            loopChannel = _sound.play(0,999);
            setVom(loopChannel);
         }
      }
      
      public function play(soundName:String, isLoad:Boolean = true) : void
      {
         var snum:* = 0;
         switch(soundName)
         {
            case "SD_xz":
            case "Role1_dead":
            case "Role1_jump":
            case "Role1_hit1AndHit2":
            case "Role1_hit3AndHit4":
            case "Role1_hit5":
            case "Role1_hit6":
            case "Role1_hit7":
            case "Role1_hit8":
            case "Role1_hit9":
            case "Role1_hit11":
            case "Role1_hit12_1":
            case "Role1_hit12_2":
            case "Role1_hit13_1":
            case "Role1_hit13_2":
            case "Role1_hit14":
            case "Role1_hit10_1":
            case "Role1_hit10_2":
            case "Role1_hit10_4":
            case "Role1_beAttack":
            case "Role2_beAttack":
            case "Role3_beAttack":
            case "BeattackByRole1":
            case "BeattackByRole2":
            case "Role2_dead":
            case "Role2_jump":
            case "Role2_hit1":
            case "Role2_hit2":
            case "Role2_hit3":
            case "Role2_hit4":
            case "Role2_hit5":
            case "Role2_hit6":
            case "Role2_hit7":
            case "Role2_hit8":
            case "Role2_hit9":
            case "Role2_hit10":
            case "Role3_dead":
            case "Role3_jump":
            case "Role3_hit1":
            case "Role3_hit2":
            case "Role3_hit3":
            case "Role3_hit4":
            case "Role3_hit5":
            case "Role3_hit6":
            case "Role3_hit7":
            case "Role3_hit8":
            case "Role3_hit9":
            case "Role3_hit10":
            case "Role3_hit11":
            case "Role3_hit12_1":
            case "Role3_hit12_2":
            case "Role4_hit1":
            case "Role4_hit2":
            case "Role4_hit3":
            case "Role4_hit1Arrow":
            case "Role4_hit2Arrow":
            case "Role4_hit4":
            case "Role4_hit4Arrow":
            case "Role4_hit5":
            case "Role4_hit6":
            case "Role4_hit7":
            case "Role4_hit8":
            case "Role4_hit8Arrow":
            case "Role4_hit9Arrow":
            case "Role4_hit10":
            case "Role4_hit10Arrow":
            case "Role4_hit11":
            case "Role4_hit12":
            case "Role4_hit12Arrow":
            case "Role4_mds":
            case "Game_Victory":
            case "stage221mmmm1":
            case "stage221mmmm2":
            case "stage221mmmm3":
            case "stage221mmmm4":
            case "stage221mmmm5":
            case "stage221mmmm6":
               if(AssetsManager.getInstance().contains(musicswfName))
               {
                  this.cacheHandlerDictionary(soundName);
               }
               else
               {
                  this.musicLoader.addMusicLoad(musicswfName);
               }
               break;
            case "stage221mmmm7":
               this.lastBgPlaying = soundName;
               if(AssetsManager.getInstance().contains(musicswfName))
               {
                  this.cacheHandlerDictionaryLoop(soundName,soundName);
               }
               else
               {
                  this.musicLoader.addMusicLoad(musicswfName,doWhenBigMusicLoadComplete);
               }
               break;
            case "begin":
               this.lastBgPlaying = soundName;
               if(AssetsManager.getInstance().contains(musicswfName))
               {
                  this.cacheHandlerDictionaryLoop(soundName,soundName);
               }
               else
               {
                  this.musicLoader.addMusicLoad(musicswfName,doWhenBigMusicLoadComplete);
               }
               break;
            case "over":
            case "stage0":
            case "stage1":
            case "stage2":
            case "stage3":
            case "stage4":
            case "stage5":
            case "stage6":
            case "stage7":
            case "stage12":
            case "stage21":
               this.lastBgPlaying = soundName;
               snum = uint(int(soundName.substring(5)));
               if(snum == 4)
               {
                  snum = uint(5);
               }
               if(AssetsManager.getInstance().contains("music_bg" + snum + ".swf"))
               {
                  this.cacheHandlerDictionaryLoop("music_bg" + snum,soundName);
               }
               else
               {
                  this.musicLoader.addMusicLoad("music_bg" + snum + ".swf",doWhenBigMusicLoadComplete);
               }
               break;
            case "stage22":
               this.lastBgPlaying = soundName;
               if(AssetsManager.getInstance().contains("shengDanMusic.swf"))
               {
                  this.cacheHandlerDictionaryLoop("shengDanMusic",soundName);
               }
               else
               {
                  this.musicLoader.addMusicLoad("shengDanMusic.swf",doWhenBigMusicLoadComplete);
               }
               break;
            case "shengDanMusic":
               this.lastBgPlaying = soundName;
               if(AssetsManager.getInstance().contains("xinnianMusic.swf"))
               {
                  this.cacheHandlerDictionaryLoop("xinnianMusic",soundName);
               }
               else
               {
                  this.musicLoader.addMusicLoad("xinnianMusic.swf",doWhenBigMusicLoadComplete);
               }
               break;
            case "xinnianMusic":
         }
      }
      
      public function doWhenBigMusicLoadComplete() : void
      {
         this.play(this.lastBgPlaying,false);
      }
      
      public function setVom(c:SoundChannel) : void
      {
         var stf:* = null;
         if(c)
         {
            stf = c.soundTransform;
            if(stf)
            {
               stf.volume = 1;
               c.soundTransform = stf;
            }
         }
      }
      
      public function stopPlay() : void
      {
         if(loopChannel)
         {
            loopChannel.stop();
         }
      }
      
      public function controlSound() : *
      {
         if(soundStay)
         {
            soundStay = false;
            SoundMixer.soundTransform = new SoundTransform(0);
         }
         else
         {
            soundStay = true;
            SoundMixer.soundTransform = new SoundTransform(1);
         }
      }
   }
}
