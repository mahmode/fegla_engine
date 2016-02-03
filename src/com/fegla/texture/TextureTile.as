package com.fegla.texture
{
	import com.fegla.FeglaItem;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;
	
	/**
	 * tile platforms using textures
	 */
	public class TextureTile
	{
		private var tileBR:Image;
		private var tileBC:Image;
		private var tileBL:Image;
		private var tileR:Image;
		private var tileC:Image;
		private var tileL:Image;
		private var tileTR:Image;
		private var tileTC:Image;
		private var tileTL:Image;
		
		private var tileTL_w:Number;
		private var tileTL_h:Number;
		private var tileTC_w:Number;
		private var tileTC_h:Number;
		private var tileTR_w:Number;
		private var tileTR_h:Number;
		
		private var tileL_w:Number;
		private var tileL_h:Number;
		private var tileC_w:Number;
		private var tileC_h:Number;
		private var tileR_w:Number;
		private var tileR_h:Number;
		
		private var tileBL_w:Number;
		private var tileBL_h:Number;
		private var tileBC_w:Number;
		private var tileBC_h:Number;
		private var tileBR_w:Number;
		private var tileBR_h:Number;
		
		/**
		 * the textures vector
		 */
		public var textures:Vector.<Texture>;
		
		/**
		 * Constructor
		 */
		public function TextureTile(textures:Vector.<Texture>)
		{
			this.textures = textures;
			
			if (!textures || textures.length == 0)
				throw new Error("Invalid texture vector provided.");
			
			tileTL = new Image(textures[0]);
			tileTC = textures.length > 1 ? new Image(textures[1]) : tileTL;
			tileTR = textures.length > 2 ? new Image(textures[2]) : tileTC;
			tileL = textures.length > 3 ? new Image(textures[3]) : tileTL;
			tileC = textures.length > 4 ? new Image(textures[4]) : tileTC;
			tileR = textures.length > 5 ? new Image(textures[5]) : tileTR;
			tileBL = textures.length > 6 ? new Image(textures[6]) : tileL;
			tileBC = textures.length > 7 ? new Image(textures[7]) : tileC;
			tileBR = textures.length > 8 ? new Image(textures[8]) : tileR;
			
			tileTL_w = tileTL.width;
			tileTL_h = tileTL.height;
			tileTC_w = tileTC.width;
			tileTC_h = tileTC.height;
			tileTR_w = tileTR.width;
			tileTR_h = tileTR.height;
			
			tileL_w = tileL.width;
			tileL_h = tileL.height;
			tileC_w = tileC.width;
			tileC_h = tileC.height;
			tileR_w = tileR.width;
			tileR_h = tileR.height;
			
			tileBL_w = tileBL.width;
			tileBL_h = tileBL.height;
			tileBC_w = tileBC.width;
			tileBC_h = tileBC.height;
			tileBR_w = tileBR.width;
			tileBR_h = tileBR.height;
		}
		public function run(target:FeglaItem):void
		{
			if (target.view)
				target.removeChild(target.view);
			
			var tile:Image;
			
			var centerAreaWidth:Number = target.w - tileTL.width - tileTR.width;
			var numCenterTilesH:int = int(centerAreaWidth / tileTC.width);
			var centerTileWidth:Number = centerAreaWidth / numCenterTilesH || 0;
			var numCols:int;
			
			if (centerAreaWidth == 0)
			{
				numCols = 2;
			}
			else if (centerAreaWidth < 0)
			{
				numCols = 1;
			}
			else
			{
				numCols = numCenterTilesH + 2;
			}
			
			var centerAreaHeight:Number = target.h - tileTL.height - tileBL.height;
			var numCenterTilesV:int = int(centerAreaHeight / tileL.height);
			var centerTileHeight:Number = centerAreaHeight / numCenterTilesV || 0;
			var numRows:int;
			
			if (centerAreaHeight == 0)
			{
				numRows = 2;
			}
			else if (centerAreaHeight < 0)
			{
				numRows = 1;
			}
			else
			{
				numRows = numCenterTilesV + 2;
			}
			
			var tileX:Number;
			var tileY:Number;
			
			var qb:QuadBatch = new QuadBatch();
			
			var j:int;
			for (var i:int = 0; i < numCols; i++)
			{
				tileX = i == 0 ? 0 : tileTL_w + (i - 1) * centerTileWidth;
				
				for (j = 0; j < numRows; j++)
				{
					tileY =  j == 0 ? 0 : tileTL_h + (j - 1) * centerTileHeight;
					
					if (i == 0) // L
					{
						if (j == 0) // TL
						{
							tile = tileTL;
							tile.width = tileTL_w;
							tile.height = tileTL_h;
						}
						else if (j == numRows - 1) // BL
						{
							tile = tileBL;
							tile.width = tileBL_w;
							tile.height = tileBL_h;
						}
						else // L
						{
							tile = tileL;
							tile.width = tileL_w;
							tile.height = centerTileHeight;
						}
					}
					else if (i == numCols - 1) // R
					{
						if (j == 0) // TR
						{
							tile = tileTR;
							tile.width = tileTR_w;
							tile.height = tileTR_h;
						}
						else if (j == numRows - 1) // BR
						{
							tile = tileBR;
							tile.width = tileBR_w;
							tile.height = tileBR_h;
						}
						else // R
						{
							tile = tileR;
							tile.width = tileR_w;
							tile.height = centerTileHeight;
						}
					}
					else // C
					{
						if (j == 0) // TC
						{
							tile = tileTC;
							tile.width = centerTileWidth;
							tile.height = tileTC_h;
						}
						else if (j == numRows - 1) // BC
						{
							tile = tileBC;
							tile.width = centerTileWidth;
							tile.height = tileBC_h;
						}
						else // C
						{
							tile = tileC;
							tile.width = centerTileWidth;
							tile.height = centerTileHeight;
						}
					}
					
					tile.x = tileX;
					tile.y = tileY;
					qb.addImage(tile);
				}
			}
			
			target.view = qb;
			target.addChild(target.view);
		}
	}
}