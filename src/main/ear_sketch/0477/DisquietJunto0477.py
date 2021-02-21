#		python code
#		script_name: Disquiet Junto 0477
#
#		author: Paul Reiners
#		description: The Assignment: Record a piece of music in which some substantial portion is 
#                performed without looking.
#
# Set up
from earsketch import *

init()
bpm = 116
setTempo(bpm)

# Music
kick = OS_KICK01
cymbal = OS_CLOSEDHAT01
snare = OS_SNARE01
tom = OS_LOWTOM01

bassLines = [EIGHT_BIT_ATARI_BASSLINE_001, EIGHT_BIT_ATARI_BASSLINE_002,
             EIGHT_BIT_ATARI_BASSLINE_003, EIGHT_BIT_ATARI_BASSLINE_004,
             EIGHT_BIT_ATARI_BASSLINE_005]
sfxs = [EIGHT_BIT_ATARI_SFX_001, EIGHT_BIT_ATARI_SFX_002, 
        EIGHT_BIT_ATARI_SFX_003, EIGHT_BIT_ATARI_SFX_004,
        EIGHT_BIT_ATARI_SFX_005, EIGHT_BIT_ATARI_SFX_006,
        EIGHT_BIT_ATARI_SFX_007, EIGHT_BIT_ATARI_SFX_008,
        EIGHT_BIT_ATARI_SFX_009, EIGHT_BIT_ATARI_SFX_010,
        EIGHT_BIT_ATARI_SFX_011, EIGHT_BIT_ATARI_SFX_012,
        EIGHT_BIT_ATARI_SFX_013]

for i in range(1, 65):
  kick_beat =   shuffleString("00000000--------")
  tom_beat =    shuffleString("0000------------")
  snare_beat =  shuffleString("000-------------")
  cymbal_beat = shuffleString("0---------------")
  makeBeat(kick, 1, i, kick_beat)
  makeBeat(tom, 2, i, tom_beat)
  makeBeat(snare, 3, i, snare_beat)
  makeBeat(cymbal, 4, i, cymbal_beat)

shuffledSfxs = shuffleList(sfxs)
for i in range(1, 33):
  shuffledBassLines = shuffleList(bassLines)
  fitMedia(shuffledBassLines[0], 5, 2 * (i - 1) + 1, 2 * i + 1)
  fitMedia(shuffledSfxs[0], 6, 2 * (i - 1) + 1, 2 * i + 1)
  shuffledSfxs = shuffleList(shuffledSfxs)
  
millisecondsPerBeat = 1000.0 * 60.0 / bpm
print millisecondsPerBeat

fitMedia(PAULREINERS_CONAT_PROJECT__ENGLISH_LADY, 7, 1, 14)
setEffect(7, DELAY, DELAY_TIME, 0.5 * millisecondsPerBeat)

fitMedia(PAULREINERS_CONAT__PROJECT_YANKEE_HOTEL_FOXTROT, 8, 18, 31)
setEffect(8, DELAY, DELAY_TIME, millisecondsPerBeat)

fitMedia(PAULREINERS_CONAT_PROJECT_ENGLISH_LADY_00000_ENDING, 9, 35, 48)
setEffect(9, DELAY, DELAY_TIME, 2 * millisecondsPerBeat)

fitMedia(PAULREINERS_CONAT_PROJECT_CZECH_LADY, 10, 52, 64)
setEffect(10, DELAY, DELAY_TIME, 4 * millisecondsPerBeat)

# begin fade out
for i in range(2, 7):
  setEffect(i, VOLUME, GAIN, 0, 64, -60, 65)
  
# Add silence for delay to go down.
kick_beat =   "0---0---0---0---"
for i in range(65, 69):
  makeBeat(kick, 1, i, kick_beat)
setEffect(1, VOLUME, GAIN, 0, 65, -60, 69)

# Finish
finish()
