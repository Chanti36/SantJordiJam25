extends RichTextLabel

const txt_char1_intro := "Gracias por venir, pero ya se han llevado todo como han querido. Los dragones nos están asfixiando ¿Que se te está pasando por la cabeza?"
const txt_char1_outro := "Estoy intentando juntar al resto para organizarnos a nivel local, hay que buscar una forma de no depender de los malditos dragones"

const txt_char2_intro := "Al final no voy a poder quedar hoy. Estoy aquí liadísima que he tenido que coger unos turnos extra para ver si aguanto"
const txt_char2_outro := "... si, lo se, estoy hablando con un sindicato, esto no puede seguir así"

const txt_char3_intro := "Me han vuelto a subir el alquiler macho, no se que voy a hacer el mes que viene si aún debo este"
const txt_char3_outro := "Realmente con la de casas que tiene para alquilar ni se dará cuenta si le okupo una"

const txt_char4_intro := "Basta ya de tonterías! Deja de molestar a la gente!! Deberías esforzarte más igual así puedes llegar a mi puesto ¿No es eso lo que quieres? ¿Que pretendes hacer conmigo?"


var txt_selected := ""

var i_charIndex := 0

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
	if   txtIndex == 1: txt_selected = txt_char1_intro
	elif txtIndex == 2: txt_selected = txt_char1_outro
	elif txtIndex == 3: txt_selected = txt_char2_intro
	elif txtIndex == 4: txt_selected = txt_char2_outro
	elif txtIndex == 5: txt_selected = txt_char3_intro
	elif txtIndex == 6: txt_selected = txt_char3_outro
	elif txtIndex == 7: txt_selected = txt_char4_intro
	
	i_charIndex = 0
	f_charTimer = 0.0
	f_phraseTimer = 0.0
	b_showingTxt = true

func _process(delta: float) -> void:
	#txt_display.visible_characters
	if !b_showingTxt:
		return
	f_charTimer += delta
	
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
