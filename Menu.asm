SDLSTL = $230

DDEVIC = $300
DCOMND = $302
DSTATS = $303

SIOV   = $E459



    org $2000

; Inicio del programa
start
    mwa #dl SDLSTL

; Setea directorio raiz (/) del sdrive
directorio_raiz		
    lda #$FE	
    jsr Set300UniCommandA
    lda #1
    sta DSTATS
    jsr SIOV

    jmp * 


; Diseño de pantalla 
dl
    .by $70,$70,$47
    .wo title
    .by $10
    .by $42
    .wo files
:20 .by $02
    .by $10
    .by $02
    .by $41
    .wo dl

; Textos de la pantalla
title
    .sb "    SDRIVE-MENU    "
files
:21 .sb "                                        "
directory
	.sb "/                                       "*



; Comando SIO para el firmware
Set300UniCommandA
    pha
    ldy #15
sdx1
    lda SIO_unico,y
    sta DDEVIC,y
    dey
    bpl sdx1
    pla
    sta DCOMND
    rts


;Bytes para el SIO
SIO_unico
    .byte $71        ;Unidad ID
sdrive
    .byte $01        ;Unidad num
    .byte $00        ;Comando
    .byte $40        ;
    .word siobuffer  ;Buffer del SIO
    .byte $07
    .byte $00
    .byte $00,$00
    .byte $00,$00
    .byte $00,$00,$00,$00

siobuffer = *
