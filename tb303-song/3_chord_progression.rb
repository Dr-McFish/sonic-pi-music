# Welcome to Sonic Pi

#use_bpm 40
# minor scale notes:  W H W W H W W
# minor scale chords: i, ii°, III, iv, v, VI, VII
# example: E minor:   E  F#   G    A   B  C   D
#                  v
#                     Em F#dimG    Am  Bm C   D

define :e_minor_ch do |degree|
  chord_degree degree, :E3, :minor, 3
end

e_minchsc = chord_scale :E3, :minor

progresion = (ring
              e_minchsc[1],
              e_minchsc[5],
              e_minchsc[4],
              e_minchsc[6],
              e_minchsc[1],
              e_minchsc[3],
              e_minchsc[4],
              e_minchsc[7]
              )

percent_on = 1

live_loop :chords do
  sync_rest 2, look, 8, "/live_loop/drums"
  use_synth :tb303
  use_synth_defaults cutoff: (90 + rrand(0, 5)) * percent_on, cutoff_attack: 1, cutoff_attack_level: 0.5,
    cutoff_sustain_level: 0.5, res: 0.4 + rrand(0, 0.05), amp: 2
  play progresion.tick, attack: 0.01, release: 2#, attack: 0.2, sustain: 0.75, release: 0.51
end


