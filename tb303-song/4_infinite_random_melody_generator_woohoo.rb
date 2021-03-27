#gererate random melody functions
use_random_seed 330

# generates a 2 bars of melody based of a scale
#
# the fist part consits of 6 notes which is repeted across 2 bars,
# the fist note of this part is randomly chose, and each consequent
# note is either 1 up or 1 down on the scale from the previus note
#
# the 7th note is random, and could be difeerent across the 2 bars
# the 8th note is always a rest
define :qa_melody do |scale|
  common_part = [] #empty list
  # add random initial note from the scale
  common_part.append(rrand_i(0, scale.length - 1))
  direction = ((one_in 2) ? -1 : 1)
  puts common_part.last
  5.times do
    common_part.append(common_part.last + direction)
    # one in 5 chace to change dirrection
    direction = ((one_in 4) ? -1 * direction : direction)
  end
  symbolic_mel = []
  symbolic_mel += common_part
  #add a random ending note froms scale
  symbolic_mel.append(rrand_i(0, scale.length - 1))
  symbolic_mel.append(:rest) #rest at the end
  symbolic_mel += common_part
  #add a different(or maybe the same) random ending note froms scale
  symbolic_mel.append(rrand_i(0, scale.length - 1))
  symbolic_mel.append(:rest) #rest at the end
  
  #translate symbolic numbers using the provided scale
  final_mel = []
  for symbol in symbolic_mel
    final_mel.append(symbol == :rest ? :rest : scale[symbol])
  end
  final_mel #return final melody
end















fade = :in
# :none, :in, :out

if fade == :in
  fade_in = 0.0
else
  fade_in = 1.0
end

with_fx :reverb, room: 0.9 do
  
  live_loop :melody_player do
    use_synth :pulse
    melody = qa_melody(scale :e4, :minor_pentatonic)
    #puts melody.length
    16.times do
      sync_rest 0.25, look, 16, "/live_loop/drums"#"/cue/mellol"
      play melody.tick, release: 0.35, pulse_width: 0.2, attack: 0.07, amp: fade_in
    end
  end
end



in_thread do
  if fade == :in
    while fade_in <= 1.0
      fade_in += 0.02r
      fade_in = (fade_in > 1)? 1 : fade_in
      wait 0.2
    end
  elsif fade == :out
    while fade_in >= 0
      fade_in -= 0.042
      fade_in = (fade_in < 0)? 0 : fade_in
      wait 0.2
    end
  end
end