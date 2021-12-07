globals 

	integer array Absolute_item
	integer array Absolute_ability
    
	hashtable ITEM_SPELL = InitHashtable()
endglobals


function SaveItemAbility takes integer abilityId, integer itemId returns nothing
	call SaveInteger(ITEM_SPELL,abilityId,1,itemId)
	call SaveInteger(ITEM_SPELL,itemId,2,abilityId)    
endfunction

function GetItemAbility takes integer itemId returns integer
	return LoadInteger(ITEM_SPELL,itemId,2)
endfunction

function Trig_Spell_Initialization_Actions takes nothing returns nothing
	/*set udg_integers08[1]='A06S'
	set udg_integers08[2]= 'ANms'
	set udg_integers08[3]= 'AUcs'
	set udg_integers08[4]= 'AOcr'
	set udg_integers08[5]= 'AHad'
	set udg_integers08[6]= 'AOae'
	set udg_integers08[7]= 'AEev'
	set udg_integers08[8]= 'AEfk'
	set udg_integers08[9]= 'AOsf'
	set udg_integers08[10]= 'AHfs'
	set udg_integers08[11]= 'ANfl'
	set udg_integers08[12]= 'AUfn'
	set udg_integers08[13]= 'A06M'
	set udg_integers08[14]= 'AHhb'
	set udg_integers08[15]= 'AUim'
	set udg_integers08[16]= 'AOsw'
	set udg_integers08[17]= 'AEsh'
	set udg_integers08[18]= 'A08F'
	set udg_integers08[19]= 'AHtc'
	set udg_integers08[20]= 'AUau'
	set udg_integers08[21]= 'AUav'
	set udg_integers08[22]= 'AOws'
	set udg_integers08[23]= LIFE_DRAIN_ABILITY_ID
	set udg_integers08[24]= 'ANca'
	set udg_integers08[25]= 'AUts'
	set udg_integers08[26]= ENTAGLING_ROOTS_ABILITY_ID
	set udg_integers08[27]= 'AHwe'
	set udg_integers08[28]= SHOCKWAVE_ABILITY_ID
	set udg_integers08[29]= 'ANlm'
	set udg_integers08[30]= 'A023'
	set udg_integers08[31]= 'AEar'
	set udg_integers08[32]= IMMOLATION_ABILITY_ID
	set udg_integers08[33]= STORM_BOLT_ABILITY_ID
	set udg_integers08[34]= MIRROR_IMAGE_ABILITY_ID
	set udg_integers08[35]= 'AOcl'
	set udg_integers08[36]= 'AEtq'
	set udg_integers08[37]= 'ANcs'
	set udg_integers08[38]= 'AOwk'
	set udg_integers08[39]= 'ANdh'
	set udg_integers08[40]= 'ANbf'
	set udg_integers08[41]= 'A025'
	set udg_integers08[42]= 'A024'
	set udg_integers08[43]= 'ANab'
	set udg_integers08[44]= 'AEsf'
	set udg_integers08[45]= 'Aam2'
	set udg_integers08[46]= 'AUfu'
	set udg_integers08[47]= 'AHbz'
	set udg_integers08[48]= 'ANrf'
	set udg_integers08[49]= 'ANst'
	set udg_integers08[50]= 'ANht'
	set udg_integers08[51]= 'AUin'
	set udg_integers08[52]= 'AOhw'
	set udg_integers08[53]= 'AHbn'
	set udg_integers08[54]= 'ANhs'
	set udg_integers08[55]= 'AHav'
	set udg_integers08[56]= 'ANbr'
	set udg_integers08[57]= 'AUdd'
	set udg_integers08[58]= 'AEsv'
	set udg_integers08[59]= 'Ablo'
	set udg_integers08[60]= 'ANsy'
	set udg_integers08[61]= 'Awar'
	set udg_integers08[62]= 'A00Q'
	set udg_integers08[63]= 'AUcb'
	set udg_integers08[64]= 'Aakb'
	set udg_integers08[65]= 'Assk'
	set udg_integers08[66]= 'AHfa'
	set udg_integers08[67]= 'Arai'
	set udg_integers08[68]= 'ANba'
	set udg_integers08[69]= 'AHca'
	set udg_integers08[70]= 'Afae'
	set udg_integers08[71]= 'ANpa'
	set udg_integers08[72]= 'Acrs'
	set udg_integers08[73]= 'Ainf'
	set udg_integers08[74]= 'ACac'
	set udg_integers08[75]= 'A050'
	set udg_integers08[76]= 'ANsw'
	set udg_integers08[77]= 'ANsg'
	set udg_integers08[78]= 'Arsq'
	set udg_integers08[79]= 'AHpx'
	set udg_integers08[80]= 'Ahwd'
	set udg_integers08[81]= UNHOLY_FRENZY_ABILITY_ID
	set udg_integers08[82]= 'Absk'
	set udg_integers08[83]= 'Arej'
	set udg_integers08[84]= LIGHTNING_SHIELD_ABILITY_ID
	set udg_integers08[85]= 'ANvc'
	set udg_integers08[86]= 'ANen'
	set udg_integers08[87]= 'A06Q'
	set udg_integers08[88]= PLAGUE_ABILITY_ID
	set udg_integers08[89]= 'Asal'
	set udg_integers08[90]= 'A06O'
	set udg_integers08[91]= 'Aroc'
	set udg_integers08[92]= 'AOr2'
	set udg_integers08[93]= 'AEbl'
	set udg_integers08[94]= 'Apsh'
	set udg_integers08[95]= 'Afod'
	set udg_integers08[96]= 'A02L'	
	set udg_integers08[97]= 'A02K'
	set udg_integers08[98]= 'A02M'
	set udg_integers08[99]= 'A02N'
	set udg_integers08[100]= 'A02O'
	set udg_integers08[101]= 'A02S'
	set udg_integers08[102]= 'A02T'
	set udg_integers08[103]= 'A02U'    
	set udg_integers08[104]= 'A02W'  
	set udg_integers08[105]= 'A02X'    
	set udg_integers08[106]= 'A02Z'  
	set udg_integers08[107]= 'AHab' 
	set udg_integers08[108]= 'A03P'
	set udg_integers08[109]= 'A03Q'
	set udg_integers08[110]= 'A03U'  
	set udg_integers08[111]= 'A03X'  
	set udg_integers08[112]= 'A03Y'     
	set udg_integers08[113]= 'A040'  
	set udg_integers08[114]= 'A041' 
	set udg_integers08[115]= 'A042'     
	set udg_integers08[116]= 'A045' 
	set udg_integers08[117]= 'ANr2' 
	set udg_integers08[118]= 'Acdb' 
	set udg_integers08[119]= 'ANde'    
	set udg_integers08[120]= 'ACpv' 
	set udg_integers08[121]= 'AHab' 

                                          	
	set udg_integers09[1]= 'I00L'
	set udg_integers09[2]= 'I03F'
	set udg_integers09[3]= 'I008'
	set udg_integers09[4]= 'I00B'
	set udg_integers09[5]= 'I009'
	set udg_integers09[6]= 'I000'
	set udg_integers09[7]= 'I00A'
	set udg_integers09[8]= 'I003'
	set udg_integers09[9]= 'I004'
	set udg_integers09[10]= 'I005'
	set udg_integers09[11]= 'I001'
	set udg_integers09[12]= 'I00C'
	set udg_integers09[13]= 'I045'
	set udg_integers09[14]= 'I00D'
	set udg_integers09[15]= 'I006'
	set udg_integers09[16]= 'I00E'
	set udg_integers09[17]= 'I00F'
	set udg_integers09[18]= 'I00H'
	set udg_integers09[19]= 'I00I'
	set udg_integers09[20]= 'I007'
	set udg_integers09[21]= 'I00J'
	set udg_integers09[22]= 'I00K'
	set udg_integers09[23]= 'I00M'
	set udg_integers09[24]= 'I00N'
	set udg_integers09[25]= 'I00O'
	set udg_integers09[26]= 'I00Q'
	set udg_integers09[27]= 'I00S'
	set udg_integers09[28]= 'I00R'
	set udg_integers09[29]= 'I00T'
	set udg_integers09[30]= 'I04H'
	set udg_integers09[31]= 'I00W'
	set udg_integers09[32]= 'I00V'
	set udg_integers09[33]= 'I00X'
	set udg_integers09[34]= 'I00Z'
	set udg_integers09[35]= 'I010'
	set udg_integers09[36]= 'I042'
	set udg_integers09[37]= 'I01A'
	set udg_integers09[38]= 'I01R'
	set udg_integers09[39]= 'I01S'
	set udg_integers09[40]= 'I01T'
	set udg_integers09[41]= 'I02B'
	set udg_integers09[42]= 'I04I'
	set udg_integers09[43]= 'I01Z'
	set udg_integers09[44]= 'I01Y'
	set udg_integers09[45]= 'I03S'
	set udg_integers09[46]= 'I01W'
	set udg_integers09[47]= 'I024'
	set udg_integers09[48]= 'I025'
	set udg_integers09[49]= 'I026'
	set udg_integers09[50]= 'I040'
	set udg_integers09[51]= 'I02A'
	set udg_integers09[52]= 'I029'
	set udg_integers09[53]= 'I02C'
	set udg_integers09[54]= 'I028'
	set udg_integers09[55]= 'I027'
	set udg_integers09[56]= 'I02D'
	set udg_integers09[57]= 'I02E'
	set udg_integers09[58]= 'I03Y'
	set udg_integers09[59]= 'I02F'
	set udg_integers09[60]= 'I02G'
	set udg_integers09[61]= 'I02H'
	set udg_integers09[62]= 'I02I'
	set udg_integers09[63]= 'I02M'
	set udg_integers09[64]= 'I002'
	set udg_integers09[65]= 'I02O'
	set udg_integers09[66]= 'I02P'
	set udg_integers09[67]= 'I02Q'
	set udg_integers09[68]= 'I02R'
	set udg_integers09[69]= 'I02S'
	set udg_integers09[70]= 'I02T'
	set udg_integers09[71]= 'I02U'
	set udg_integers09[72]= 'I02V'
	set udg_integers09[73]= 'I02W'
	set udg_integers09[74]= 'I02X'
	set udg_integers09[75]= 'I03X'
	set udg_integers09[76]= 'I02Z'
	set udg_integers09[77]= 'I030'
	set udg_integers09[78]= 'I031'
	set udg_integers09[79]= 'I032'
	set udg_integers09[80]= 'I033'
	set udg_integers09[81]= 'I034'
	set udg_integers09[82]= 'I036'
	set udg_integers09[83]= 'I037'
	set udg_integers09[84]= 'I038'
	set udg_integers09[85]= 'I039'
	set udg_integers09[86]= 'I03A'
	set udg_integers09[87]= 'I03B'
	set udg_integers09[88]= 'I03V'
	set udg_integers09[89]= 'I03D'
	set udg_integers09[90]= 'I03E'
	set udg_integers09[91]= 'I03N'
	set udg_integers09[92]= 'I03G'
	set udg_integers09[93]= 'I03M'
	set udg_integers09[94]= 'I03U'
	set udg_integers09[95]= 'I03Q'
	set udg_integers09[96]= 'I04X'
	set udg_integers09[97]= 'I04Y'
	set udg_integers09[98]= 'I04Z'
	set udg_integers09[99]= 'I050'
	set udg_integers09[100]= 'I051'
	set udg_integers09[101]= 'I053'
	set udg_integers09[102]= 'I054'
	set udg_integers09[103]= 'I055'
	set udg_integers09[104]= 'I056'   
	set udg_integers09[105]= 'I057'      
	set udg_integers09[106]= 'I058'      	
	set udg_integers09[107]= 'I00U'
	set udg_integers09[108]= 'I05M'  
	set udg_integers09[109]= 'I05N'  
	set udg_integers09[110]= 'I05O'		
	set udg_integers09[111]= 'I05P'	
	set udg_integers09[112]= 'I05Q'
	set udg_integers09[113]= 'I05R'    
	set udg_integers09[114]= 'I05S'  
	set udg_integers09[115]= 'I05T' 
	set udg_integers09[116]= 'I05V' 
	set udg_integers09[117]= 'I00Y' 
	set udg_integers09[118]= 'I05W' 
	set udg_integers09[119]= 'I05X' 
	set udg_integers09[120]= 'I05Y' 
	set udg_integers09[121]= 'ANms'    
    
    
	set udg_integers08[122]= 'AHds' 
	set udg_integers09[122]= 'I011'    
    
	set udg_integers08[123]= 'ANtm' 
	set udg_integers09[123]= 'I00G'
    
	set udg_integers08[124]= 'ANsi' 
	set udg_integers09[124]= 'I03C' 
    
	set udg_integers08[125]= 'Asta' 
	set udg_integers09[125]= 'I044'     
       

	set udg_integers08[126]= 'AUdp' 
	set udg_integers09[126]= 'I01V'
    
	set udg_integers08[127]= 'AOvd' 
	set udg_integers09[127]= 'I03Z'        
  
	set udg_integers08[128]= 'A046' 
	set udg_integers09[128]= 'I05Z'
 
	set udg_integers08[129]= 'ANso' 
	set udg_integers09[129]= 'I062'  
        
	set udg_integers08[130]= 'Aclf' 
	set udg_integers09[130]= 'I063'    
    
	set udg_integers08[131]= 'A04E' 
	set udg_integers09[131]= 'I067'    
                   
	set udg_integers08[132]= 'A04F' 
	set udg_integers09[132]= 'I068'  

	set udg_integers08[133]= 'A04G' 
	set udg_integers09[133]= 'I069' 
 
	set udg_integers08[134]= 'A04H' 
	set udg_integers09[134]= 'I06A'  

	set udg_integers08[135]= 'A04K' 
	set udg_integers09[135]= 'I06C' 



	set udg_integers08[136]= 'A04L' 
	set udg_integers09[136]= 'I06D' 

	set udg_integers08[137]= 'ANmo' 
	set udg_integers09[137]= 'I06G' 

	set udg_integers08[138]= 'A053' 
	set udg_integers09[138]= 'I06L' 


	set udg_integers08[139]= 'A05R' 
	set udg_integers09[139]= 'I07J' 
    
	set udg_integers08[140]= 'A05S' 
	set udg_integers09[140]= 'I07L' 
    
    
    
	set udg_integers08[141]= 'A05U' 
	set udg_integers09[141]= 'I07N' 
    
    
	set udg_integers08[142]= 'A05X' 
	set udg_integers09[142]= 'I07Q' 
 
 
	set udg_integers08[143]= 'A05Z' 
	set udg_integers09[143]= 'I07R' 
    
    
	set udg_integers08[144]= 'A060' 
	set udg_integers09[144]= 'I07S'     
    
    
	set udg_integers08[145]= 'A067' 
	set udg_integers09[145]= 'I07X' 
  
	set udg_integers08[146]= 'A06C' 
	set udg_integers09[146]= 'I07Z' 
    
	set udg_integers08[147]= 'A06U' 
	set udg_integers09[147]= 'I081'     
    
	set udg_integers08[148]= 'A06V' 
	set udg_integers09[148]= 'I085'  
 
	set udg_integers08[149]= 'A06X' 
	set udg_integers09[149]= 'I087'  
    
    
	set udg_integers08[150]= 'A06Z' 
	set udg_integers09[150]= 'I08K'  

    
	set udg_integers08[151]= 'A07L' 
	set udg_integers09[151]= 'I094'     
	set udg_integers08[152]= 'A07N' 
	set udg_integers09[152]= 'I096'  
	set udg_integers08[153]= 'A07U' 
	set udg_integers09[153]= 'I09C'  
	set udg_integers08[154]= 'A07S' 
	set udg_integers09[154]= 'I09A'  
	set udg_integers08[155]= 'A07T' 
	set udg_integers09[155]= 'I09B'      
   
	set udg_integers08[156]= 'A07X' 
	set udg_integers09[156]= 'I09G'   
    
	set udg_integers08[157]= 'A080' 
	set udg_integers09[157]= 'I09H'   
    
	set udg_integers08[158]= 'A081' 
	set udg_integers09[158]= 'I09I'       
    
	set udg_integers08[159]= 'A082' 
	set udg_integers09[159]= 'I09J'   
 
 
	set udg_integers08[160]= 'A083' 
	set udg_integers09[160]= 'I09K'   
    
	set udg_integers08[161]= 'A088' 
	set udg_integers09[161]= 'I09M'  
    
	set udg_integers08[162]= 'A089' 
	set udg_integers09[162]= 'I09L'  
    
	set udg_integers08[163]= 'A08E' 
	set udg_integers09[163]= 'I09N'

	set udg_integers08[164]= 'A08J' 
	set udg_integers09[164]= 'I09P'

	set udg_integers08[165]= 'A08I' 
	set udg_integers09[165]= 'I09Q'
    
	set udg_integer26 = 165
    
    
    
	call SaveItemAbility('A07R','I099')
	call SaveItemAbility('A07Q','I098')    
	call SaveItemAbility('A07D','I08V')    
	call SaveItemAbility('A07B','I08T')    
	call SaveItemAbility('A07P','I097')    
	call SaveItemAbility('A07C','I08U')    
	call SaveItemAbility('A07K','I093')      
	call SaveItemAbility('A07E','I08W')    
	call SaveItemAbility('A07V','I09F')    
	*/
    
  



endfunction