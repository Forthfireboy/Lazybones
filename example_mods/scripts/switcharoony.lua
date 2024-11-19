function onCreatePost()
	
setPropertyFromClass('ClientPrefs', 'downScroll', false)
	noteTweenY('opp0', 0, 525, 0.0001, 'quartInOut')
	noteTweenY('opp1', 1, 525, 0.0001, 'quartInOut')
	noteTweenY('opp2', 2, 525, 0.0001, 'quartInOut')
	noteTweenY('opp3', 3, 525, 0.0001, 'quartInOut')

	noteTweenX('dadNormalX1', 0, 745, 0.0001, 'linear');
	noteTweenX('dadNormalX2', 1, 850, 0.0001, 'linear');
	noteTweenX('dadNormalX3', 2, 955, 0.0001, 'linear');
	noteTweenX('dadNormalX4', 3, 1060, 0.0001, 'linear');

	noteTweenX('bfleft1', 4, 90, 0.0001, 'linear');
	noteTweenX('bfleft2', 5, 205, 0.0001, 'linear');
	noteTweenX('bfleft3', 6, 315, 0.0001, 'linear');
	noteTweenX('bfleft4', 7, 425, 0.0001, 'linear');
for i = 0,3 do setPropertyFromGroup('opponentStrums',i,'downScroll',true) end

end

