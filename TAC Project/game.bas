$CHECKING:OFF
_TITLE ""
_SCREENMOVE _MIDDLE
COLOR 15

CONST filetype$ = "txt"
CONST limitnum = 60
CONST debug = 0

IF _FILEEXISTS("data\settings\screen." + filetype$) THEN
    OPEN "data\settings\screen." + filetype$ FOR INPUT AS #1
    IF EOF(1) THEN SYSTEM
    INPUT #1, screen_x, screen_y
    CLOSE #1
    SCREEN _NEWIMAGE(screen_x, screen_y, 32)
ELSE SYSTEM
END IF

IF _FILEEXISTS("data\settings\title." + filetype$) THEN
    OPEN "data\settings\title." + filetype$ FOR INPUT AS #1
    IF EOF(1) THEN SYSTEM
    LINE INPUT #1, title$
    CLOSE #1
    _TITLE title$
ELSE SYSTEM
END IF

IF _FILEEXISTS("data\settings\iconfile." + filetype$) THEN
    OPEN "data\settings\iconfile." + filetype$ FOR INPUT AS #1
    IF EOF(1) THEN SYSTEM
    LINE INPUT #1, iconfile$
    CLOSE #1
    IF _FILEEXISTS("data\images\" + iconfile$) THEN
        I& = _LOADIMAGE("data\images\" + iconfile$, 32)
        IF I& < -1 THEN
            _ICON I&
            _FREEIMAGE I&
        ELSE SYSTEM
        END IF
    ELSE SYSTEM
    END IF
END IF

IF _FILEEXISTS("data\settings\startpart." + filetype$) THEN
    OPEN "data\settings\startpart." + filetype$ FOR INPUT AS #1
    IF EOF(1) THEN SYSTEM
    LINE INPUT #1, part$
    CLOSE #1
ELSE SYSTEM
END IF

1
CLS
COLOR 15
IF debug = 1 THEN
    _TITLE title$ + " | " + part$
ELSE
    _TITLE title$
END IF
IF _DIREXISTS("data\game\" + part$) THEN
    dir$ = "data\game\" + part$ + "\"
    IF _FILEEXISTS(dir$ + "run." + filetype$) THEN
        OPEN dir$ + "run." + filetype$ FOR INPUT AS #1
        IF EOF(1) THEN SYSTEM
        LINE INPUT #1, action$
        CLOSE #1
        IF action$ = "num" OR action$ = "end" OR action$ = "continue" THEN
        ELSE SYSTEM
        END IF
        texterrortype$ = ""
        IF _FILEEXISTS(dir$ + "images." + filetype$) THEN
            OPEN dir$ + "images." + filetype$ FOR INPUT AS #1
            texterrortype$ = "images"
            DO
                IF EOF(1) THEN SYSTEM
                LINE INPUT #1, iconfile$ ' the image
                IF EOF(1) THEN SYSTEM
                INPUT #1, x ' x of text
                IF EOF(1) THEN SYSTEM
                INPUT #1, y ' y of text
                IF x > screen_x OR y > screen_y THEN SYSTEM
                IF _FILEEXISTS("data\images\" + iconfile$) THEN
                    I& = _LOADIMAGE("data\images\" + iconfile$, 32)
                    IF I& < -1 THEN
                        _PUTIMAGE (x, y), I&
                    ELSE SYSTEM
                    END IF
                ELSE SYSTEM
                END IF
            LOOP UNTIL EOF(1)
            CLOSE #1
        END IF
        IF _FILEEXISTS(dir$ + "text." + filetype$) THEN
            OPEN dir$ + "text." + filetype$ FOR INPUT AS #1
            texterrortype$ = "text"
            DO
                IF EOF(1) THEN SYSTEM
                LINE INPUT #1, text$ ' the text
                IF EOF(1) THEN SYSTEM
                INPUT #1, x ' x of text
                IF EOF(1) THEN SYSTEM
                INPUT #1, y ' y of text
                IF EOF(1) THEN SYSTEM
                LINE INPUT #1, fg$
                IF EOF(1) THEN SYSTEM
                LINE INPUT #1, bg$
                IF EOF(1) THEN SYSTEM
                LINE INPUT #1, font$
                IF EOF(1) THEN SYSTEM
                INPUT #1, fontsize
                IF x > screen_x OR y > screen_y THEN SYSTEM
                IF bg$ = "?" THEN
                    COLOR VAL("&HFF" + fg$)
                ELSE
                    COLOR VAL("&HFF" + fg$), VAL("&HFF" + bg$)
                END IF
                IF font$ = "?" THEN
                    _FONT 16
                    IF bg$ = "?" THEN
                        _PRINTMODE _KEEPBACKGROUND
                    END IF
                    _PRINTSTRING (x, y), text$
                ELSE
                    IF fontsize <= 0 THEN SYSTEM
                    IF _FILEEXISTS("data\fonts\" + font$) THEN
                        f& = _LOADFONT("data\fonts\" + font$, fontsize)
                        _FONT f&
                        IF f& > 0 THEN
                            IF bg$ = "?" THEN
                                _PRINTMODE _KEEPBACKGROUND
                            END IF
                            _PRINTSTRING (x, y), text$
                            _FONT 16
                            _FREEFONT f&
                        ELSE SYSTEM
                        END IF
                    ELSE SYSTEM
                    END IF
                END IF
                _PRINTMODE _FILLBACKGROUND
                COLOR 15, 0
            LOOP UNTIL EOF(1)
            CLOSE #1
        END IF
        IF texterrortype$ = "" THEN SYSTEM
        texterrortype$ = ""

        _DISPLAY

        IF _FILEEXISTS(dir$ + "sound." + filetype$) THEN
            OPEN dir$ + "sound." + filetype$ FOR INPUT AS #1
            DO
                LINE INPUT #1, a$
                IF _FILEEXISTS("data\sound\" + a$) THEN
                    h& = _SNDOPEN("data\sound\" + a$)
                    IF h& = 0 THEN
                        SYSTEM
                    ELSE
                        _SNDPLAY h&
                    END IF
                    _SNDCLOSE h&
                ELSE SYSTEM
                END IF
            LOOP UNTIL EOF(1)
            CLOSE #1
        END IF


        IF action$ = "num" THEN
            ' Actions Stuff, but required
            IF _DIREXISTS(dir$ + "actions") THEN
                DO
                    _LIMIT limitnum
                    k$ = INKEY$
                    IF k$ <> "" THEN
                        IF _FILEEXISTS(dir$ + "actions\" + k$ + "." + filetype$) THEN
                            OPEN dir$ + "actions\" + k$ + "." + filetype$ FOR INPUT AS #1
                            IF EOF(1) THEN SYSTEM
                            LINE INPUT #1, part$
                            CLOSE #1
                            GOTO 1
                        END IF
                    END IF
                LOOP
            ELSE SYSTEM
            END IF
        ELSEIF action$ = "end" THEN
            DO
                _LIMIT limitnum

                'Actions Stuff
                IF _DIREXISTS(dir$ + "actions") THEN
                    k$ = INKEY$
                    IF k$ <> "" THEN
                        IF _FILEEXISTS(dir$ + "actions\" + k$ + "." + filetype$) THEN
                            OPEN dir$ + "actions\" + k$ + "." + filetype$ FOR INPUT AS #1
                            IF EOF(1) THEN SYSTEM
                            LINE INPUT #1, part$
                            CLOSE #1
                            GOTO 1
                        ELSE SYSTEM
                        END IF
                    END IF
                END IF

            LOOP UNTIL INKEY$ <> ""
            SYSTEM
        ELSEIF action$ = "continue" THEN
            SLEEP
            DO
                _LIMIT limitnum

                'Actions Stuff
                k$ = INKEY$
                IF k$ <> "" THEN
                    IF _DIREXISTS(dir$ + "actions") THEN
                        IF _FILEEXISTS(dir$ + "actions\" + k$ + "." + filetype$) THEN
                            OPEN dir$ + "actions\" + k$ + "." + filetype$ FOR INPUT AS #1
                            IF EOF(1) THEN SYSTEM
                            LINE INPUT #1, part$
                            CLOSE #1
                            GOTO 1
                        ELSE GOTO 2
                        END IF
                    END IF
                ELSE GOTO 2
                END IF
            LOOP
            2
            IF _FILEEXISTS(dir$ + "goto." + filetype$) THEN
                OPEN dir$ + "goto." + filetype$ FOR INPUT AS #1
                IF EOF(1) THEN SYSTEM
                LINE INPUT #1, part$
                CLOSE #1
                GOTO 1
            ELSE SYSTEM
            END IF
        ELSE SYSTEM
        END IF
    ELSE SYSTEM
    END IF
ELSE SYSTEM
END IF
SYSTEM
