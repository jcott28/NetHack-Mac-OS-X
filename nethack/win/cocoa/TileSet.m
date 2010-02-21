//
//  TileSet.m
//  SlashEM
//
//  Created by dirk on 1/17/10.
//  Copyright 2010 Dirk Zimmermann. All rights reserved.
//

/*
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "TileSet.h"

static TileSet *s_instance = nil;

@implementation TileSet

@synthesize image;
@synthesize	tileSize;

+ (TileSet *)instance {
	return s_instance;
}

+ (void)setInstance:(TileSet *)ts {
	[s_instance release];
	s_instance = ts;
}

- (id)initWithImage:(NSImage *)img tileSize:(NSSize)ts {
	if (self = [super init]) {
		image = [img retain];
		tileSize = ts;
		rows = image.size.height / tileSize.height;
		columns = image.size.width / tileSize.width;
	}
	return self;
}

- (NSRect)sourceRectForGlyph:(int)glyph {
	int tile = glyph2tile[glyph];
	return [self sourceRectForTile:tile];
}

- (NSRect)sourceRectForTile:(int)tile {
	int row = rows - 1 - tile/columns;
	int col = row ? tile % columns : tile;
	NSRect r = { col * tileSize.width, row * tileSize.height };
	r.size = tileSize;
	return r;
}

- (void)dealloc {
	[image release];
	[super dealloc];
}

@end