UserView understands: 'bitsLengthFor: extent [(extent y) * (extent x + 15 / 16)*2]'.
UserView understands: 'bitsFor: extent [String new: (self bitsLengthFor: extent)]'.
Form understands: 'extent: ext bits: str offset: pt | bitsLength expectedBitsLength
	[bitsLength _ str length.
	expectedBitsLength _ user bitsLengthFor: ext.
	extent _ ext.
	bits _ str.
	offset _ pt.
	bitsLength  expectedBitsLength  [
		user cr show: ''('' + (ext x asString) + ''x'' + (ext y asString) + '') '' + expectedBitsLength asString.
		user show: ''<->'' + bitsLength asString.
	]
]' classified: 'as yet unclassified'.
Form understands:  'extent: extent figure: figure ground: ground offset: offset
	["creates a virtual bit map with width = (extent x) and height = (extent y) with the bits all 1."
	bits _ (user bitsFor: extent).
	]'.
UserView understands: 'restoredisplay | ext rect
	[ext _ self primScreenExtent.
	screenrect = (00 rect: ext) and DisplayForm extent = ext  [self mapDisplay]
	self currentDisplay: (Form new extent: ext)]'.
Form understands:  'extent: extent figure: figure ground: ground offset: offset
	["creates a virtual bit map with width = (extent x) and height = (extent y) with the bits all 1."
	extent _ extent.
	bits _ (user bitsFor: extent).
	offset _ offset
	]'.
