fade = :in
# :none, :in, :out

if fade == :in
  fade_in = 0.0
else
  fade_in = 1.0
end

with_fx :reverb, room: 1, mix: 0.0, damp: 0.7 do
  live_loop :magic do
    use_random_seed 4 #i like 4 and 1
    use_synth :prophet
    sc = scale :e4, :minor_pentatonic
    riff = shuffle (ring sc.pick, sc.pick, sc.pick, :E4, :E4, sc.pick)
    4.times do
      sync_rest 0.25, look, 4, "/live_loop/drums"
      play riff.tick, amp: 0.7, res: 0.7, #+ rrand(-0.7, 0)
        cutoff: 45 + 65 * fade_in, release: 1
    end
    #sleep 1
  end
end
#stop

if fade == :in
  while fade_in <= 1.0
    fade_in += 0.02
    wait 0.2
  end
elsif fade == :out
  while fade_in >= 0.0
    fade_in -= 0.02
    wait 0.2
  end
end


stop
