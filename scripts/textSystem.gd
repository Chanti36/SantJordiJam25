extends RichTextLabel

# 12 34 56
var txt_char1_intro := "Hoal 1."
var txt_char1_outro := "xao1"
var txt_char2_intro := "Hoal 2"
var txt_char2_outro := "xao2"
var txt_char3_intro := "Hoal 3"
var txt_char3_outro := "xao3"
var txt_char4_intro := "Hoal 4"
var txt_char4_outro := "xao4"

var txt_selected := ""

var i_charIndex :=0

var f_charDelay = 0.07
var f_charTimer = 0.0
var f_phraseDelay = 2.0
var f_phraseTimer = 0.0

var b_showingTxt := false

func _ready() -> void:
	text = ""
	i_charIndex = 0
	f_charTimer = 0.0
	f_phraseTimer = 0.0
	b_showingTxt = false

func StartConversation(txtIndex : int):
	if   txtIndex == 1:	txt_selected = txt_char1_intro
	elif txtIndex == 2:	txt_selected = txt_char1_outro
	elif txtIndex == 3:	txt_selected = txt_char2_intro
	elif txtIndex == 4:	txt_selected = txt_char2_outro
	elif txtIndex == 5:	txt_selected = txt_char3_intro
	else:				txt_selected = txt_char3_outro
	
	i_charIndex = 0
	f_charTimer = 0.0
	f_phraseTimer = 0.0
	b_showingTxt = true

func _process(delta: float) -> void:
	#txt_display.visible_characters
	
	if !b_showingTxt:
		return
	f_charTimer += delta
	print("asdasdasdasd")
	
	if i_charIndex < txt_selected.length():
		if f_charTimer > f_charDelay:
			f_charTimer = 0.0
			text += txt_selected[i_charIndex]
			i_charIndex += 1
		return
	
	f_phraseTimer +=delta
	
	if f_phraseTimer > f_phraseDelay:
		b_showingTxt = false
		text = ""
		SIG_finishedText.emit()

signal SIG_finishedText
