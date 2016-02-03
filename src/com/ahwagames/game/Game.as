package com.ahwagames.game 
{
	import com.ahwagames.Main;
	import com.ahwagames.Resource;
	import com.fegla.Camera;
	import com.fegla.events.AreaEvent;
	import com.fegla.events.OverlapEvent;
	import com.fegla.events.PlatformEvent;
	import com.fegla.Hero;
	import com.fegla.Platform;
	import com.fegla.texture.TextureTile;
	import com.fegla.World;
	import com.greensock.TweenLite;
	import flash.ui.Keyboard;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Game extends Sprite
	{
		private var main:Main;
		private var currPanel:Sprite;
		
		private var world:World;
		private var tGems:TextField;
		
		public function Game()
		{
			main = Main.instance;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			createUI();
			newGame();
		}
		
		private function createUI():void
		{
			var btnLeave:Button = new Button(Resource.btnPlayTexture);
			btnLeave.x = stage.stageWidth  - btnLeave.width - 5;
			btnLeave.y = 5;
			btnLeave.addEventListener(Event.TRIGGERED, onLeave);
			addChild(btnLeave);
			
			tGems = new TextField(200, 30, "");
			tGems.bold = true;
			tGems.hAlign = "left";
			tGems.color = 0xffffff;
			tGems.x = 15;
			tGems.y = 10;
			addChild(tGems);
		}
		
		private function newGame():void
		{
			world = new World();
			addChildAt(world, 0);
			
			world.loadLevel(Resource.lvl1, Resource.ta);
			world.drawDebug();
			
			world.background.addLayer(Resource.bgTexture, .5, 1);
			
			world.hero.addStateTextures(Resource.ta.getTextures("hero_stand"), 12, "stand");
			world.hero.addStateTextures(Resource.ta.getTextures("hero_walk"), 12, "walk");
			world.hero.addStateTextures(Resource.ta.getTextures("hero_jump"), 12, "jump");
			world.hero.setState("stand");
			
			world.addOverlap("hero", "gems");
			world.addOverlap("hero", "door");
			
			world.hero.moveTo(250, 560);
			world.hero.allowLadderJump = true;
			world.addEventListener(PlatformEvent.TOUCH_FLOOR, onHeroTouchFloor);
			world.addEventListener(PlatformEvent.LEAVE_FLOOR, onHeroLeaveFloor);
			world.addEventListener(AreaEvent.ENTER_AREA, onHeroEnterArea);
			world.addEventListener(AreaEvent.LEAVE_AREA, onHeroLeaveArea);
			world.addEventListener(OverlapEvent.OVERLAP_START, onOverlapStart);
			world.addEventListener(OverlapEvent.OVERLAP_END, onOverlapEnd);
			
			world.getItemById(18, "door").visible = false;
			tGems.text = "Gems collected: 0/" + world.getInitialItemsCount("gems");
			
			addEventListener(Event.ENTER_FRAME, onEF);
		}
		
		private function onOverlapStart(e:OverlapEvent):void 
		{
			trace("onOverlapStart", e.overlap.item1, e.overlap.item2);
			
			if (e.overlap.groupId2 == "gems")
			{
				TweenLite.to(e.overlap.item2, .5, { x: tGems.x + tGems.textBounds.width - 10, y: tGems.height, scaleX:.5, scaleY:.5,
					onComplete: function ():void 
					{
						world.removeItem(e.overlap.item2);
						
						tGems.text = "Gems collected: " + (world.getInitialItemsCount("gems") - world.getCurrentItemsCount("gems")) + "/" + world.getInitialItemsCount("gems");
						
						if (world.getCurrentItemsCount("gems") == 0) // all gems collected
						{
							world.getItemById(18, "door").visible = true;
						}
					}
				});
			}
			else if (e.overlap.groupId2 == "door")
			{
				trace("door touched");
			}
		}
		
		private function onOverlapEnd(e:OverlapEvent):void 
		{
			trace("onOverlapEnd", e.overlap.item1, e.overlap.item2);
		}
		
		private function onHeroEnterArea(e:AreaEvent):void 
		{
			//trace("onHeroEnterArea: " + e.area.id);
			
			var pf:Platform = world.getPlatformById(12);
			//pf.moveTo(500, 490, 3);
		}
		
		private function onHeroLeaveArea(e:AreaEvent):void 
		{
			//trace("onHeroLeaveArea()");
			
			var pf:Platform = world.getPlatformById(12);
			//pf.moveTo(790, 490, 3);
		}
		
		private function onHeroTouchFloor(e:PlatformEvent):void 
		{
			//trace("onHeroTouchFloor");
			
		}
		
		private function onHeroLeaveFloor(e:PlatformEvent):void 
		{
			//trace("onHeroLeaveFloor");
		}
		
		private function onEF(e:Event):void
		{
			world.update();
		}
		
		private function onLeave(e:Event):void
		{
			setCurrPanel(ConfirmLeave);
		}
		
		public function setCurrPanel(panelClass:Class):void
		{
			if (currPanel) 
				removeChild(currPanel);
			
			currPanel = new panelClass();
			addChild(currPanel);
		}
		
		public function removeCurrPanel():void
		{
			if (currPanel)
			{
				removeChild(currPanel);
				currPanel = null;
			}
		}
		
		private function onRemoved(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			removeEventListener(Event.ENTER_FRAME, onEF);
		}
	}
}