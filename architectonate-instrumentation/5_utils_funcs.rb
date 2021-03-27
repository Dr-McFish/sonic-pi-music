# Welcome to Sonic Pi

define :chord_scale do |tonic, scale|
  [
    :r,
    (chord_degree, :i, tonic, scale, 3),
    (chord_degree, :ii, tonic, scale, 3),
    (chord_degree, :iii, tonic, scale, 3),
    (chord_degree, :iv, tonic, scale, 3),
    (chord_degree, :v, tonic, scale, 3),
    (chord_degree, :vi, tonic, scale, 3),
    (chord_degree, :vii, tonic, scale, 3)
  ]
end

define :bool_c do |expr|
  if expr == :t or expr == :on
    true
  else # prefferable to use :off or :f for false
    false
  end
end

define :sliding_beep do |length|
  s = synth :pulse, note: 30, note_slide: length, release: length,
    cutoff: 100, cutoff_attack: 0.01, pulse_width: 0.9
  control s, note: 125
  s = synth :tb303, note: 30, note_slide: length, release: length,
    cutoff: 130, cutoff_attack: 0.01, cutoff_sustain: length, pulse_width: 0.9
  control s, note: 125
end
