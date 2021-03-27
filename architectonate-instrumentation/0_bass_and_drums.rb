fade = :stop
#fade = :in
#fade = :none
#fade = :out
# :none, :in, :out, :stop
intr_whistle = (bool_c :f)


if fade == :in or fade == :stop
  fade_in = 0.0
else
  fade_in = 1.0
end

if intr_whistle
  length = 1
  fade = :none
  ding = play :e5, cutoff: 80, release: 1, attack: 0.5,
    cutoff_attack: 0.01, cutoff_release: 0.5, amp: 0.75, res: 0.7, note_slide: 1
  control ding, note: :e1
  wait 0.5
  
  whistle length
  wait 0.5
end

live_loop :squelch do
  use_synth :tb303
  n = (ring :e1, :e2, :e3, :a0).tick
  play n, release: 0.125, cutoff: 60 + fade_in * 40, res: 0.8 - fade_in * 0.1,
    pan: -0.5 * ((look % 2) == 0 ? -1 : 1)
  sync "/live_loop/drums"
end



in_thread do
  if fade == :in
    while fade_in <= 1.0
      fade_in += 0.04
      wait 0.2
    end
  elsif fade == :out
    while fade_in >= 0
      fade_in -= 0.04
      wait 0.2
    end
  end
end
# c d e f g a b

#               1  e  &  e  2  e  &  e  3  e  &  e  4  e  &  e

#               1  &  2  &  3  &  4  &
snare   = (ring 1, 1, 0, 1, 0, 0, 0, 0)
hi_h    = (ring 0, 1, 0, 1, 0, 1, 1, 0)
kick    = (ring 0, 0, 0, 1, 0, 0, 0, 1)



live_loop :drums do
  if bool_c :f and snare.tick(:snare) == 1
    sample :drum_snare_soft, amp: 1, pan: -0.1
  end
  if bool_c :f and hi_h.tick(:hi) == 1
    sample :drum_cymbal_closed, pan: 0.1
  end
  if bool_c :f and kick.tick(:cow) == 1
    sample :drum_heavy_kick, amp: 2, pan: 0, rate: 1.1, hpf: 30, lpf: 110
  end
  sleep (1.0 / 8.0)
end


